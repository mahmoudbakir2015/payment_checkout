import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:payment_checkout/controller/cubit/auth/auth_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_checkout/presentation/auth/login/login.dart';
import '../../../constants/strings/api_keys.dart';
import '../../../core/utils/api_service.dart';
import '../../../core/utils/cache_helper.dart';
import '../../../data/model/create_customer/create_customer_model.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final ApiService apiService = ApiService();
  UserCredential? credential;
  String customerId = '';
  bool obscureText = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final formKeyLogin = GlobalKey<FormState>();
  final formKeyRegister = GlobalKey<FormState>();

  void changeObscure() {
    obscureText = !obscureText;
    emit(ChangeObscure());
  }

  void createEmail({
    required String emailAddress,
    required String password,
  }) async {
    emit(AuthLoadingRegister());

    credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    )
        .then((value) async {
      var response = await apiService.post(
        body: {
          'email',
          email.text,
        },
        contentType: Headers.formUrlEncodedContentType,
        url: 'https://api.stripe.com/v1/customers',
        token: ApiKeys.stripeSecretKey,
      );

      var customerModel = CreateCustomerModel.fromJson(response.data);
      emit(AuthLoadingRegister());
      await users.doc(value.user?.uid).set({
        'email': emailAddress,
        'customerId': customerModel.id.toString(),
      });

      await CacheHelper.saveData(key: 'isCreated', value: true);
      var uid = await CacheHelper.saveData(key: 'uid', value: value.user!.uid)
          .toString();
      print(
          '******** from register Screen${CacheHelper.getDataBool(key: 'isCreated')}');
      emit(AuthSuccessRegister(uid: uid));
    }).catchError((error) {
      emit(AuthFailureRegister(errorMessage: error.toString()));
    });
  }

  void login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoadingLogin());

    credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      await CacheHelper.saveData(key: 'isCreated', value: true);
      var uid = await CacheHelper.saveData(key: 'uid', value: value.user!.uid)
          .toString();
      emit(AuthSuccessLogin(uid: uid));

      print(
          '******** from login Screen ${CacheHelper.getDataBool(key: 'isCreated')}');
    }).catchError((error) {
      emit(AuthFailureLogin(errorMessage: error.toString()));
    });
  }

  Future<void> logOut({required context}) async {
    await FirebaseAuth.instance.signOut();
    await CacheHelper.saveData(key: 'isCreated', value: false);
    print(CacheHelper.getDataBool(key: 'isCreated'));
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false);
    emit(AuthInitial());
  }
}
