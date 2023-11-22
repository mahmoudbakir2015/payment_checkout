import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_checkout/controller/cubit/payment/payment_cubit.dart';

import '../constants/styles/color_styles.dart';
import '../constants/styles/text_styles.dart';
import '../presentation/payment_details/payment_details_items.dart';

class ListViewCard extends StatefulWidget {
  const ListViewCard({super.key});

  @override
  State<ListViewCard> createState() => _ListViewCardState();
}

class _ListViewCardState extends State<ListViewCard> {
  List<String> imagePath = [
    'assets/images/card.svg',
    'assets/images/paypal.svg',
  ];

  int active = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 32,
        top: 10,
      ),
      child: SizedBox(
        height: 62,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              active = index;
              if (active == 0) {
                BlocProvider.of<PaymentCubit>(context).isStripe = true;
              } else {
                BlocProvider.of<PaymentCubit>(context).isStripe = false;
              }
              setState(() {});
            },
            child: CustomPaymentType(
              image: imagePath[index],
              isActive: active == index,
            ),
          ),
          separatorBuilder: (context, index) => const SizedBox(
            width: 20,
          ),
          itemCount: imagePath.length,
        ),
      ),
    );
  }
}

Padding buildTotalPrice({required String price}) {
  return Padding(
    padding: const EdgeInsets.only(
      bottom: 16,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Total',
          textAlign: TextAlign.center,
          style: MyTextStyle.style24,
        ),
        Text(
          '\$$price',
          textAlign: TextAlign.center,
          style: MyTextStyle.style24,
        )
      ],
    ),
  );
}

Padding myDivider() {
  return Padding(
    padding: const EdgeInsets.symmetric(
      vertical: 14,
    ),
    child: Container(
      width: 320,
      decoration: const ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 2,
            strokeAlign: BorderSide.strokeAlignCenter,
            color: MyColors.secondaryColor,
          ),
        ),
      ),
    ),
  );
}
