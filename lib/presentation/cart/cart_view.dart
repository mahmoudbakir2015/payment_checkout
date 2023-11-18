import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_checkout/constants/strings/api_keys.dart';
import 'package:payment_checkout/controller/cubit/payment_states.dart';
import 'package:payment_checkout/data/model/payment_input/payment_input.dart';
import 'package:payment_checkout/presentation/cart/cart_items.dart';
import '../../controller/cubit/payment_cubit.dart';
import '../../core/widgets.dart';
import '../../data/repo/check_out_repo_imp.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../payment_done/payment_done_view.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: 'My Cart',
        context: context,
        isNotCart: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          children: [
            Expanded(
              child: Image.asset('assets/images/my_item.png'),
            ),
            const SizedBox(
              height: 25,
            ),
            buildDetailsPay(
              text: 'Order Subtotal',
              price: '42.97',
            ),
            buildDetailsPay(
              text: 'Discount',
              price: '0',
            ),
            buildDetailsPay(
              text: 'Shipping',
              price: '8',
            ),
            myDivider(),
            buildTotalPrice(
              price: '50.97',
            ),
            CustomButton(
              onTap: () {
                showModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  context: (context),
                  builder: (context) {
                    return BlocProvider(
                      create: (context) => PaymentCubit(CheckoutRepoImp()),
                      child: const BottomSheetView(),
                    );
                  },
                );
              },
              text: 'Complete Payment',
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class BottomSheetView extends StatelessWidget {
  const BottomSheetView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const ListViewCard(),
          BlocConsumer<PaymentCubit, PaymentStates>(
            listener: (context, state) {
              if (state is PaymentSuccessState) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const PaymentDoneView()));
              }
              if (state is PaymentFailedState) {
                Navigator.of(context).pop();
                SnackBar snackBar = SnackBar(content: Text(state.errorMessage));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            builder: (context, state) {
              return CustomButton(
                onTap: () {
                  PaymentInput paymentInput = PaymentInput(
                    amount: '100',
                    currency: 'USD',
                    customerId: ApiKeys.customerId,
                  );
                  BlocProvider.of<PaymentCubit>(context)
                      .makePayment(paymentIntentInput: paymentInput);
                },
                isLoading: state is PaymentLoadingState ? true : false,
                text: 'complete',
              );
            },
          ),
        ],
      ),
    );
  }
}
