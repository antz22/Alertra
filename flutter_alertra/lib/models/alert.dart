class Alert {
  final String priority;
  final String headline;
  final String content;
  final String alertType;
  final String recipient;
  final String school;
  final String time;
  final int? reportId;

  Alert({
    required this.priority,
    required this.headline,
    required this.content,
    required this.alertType,
    required this.recipient,
    required this.school,
    required this.time,
    this.reportId,
  });

  factory Alert.fromJson(Map<String, dynamic> json) {
    return Alert(
      priority: json['priority'],
      headline: json['headline'],
      content: json['content'],
      alertType: json['alert_type'],
      recipient: json['recipient'],
      school: json['school_name'],
      time: json['time'],
      reportId: json['report_id'],
    );
  }
}
