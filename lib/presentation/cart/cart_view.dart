import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_checkout/constants/strings/api_keys.dart';
import 'package:payment_checkout/controller/cubit/auth/auth_cubit.dart';
import 'package:payment_checkout/controller/cubit/payment/payment_states.dart';
import 'package:payment_checkout/data/model/payment_input/payment_input.dart';
import 'package:payment_checkout/presentation/cart/cart_items.dart';
import '../../controller/cubit/payment/payment_cubit.dart';
import '../../core/widgets.dart';
import '../../data/model/paybal_model/amount_model.dart';
import '../../data/model/paybal_model/items_model.dart';
import '../../data/repo/check_out_repo_imp.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../payment_done/payment_done_view.dart';
import 'dart:developer';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';

// ignore: must_be_immutable
class CartView extends StatelessWidget {
  final String uid;
  const CartView({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          title: 'My Cart',
          context: context,
          isNotCart: false,
          actions: [
            GestureDetector(
                onTap: () {
                  BlocProvider.of<AuthCubit>(context).logOut(context: context);
                },
                child: const Icon(
                  Icons.exit_to_app,
                )),
          ]),
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
              onTap: () async {
                DocumentReference docRef =
                    FirebaseFirestore.instance.collection('users').doc(uid);
                DocumentSnapshot doc = await docRef.get();
                // ignore: use_build_context_synchronously
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
                      child: BottomSheetView(
                        customerId: doc.get('customerId').toString(),
                      ),
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
  final String customerId;

  const BottomSheetView({super.key, required this.customerId});

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
                showSnackBar(messages: state.errorMessage, context: context);
              }
            },
            builder: (context, state) {
              return CustomButton(
                onTap: () async {
                  if (BlocProvider.of<PaymentCubit>(context).isStripe == true) {
                    // to check card in stripe
                    PaymentInput paymentInput = PaymentInput(
                      amount: '100',
                      currency: 'USD',
                      customerId: customerId,
                    );
                    BlocProvider.of<PaymentCubit>(context).makePaymentStripe(
                        paymentIntentInput: paymentInput,
                        context: context,
                        customerId: customerId);
                  } else {
                    var amountPaybalModel = AmountPaybalModel(
                      total: '100',
                      currency: 'USD',
                      details: Details(
                        subtotal: '100',
                        shipping: '0',
                        shippingDiscount: 0,
                      ),
                    );
                    var itemsPaybalModel = ItemsPaybalModel(items: [
                      Items(
                          name: 'bag',
                          quantity: 1,
                          price: '20',
                          currency: 'USD'),
                      Items(
                          name: 'book',
                          quantity: 1,
                          price: '40',
                          currency: 'USD'),
                      Items(
                          name: 'chair',
                          quantity: 1,
                          price: '20',
                          currency: 'USD'),
                      Items(
                          name: 'desk',
                          quantity: 1,
                          price: '10',
                          currency: 'USD'),
                      Items(
                          name: 'pen',
                          quantity: 1,
                          price: '10',
                          currency: 'USD'),
                    ]);
// to check payment Paybal
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => PaypalCheckoutView(
                        sandboxMode: true,
                        clientId: ApiKeys.clientPaybalId,
                        secretKey: ApiKeys.clientPaybalSecret,
                        transactions: [
                          {
                            "amount": amountPaybalModel.toJson(),
                            "description":
                                "The payment transaction description.",
                            "item_list": itemsPaybalModel.toJson(),
                          }
                        ],
                        note: "Contact us for any questions on your order.",
                        onSuccess: (Map params) async {
                          log("onSuccess: $params");
                          Navigator.pop(context);
                        },
                        onError: (error) {
                          showSnackBar(
                              messages: error.toString(), context: context);
                          log("onError: $error");

                          Navigator.pop(context);
                        },
                        onCancel: () {
                          Navigator.pop(context);
                        },
                      ),
                    ));
                  }
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

  void showSnackBar({required String messages, required BuildContext context}) {
    SnackBar snackBar = SnackBar(content: Text(messages));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
