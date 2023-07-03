class ConsultationTransaction {
  String uid;
  String consultantId;
  String? consultantImg;
  String? consultantName;
  String? consultantCategory;
  int? consultantPrice;
  String scheduleId;
  String? fixScheduleTime;
  DateTime consultationStartDate;
  DateTime consultationEndDate;
  int? totalPrice;

  ConsultationTransaction({
    required this.uid,
    required this.consultantId,
    this.consultantImg,
    this.consultantName,
    this.consultantCategory,
    this.consultantPrice,
    required this.scheduleId,
    this.fixScheduleTime,
    required this.consultationStartDate,
    required this.consultationEndDate,
    this.totalPrice,
  });
}
