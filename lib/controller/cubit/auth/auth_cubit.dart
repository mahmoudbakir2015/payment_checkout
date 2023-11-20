import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:payment_checkout/controller/cubit/auth/auth_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_checkout/presentation/auth/login/login.dart';

import '../../../core/utils/cache_helper.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);
  UserCredential? credential;
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
      await CacheHelper.saveData(key: 'isCreated', value: true);
      print(
          '******** from register Screen${CacheHelper.getDataBool(key: 'isCreated')}');
      emit(AuthSuccessRegister());
    }).catchError((error) {
      emit(AuthFailureRegister(errorMessage: error.toString()));
    });
  }

  void login({required String email, required String password}) async {
    emit(AuthLoadingLogin());

    credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      await CacheHelper.saveData(key: 'isCreated', value: true);
      print(
          '******** from login Screen ${CacheHelper.getDataBool(key: 'isCreated')}');
      emit(AuthSuccessLogin());
    }).catchError((error) {
      emit(AuthFailureLogin(errorMessage: error.toString()));
    });
  }

  Future<void> logout({required context}) async {
    await FirebaseAuth.instance.signOut();
    await CacheHelper.saveData(key: 'isCreated', value: false);
    print(CacheHelper.getData(key: 'isCreated'));
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false);
    emit(AuthInitial());
  }
}
