import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_checkout/core/utils/api_service.dart';
import 'package:payment_checkout/data/model/payment_intent_model/payment_intent_model.dart';

import '../../constants/strings/api_keys.dart';
import '../model/payment_input/payment_input.dart';

class StripeService {
  final ApiService apiService = ApiService();
  Future<PaymentIntentModel> createPaymentIntent(
      PaymentInput paymentIntentInputModel) async {
    var response = await apiService.post(
      body: paymentIntentInputModel.toJson(),
      contentType: Headers.formUrlEncodedContentType,
      url: 'https://api.stripe.com/v1/payment_intents',
      token: ApiKeys.stripeSecretKey,
    );

    var paymentIntentModel = PaymentIntentModel.fromJson(response.data);

    return paymentIntentModel;
  }

  Future initPaymentSheet({required String paymentIntentClientSecret}) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntentClientSecret,
        merchantDisplayName: 'mahmoudbakir',
      ),
    );
  }

  Future displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
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



/**
 * Future<PaymentIntentModel> createPaymentIntent(
      PaymentInput paymentInput) async {
    Response response = await DioHelper.postData(
      endPoint: paymentIntents,
      data: paymentInput.toJson(),
    );
    return PaymentIntentModel.fromJson(response.data);
  }
 */