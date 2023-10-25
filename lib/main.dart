import 'package:flutter/material.dart';
import 'package:payment_checkout/presentation/cart/cart_view.dart';

void main() {
  runApp(const PaymentPage());
}

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'PaypalPaymentDemp',
      debugShowCheckedModeBanner: false,
      home: CartView(),
    );
  }
}
