import 'package:cloud_firestore/cloud_firestore.dart';

class ScheduleConsultation {
  String scheduleId;
  String day;
  String startTime;
  String endTime;
  String isAvailable;

  ScheduleConsultation({
    required this.scheduleId,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.isAvailable,
  });

  factory ScheduleConsultation.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return ScheduleConsultation(
      scheduleId: snapshot.id,
      day: data['day'],
      startTime: data['startTime'],
      endTime: data['endTime'],
      isAvailable: data['isAvailable'].toString(),
    );
  }
}
