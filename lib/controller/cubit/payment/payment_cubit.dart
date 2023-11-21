import 'package:payment_checkout/controller/cubit/payment/payment_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_checkout/data/repo/check_out_repo.dart';

class PaymentCubit extends Cubit<PaymentStates> {
  final CheckOutRepo checkOutRepo;
  PaymentCubit(this.checkOutRepo) : super(PaymentInitialState());
  static PaymentCubit get(context) => BlocProvider.of(context);

  Future makePayment(
      {required paymentIntentInput,
      required context,
      required String customerId}) async {
    emit(PaymentLoadingState());
    var data = await checkOutRepo.makePayment(
        paymentInput: paymentIntentInput,
        context: context,
        customerId: customerId);
    data.fold(
      (l) => emit(PaymentFailedState(errorMessage: l.errMessage)),
      (r) => emit(PaymentSuccessState()),
    );
  }
}
