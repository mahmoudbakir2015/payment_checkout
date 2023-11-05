import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_checkout/core/utils/api_service.dart';
import 'package:payment_checkout/data/model/payment_intent_model/payment_intent_model.dart';

import '../../constants/strings/endpoints.dart';
import '../model/payment_input/payment_input.dart';

class StripeService {
  Future<PaymentIntentModel> createPaymentIntent(
      PaymentInput paymentInput) async {
    Response response = await DioHelper.postData(
      endPoint: paymentIntents,
      data: paymentInput.toJson(),
    );
    return PaymentIntentModel.fromJson(response.data);
  }

  Future initPaymentSheet({required String paymentIntentClientSecret}) async {
    Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: 'mahmoudbakir'),
    );
  }

  Future displayPaymentSheet() async {
    Stripe.instance.presentPaymentSheet();
  }

  Future makePayment({
    required PaymentInput paymentInput,
  }) async {
    var paymentIntentInputModel = await createPaymentIntent(paymentInput);
    await initPaymentSheet(
        paymentIntentClientSecret: paymentIntentInputModel.clientSecret!);
    await displayPaymentSheet();
  }
}
