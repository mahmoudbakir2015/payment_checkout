import 'package:payment_checkout/controller/cubit/payment/payment_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_checkout/data/repo/check_out_repo.dart';

class PaymentCubit extends Cubit<PaymentStates> {
  final CheckOutRepo checkOutRepo;
  bool isStripe = true;
  PaymentCubit(this.checkOutRepo) : super(PaymentInitialState());
  static PaymentCubit get(context) => BlocProvider.of(context);

  Future makePaymentStripe(
      {required paymentIntentInput,
      required context,
      required String customerId}) async {
    emit(PaymentLoadingState());
    var data = await checkOutRepo.makePaymentStripe(
        paymentInput: paymentIntentInput, customerId: customerId);
    data.fold(
      (l) => emit(PaymentFailedState(errorMessage: l.errMessage)),
      (r) => emit(PaymentSuccessState()),
    );
  }
}
