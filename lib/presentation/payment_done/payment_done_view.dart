import 'package:flutter/material.dart';
import 'package:payment_checkout/presentation/payment_done/payment_done_items.dart';
import '../../constants/styles/color_styles.dart';
import '../../constants/styles/text_styles.dart';
import '../../core/widgets.dart';
import '../../widgets/custom_app_bar.dart';

class PaymentDoneView extends StatelessWidget {
  const PaymentDoneView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context),
      body: Transform.translate(
        offset: Offset(0, -MediaQuery.of(context).size.height * 0.025),
        child: const BodyOfPayDone(),
      ),
    );
  }
}

class BodyOfPayDone extends StatelessWidget {
  const BodyOfPayDone({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        20,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Center(
            child: Container(
              decoration: ShapeDecoration(
                color: MyColors.secondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 20,
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
                    buildDetailsPay(
                      title: 'Date',
                      value: '01/24/2023',
                    ),
                    buildDetailsPay(
                      title: 'Time',
                      value: '10:15 AM',
                    ),
                    buildDetailsPay(
                      title: 'To',
                      value: 'Sam Louis',
                    ),
                    myDivider(),
                    buildTotalPrice(price: '50.97'),
                    buidCreditCardInfo(
                      image: 'assets/images/mastercard.svg',
                      nameCard: 'Mastercard',
                      last2digit: '78',
                    ),
                    const Spacer(),
                    buildBarcodeWithButton(),
                  ],
                ),
              ),
            ),
          ),
          buildDashAndCircle(context),
          buildStatus(),
        ],
      ),
    );
  }
}
