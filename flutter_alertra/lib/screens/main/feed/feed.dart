import 'package:flutter/material.dart';
import 'package:flutter_alertra/constants/constants.dart';
import 'package:flutter_alertra/screens/main/feed/create_report.dart';
import 'package:flutter_alertra/screens/main/alert_info.dart';
import 'package:flutter_alertra/screens/teacher/home/teacher_home_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_alertra/services/APIServices.dart';
import 'package:flutter_alertra/models/alert.dart';
import 'package:flutter_alertra/models/report.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key, required this.role}) : super(key: key);

  final String role;

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  Future<Map<String, List<dynamic>?>> _loadAlerts() async {
    List<dynamic>? alerts = await context.read<APIServices>().retrieveAlerts();
    return {
      'alerts': alerts,
    };
  }

  Future<Map<String, List<dynamic>?>> _loadReports() async {
    List<dynamic>? reports =
        await context.read<APIServices>().retrieveReports();
    return {
      'reports': reports,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 20,
                ),
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search reports',
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color(0xFFB7B7B7),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(height: 2 * kDefaultPadding),
          const Text('Today', style: TextStyle(fontSize: 18)),
          const SizedBox(height: kDefaultPadding),
          const Text(
            'ALERTS',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w900, color: Colors.red),
          ),
          const SizedBox(height: kDefaultPadding / 2),
          FutureBuilder(
            future: _loadAlerts(),
            builder: (BuildContext context,
                AsyncSnapshot<Map<String, List<dynamic>?>> snapshot) {
              if (snapshot.hasData) {
                List<Alert> alerts = snapshot.data?['alerts'] as List<Alert>;
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: alerts.length,
                  itemBuilder: (context, index) {
                    Alert alert = alerts[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: kDefaultPadding),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AlertInfo(),
                            ),
                          );
                        },
                        child: Material(
                          elevation: 16,
                          shadowColor: const Color.fromARGB(255, 255, 170, 170),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0,
                            ),
                            tileColor: Colors.white,
                            leading: const Icon(
                              Icons.person,
                              color: Colors.black,
                            ),
                            title: const Text(
                              'Gamer causes lighting storm, dies instantly',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: const Text(
                                'Imposter on the run at 50 Fortnite drive, please take caution.'),
                            trailing: const Text(
                              '11:21 am',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          const SizedBox(
            height: kDefaultPadding,
          ),
          widget.role == "Teacher"
              ? Column(
                  children: [
                    const Text('Reports', style: TextStyle(fontSize: 18)),
                    const SizedBox(height: kDefaultPadding / 2),
                    FutureBuilder(
                      future: _loadReports(),
                      builder: (BuildContext context,
                          AsyncSnapshot<Map<String, List<dynamic>?>> snapshot) {
                        if (snapshot.hasData) {
                          List<Report> reports =
                              snapshot.data?['reports'] as List<Report>;
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: reports.length,
                            itemBuilder: (context, index) {
                              Report report = reports[index];
                              return Container(
                                margin: const EdgeInsets.only(
                                    bottom: kDefaultPadding),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AlertInfo(),
                                      ),
                                    );
                                  },
                                  child: Material(
                                    elevation: 16,
                                    shadowColor: const Color.fromARGB(
                                        255, 255, 170, 170),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: ListTile(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                        vertical: 8.0,
                                      ),
                                      tileColor: Colors.white,
                                      leading: const Icon(
                                        Icons.person,
                                        color: Colors.black,
                                      ),
                                      title: const Text(
                                        'Gamer causes lighting storm, dies instantly',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: const Text(
                                          'Imposter on the run at 50 Fortnite drive, please take caution.'),
                                      trailing: const Text(
                                        '11:21 am',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ],
                )
              : const SizedBox(),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateReport(),
                ),
              );
            },
            child: const Text('Create Report'),
          ),
        ],
      ),
    );
  }
}
