import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_checkout/presentation/auth/register/register.dart';
import 'package:payment_checkout/presentation/cart/cart_view.dart';
import '../../../controller/cubit/auth/auth_cubit.dart';
import '../../../controller/cubit/auth/auth_states.dart';
import '../../../core/utils/cache_helper.dart';
import '../../../widgets/default_text_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
      if (state is AuthSuccessLogin) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => CartView(
                      uid: CacheHelper.getData(key: 'uid')!,
                    )),
            (route) => false);
      }
      if (state is AuthFailureLogin) {
        // Display error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.errorMessage)),
        );
      }
    }, builder: (context, state) {
      return Scaffold(
        body: Form(
          key: BlocProvider.of<AuthCubit>(context).formKeyLogin,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                defaultTextForm(
                  controller: BlocProvider.of<AuthCubit>(context).email,
                  label: 'Email',
                  textInputType: TextInputType.emailAddress,
                  iconData: Icons.email,
                  onValidate: (String? value) {
                    if (value!.isEmpty) {
                      return 'this field not be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                defaultTextForm(
                  onTap: () {
                    BlocProvider.of<AuthCubit>(context).changeObscure();
                  },
                  obscureText: BlocProvider.of<AuthCubit>(context).obscureText,
                  isSuffix: true,
                  controller: BlocProvider.of<AuthCubit>(context).password,
                  label: 'Password',
                  textInputType: TextInputType.visiblePassword,
                  iconData: Icons.password,
                  onValidate: (String? value) {
                    if (value!.isEmpty) {
                      return 'this field not be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    if (state is AuthLoadingLogin) {
                      return const CircularProgressIndicator();
                    } else {
                      return ElevatedButton(
                        child: const Text('Sign In'),
                        onPressed: () {
                          if (BlocProvider.of<AuthCubit>(context)
                              .formKeyLogin
                              .currentState!
                              .validate()) {
                            BlocProvider.of<AuthCubit>(context).login(
                              email: BlocProvider.of<AuthCubit>(context)
                                  .email
                                  .text,
                              password: BlocProvider.of<AuthCubit>(context)
                                  .password
                                  .text,
                            );
                          }
                        },
                      );
                    }
                  },
                ),
                ElevatedButton(
                  child: const Text('Sign Up'),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const RegisterScreen()));
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
