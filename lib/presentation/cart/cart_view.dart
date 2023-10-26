import 'package:flutter/material.dart';
import 'package:payment_checkout/presentation/cart/cart_items.dart';
import '../../core/widgets.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';

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
                showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
                    context: (context),
                    builder: (context) {
                      return const BottomSheetView();
                    });
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) => const PaymentDetails(),
                //   ),
                // );
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
          CustomButton(text: 'complete'),
        ],
      ),
    );
  }
}
