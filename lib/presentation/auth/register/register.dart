import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_checkout/presentation/cart/cart_view.dart';

import '../../../controller/cubit/auth/auth_cubit.dart';
import '../../../controller/cubit/auth/auth_states.dart';
import '../../../widgets/default_text_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
      if (state is AuthSuccessRegister) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const CartView()),
            (route) => false);
      }
      if (state is AuthFailureRegister) {
        // Display error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.errorMessage)),
        );
      }
    }, builder: (context, state) {
      return Scaffold(
        body: Form(
          key: BlocProvider.of<AuthCubit>(context).formKeyRegister,
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
                    if (state is AuthLoadingRegister) {
                      return const CircularProgressIndicator();
                    } else {
                      return ElevatedButton(
                        child: const Text('Sign Up'),
                        onPressed: () {
                          if (BlocProvider.of<AuthCubit>(context)
                              .formKeyRegister
                              .currentState!
                              .validate()) {
                            BlocProvider.of<AuthCubit>(context).createEmail(
                              emailAddress: BlocProvider.of<AuthCubit>(context)
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
              ],
            ),
          ),
        ),
      );
    });
  }
}
