import 'package:flutter/material.dart';
import 'package:payment_checkout/presentation/payment_details/payment_details_items.dart';
import 'package:payment_checkout/widgets/custom_button.dart';
import '../../widgets/custom_app_bar.dart';
import '../payment_done/payment_done_view.dart';

class PaymentDetails extends StatefulWidget {
  const PaymentDetails({super.key});

  @override
  State<PaymentDetails> createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: 'Payment Details',
        context: context,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            const SliverToBoxAdapter(
              child: ListViewCard(),
            ),
            SliverToBoxAdapter(
              child: CreditCard(
                formKey: formKey,
                autovalidateMode: autovalidateMode,
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 12,
                    ),
                    child: CustomButton(
                      text: 'Pay',
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const PaymentDoneView(),
                            ),
                          );
                        } else {
                          autovalidateMode = AutovalidateMode.always;
                          setState(() {});
                        }
                      },
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
