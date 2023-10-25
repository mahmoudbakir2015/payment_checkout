import 'package:flutter/material.dart';
import 'package:svg_flutter/svg_flutter.dart';

import '../../constants/styles/text_styles.dart';

Row buildBarcodeWithButton() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SvgPicture.asset('assets/images/parcode.svg'),
      Container(
        width: 113,
        height: 58,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1.50, color: Color(0xFF34A853)),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Center(
          child: Text(
            'PAID',
            textAlign: TextAlign.center,
            style: MyTextStyle.style24.copyWith(
              color: const Color(
                0xFF34A853,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

Padding buildDashDivider() {
  return Padding(
    padding: const EdgeInsets.only(
      bottom: 57,
    ),
    child: SizedBox(
      height: 2,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
          width: 2,
        ),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            color: const Color(0xFFB7B7B7),
            width: 7,
          );
        },
        itemCount: 40,
      ),
    ),
  );
}

Padding buidTypeCard(
    {required String image,
    required String nameCard,
    required String last2digit}) {
  return Padding(
    padding: const EdgeInsets.only(
      bottom: 30,
      top: 14,
    ),
    child: Container(
      width: 305,
      height: 73,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: 35.05,
              height: 21.66,
              child: SvgPicture.asset(image),
            ),
          ),
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: 'Credit Card  ',
                  style: MyTextStyle.style18,
                ),
                TextSpan(
                  text: '$nameCard **$last2digit ',
                  style: MyTextStyle.style16,
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

Padding buildDetailsPay({required String title, required String answer}) {
  return Padding(
    padding: const EdgeInsets.only(
      bottom: 20,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: MyTextStyle.style18,
        ),
        Text(
          answer,
          style: MyTextStyle.style18.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

Positioned buildBack(BuildContext context) {
  return Positioned(
    top: 35,
    child: GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: SvgPicture.asset(
        'assets/images/arrow_back.svg',
      ),
    ),
  );
}
