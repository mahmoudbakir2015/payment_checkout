import 'package:flutter/material.dart';
import 'package:payment_checkout/presentation/cart/cart_items.dart';
import '../../core/widgets.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../payment_details/payment_details_view.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          customAppBar(title: 'My Cart', context: context, isNotCart: false),
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
            buildDetailsPay(text: 'Order Subtotal', price: '42.97'),
            buildDetailsPay(text: 'Discount', price: '0'),
            buildDetailsPay(text: 'Shipping', price: '8'),
            myDivider(),
            buildTotalPrice(price: '50.97'),
            CustomButton(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const PaymentDetails(),
                  ),
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
