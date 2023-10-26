import 'package:flutter/material.dart';
import 'package:svg_flutter/svg_flutter.dart';

import '../../constants/styles/color_styles.dart';
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
            side: const BorderSide(width: 1.50, color: MyColors.defaultColor),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Center(
          child: Text(
            'PAID',
            textAlign: TextAlign.center,
            style: MyTextStyle.style24.copyWith(
              color: MyColors.defaultColor,
            ),
          ),
        ),
      ),
    ],
  );
}

Padding buidCreditCardInfo(
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

Padding buildDetailsPay({required String title, required String value}) {
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
          value,
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

Positioned buildStatus() {
  return Positioned(
    top: -50,
    left: 0,
    right: 0,
    child: CircleAvatar(
      backgroundColor: MyColors.secondaryColor,
      radius: 50,
      child: CircleAvatar(
        backgroundColor: MyColors.defaultColor,
        radius: 40,
        child: Center(
          child: SvgPicture.asset(
            'assets/images/check.svg',
          ),
        ),
      ),
    ),
  );
}

Positioned buildDashAndCircle(BuildContext context) {
  return Positioned(
      bottom: MediaQuery.of(context).size.height * 0.15,
      left: -20,
      right: -20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildCircle(),
          buildDashLine(),
          buildCircle(),
        ],
      ));
}

Expanded buildDashLine() {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        height: 2,
        child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(
            width: 2,
          ),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              color: MyColors.dashColor,
              width: 7,
            );
          },
          itemCount: 40,
        ),
      ),
    ),
  );
}

CircleAvatar buildCircle() {
  return const CircleAvatar(
    backgroundColor: Colors.white,
  );
}
