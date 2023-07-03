class ConfirmConsultationPayment {
  String historyId;
  String consultantId;
  String? consultantImg;
  String? consultantName;
  String? consultantCategory;
  int? consultantPrice;
  String? fixScheduleTime;
  int? totalPrice;
  String? paymentMethod;

  ConfirmConsultationPayment({
    required this.historyId,
    required this.consultantId,
    this.consultantImg,
    this.consultantName,
    this.consultantCategory,
    this.consultantPrice,
    this.fixScheduleTime,
    this.totalPrice,
    this.paymentMethod,
  });
}
