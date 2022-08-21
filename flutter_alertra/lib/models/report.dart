class Report {
  final int id;
  final String priority;
  final String school;
  final String time;
  final bool approved;
  final String description;
  final String altitude;
  final String floor;
  final String latitude;
  final String longitude;
  final String address;
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
    required this.altitude,
    required this.floor,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.searchResults,
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
      altitude: json['altitude'],
      floor: json['floor'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      address: json['address'],
      searchResults: json['search_results'].map((result) {
        return result['url'];
      }).toList(),
      reportType: json['report_type'] ?? '',
      pictureUrl: json['get_picture'] ?? '',
    );
  }
}
