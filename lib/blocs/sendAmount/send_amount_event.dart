abstract class SendAmountEvent {}

class AmountChanged extends SendAmountEvent {
  final String amount;

  AmountChanged({required this.amount});
}

class SendButtonPressed extends SendAmountEvent {
  final String amount;

  SendButtonPressed({required this.amount});
}

class ClearButtonPressed extends SendAmountEvent {}
