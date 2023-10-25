import 'package:flutter/material.dart';
import 'package:payment_checkout/presentation/payment_done/payment_done_items.dart';
import 'package:svg_flutter/svg_flutter.dart';

import '../../constants/styles/text_styles.dart';
import '../../core/widgets.dart';

class PaymentDoneView extends StatelessWidget {
  const PaymentDoneView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Stack(
          children: [
            buildBack(context),
            Center(
              child: Container(
                width: 350,
                height: 672,
                decoration: ShapeDecoration(
                  color: const Color(0xFFD9D9D9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 66,
                      ),
                      const Text(
                        'Thank you!',
                        textAlign: TextAlign.center,
                        style: MyTextStyle.style25,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 2,
                          bottom: 42,
                        ),
                        child: Text(
                          'Your transaction was successful',
                          textAlign: TextAlign.center,
                          style: MyTextStyle.style20,
                        ),
                      ),
                      buildDetailsPay(title: 'Date', answer: '01/24/2023'),
                      buildDetailsPay(title: 'Time', answer: '10:15 AM'),
                      buildDetailsPay(title: 'To', answer: 'Sam Louis'),
                      myDivider(),
                      buildTotalPrice(price: '50.97'),
                      buidTypeCard(
                        image: 'assets/images/mastercard.svg',
                        nameCard: 'Mastercard',
                        last2digit: '78',
                      ),
                      buildDashDivider(),
                      buildBarcodeWithButton(),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 30,
              left: 140,
              child: Container(
                width: 100,
                height: 100,
                decoration: const ShapeDecoration(
                  color: Color(0xFFD9D9D9),
                  shape: OvalBorder(),
                ),
              ),
            ),
            Positioned(
              top: 40,
              left: 150,
              child: Container(
                width: 80,
                height: 80,
                decoration: const ShapeDecoration(
                  color: Color(0xFF34A853),
                  shape: OvalBorder(),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/check.svg',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
