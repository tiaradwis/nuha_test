class ConsultationHistory {
  String historyId;
  String scheduleId;
  String fixDateTimeConsultation;
  String userId;
  String consultantId;
  String paymentStatus;
  String consultantName;
  String consultantCategory;
  String consultantPhoto;
  String proofOfPayment;
  String meetingLink;

  ConsultationHistory({
    required this.historyId,
    required this.scheduleId,
    required this.fixDateTimeConsultation,
    required this.userId,
    required this.consultantId,
    required this.paymentStatus,
    required this.consultantName,
    required this.consultantCategory,
    required this.consultantPhoto,
    required this.proofOfPayment,
    required this.meetingLink,
  });
}
