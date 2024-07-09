import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_checkout/core/utils/api_service.dart';
import 'package:payment_checkout/data/model/payment_intent_model/payment_intent_model.dart';
import '../../constants/strings/api_keys.dart';
import '../model/ephemeral_key_model/ephemeral_key_model.dart';
import '../model/init_payment_sheet_input/init_payment_sheet_input.dart';
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

  Future<EphemeralKeyModel> createEphemeralKey(
      {required String customerId}) async {
    var response = await apiService.post(
      headers: {
        'Stripe-Version': '2024-06-20',
        'Authorization': "Bearer ${ApiKeys.stripeSecretKey}",
      },
      body: {
        'customer': customerId,
      },
      contentType: Headers.formUrlEncodedContentType,
      url: 'https://api.stripe.com/v1/ephemeral_keys',
    );

    var ephemeralKeyModel = EphemeralKeyModel.fromJson(response.data);

    return ephemeralKeyModel;
  }

  Future initPaymentSheet(
      {required InitPaymentInputSheet initPaymentInputSheet}) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        customerId: initPaymentInputSheet.customerId,
        paymentIntentClientSecret: initPaymentInputSheet.clientSecret,
        merchantDisplayName: 'mahmoudbakir',
        customerEphemeralKeySecret:
            initPaymentInputSheet.customerEphemeralKeySecret,
      ),
    );
  }

  Future displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  Future makePayment({
    required PaymentInput paymentInput,
    required String customerId,
  }) async {
    var paymentIntentInputModel = await createPaymentIntent(paymentInput);
    var ephemeralKey = await createEphemeralKey(customerId: customerId);
    InitPaymentInputSheet initPaymentInputSheet = InitPaymentInputSheet(
      clientSecret: paymentIntentInputModel.clientSecret!,
      customerId: paymentInput.customerId,
      customerEphemeralKeySecret: ephemeralKey.secret!,
    );
    await initPaymentSheet(
      initPaymentInputSheet: initPaymentInputSheet,
    );
    await displayPaymentSheet();
  }
}
