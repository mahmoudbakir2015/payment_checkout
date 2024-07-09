import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_checkout/constants/strings/api_keys.dart';
import 'package:payment_checkout/controller/cubit/auth/auth_cubit.dart';
import 'package:payment_checkout/core/observer.dart';
import 'package:payment_checkout/core/utils/cache_helper.dart';
import 'package:payment_checkout/presentation/auth/login/login.dart';
import 'package:payment_checkout/presentation/cart/cart_view.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = ApiKeys.stripePublishableKey;
  await CacheHelper.init();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();

  runApp(const PaymentPage());
}

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
          child: const LoginScreen(),
        ),
      ],
      child: MaterialApp(
        title: 'Payment',
        debugShowCheckedModeBanner: false,
        // ignore: unrelated_type_equality_checks
        home: (CacheHelper.getDataBool(key: 'isCreated') == true)
            ? CartView(
                uid: CacheHelper.getData(key: 'uid')!,
              )
            : const LoginScreen(),
      ),
    );
  }
}
