import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hive_testing/blocs/sendAmount/send_amount_event.dart';
import 'package:flutter_hive_testing/blocs/sendAmount/send_amount_state.dart';
import 'package:flutter_hive_testing/models/send_amount.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

class SendAmountBloc extends Bloc<SendAmountEvent, SendAmountState> {
  final Box<SendAmount> sendAmountBox;

  SendAmountBloc(this.sendAmountBox)
      : super(
          SendAmountLoaded(
            sendAmount:
                sendAmountBox.get('sendAmount') ?? SendAmount(amount: ''),
          ),
        ) {
    on<SendButtonPressed>((event, emit) async {
      final currentState = state;
      if (currentState is SendAmountLoaded) {
        final sendAmount =
            currentState.sendAmount.copyWith(amount: event.amount);
        var uuid = const Uuid();

        String key = uuid.v4();
        await sendAmountBox.put(key, sendAmount);
        emit(SendAmountLoaded(sendAmount: sendAmount));
      }
    });
  }
}
