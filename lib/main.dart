import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_checkout/constants/strings/api_keys.dart';
import 'package:payment_checkout/presentation/cart/cart_view.dart';

void main() async {
  Stripe.publishableKey = ApiKeys.stripePublishableKey;

  runApp(const PaymentPage());
}

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'PaymentDemo',
      debugShowCheckedModeBanner: false,
      home: CartView(),
    );
  }
}
