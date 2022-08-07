class Report {
  final int id;
  final String priority;
  final String school;
  final String time;
  final bool approved;
  final String description;
  final String location;
  final String reportType;
  final String pictureUrl;
  final List searchResults;

  Report({
    required this.id,
    required this.priority,
    required this.school,
    required this.time,
    required this.approved,
    required this.description,
    required this.searchResults,
    this.location = '',
    this.reportType = '',
    this.pictureUrl = '',
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'],
      priority: json['priority'],
      school: json['school_name'],
      time: json['time'],
      approved: json['approved'],
      description: json['description'],
      searchResults: json['search_results'].map((result) {
        return result['url'];
      }).toList(),
      location: json['location'] ?? '',
      reportType: json['report_type_name'] ?? '',
      pictureUrl: json['get_picture'] ?? '',
    );
  }
}
