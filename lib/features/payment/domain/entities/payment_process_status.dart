enum PaymentProcessStatus {
  noPaymentProcess,
  createOrder,
  checkMoney,
  success,
  error,
}

extension PaymentProcessStatusX on PaymentProcessStatus {
  bool get isIdle => this == PaymentProcessStatus.noPaymentProcess;

  bool get isInProgress =>
      this == PaymentProcessStatus.createOrder ||
      this == PaymentProcessStatus.checkMoney;

  bool get isTerminal =>
      this == PaymentProcessStatus.success ||
      this == PaymentProcessStatus.error;
}
