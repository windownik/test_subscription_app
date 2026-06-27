enum PaymentProcessStatus {
  noPaymentProcess,
  createOrder,
  checkMoney,
  success,
  error,
}

extension PaymentProcessStatusX on PaymentProcessStatus {
  bool get isIdle => this == PaymentProcessStatus.noPaymentProcess;
}
