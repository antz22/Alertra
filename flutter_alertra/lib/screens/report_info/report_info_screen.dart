import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_alertra/constants/constants.dart';
import 'package:flutter_alertra/models/report.dart';
import 'package:flutter_alertra/services/APIServices.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportInfoScreen extends StatefulWidget {
  const ReportInfoScreen({
    Key? key,
    required this.report,
    this.role = '',
    required this.refresh,
  }) : super(key: key);

  final String role;
  final Report report;
  final Function refresh;

  @override
  _ReportInfoScreenState createState() => _ReportInfoScreenState();
}

class _ReportInfoScreenState extends State<ReportInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Student Report (${widget.report.report_type})'),
      ),
      body: Padding(
        padding: EdgeInsets.all(kDefaultPadding),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPriorityInfo(widget.report.priority),
              SizedBox(height: kDefaultPadding),
              Text(
                '${widget.report.report_type} Report',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 21.0,
                ),
              ),
              SizedBox(height: kDefaultPadding),
              Text(
                widget.report.description,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 17.0,
                ),
              ),
              SizedBox(height: kDefaultPadding),
              Text(
                widget.report.time,
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 1.5 * kDefaultPadding),
              Text(
                'Location:',
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 0.8 * kDefaultPadding),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.report.school,
                    style: TextStyle(
                      color: Colors.grey.shade500,
                    ),
                  ),
                  SizedBox(height: 0.3 * kDefaultPadding),
                  Text(
                    widget.report.location,
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 1.5 * kDefaultPadding),
              widget.report.picture_url != ''
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Picture:',
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: kDefaultPadding),
                        Container(
                          child: ClipRRect(
                            child: Image(
                              image:
                                  NetworkImage('${widget.report.picture_url}'),
                            ),
                          ),
                        ),
                        SizedBox(height: 1.2 * kDefaultPadding),
                      ],
                    )
                  : SizedBox.shrink(),
              widget.report.search_results.length != 0
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Matching Search Results:',
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 0.7 * kDefaultPadding),
                        GestureDetector(
                          onTap: () => _launchUrl(
                              context, widget.report.search_results[0]),
                          child: Text(
                            widget.report.search_results[0],
                            style: TextStyle(
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 0.4 * kDefaultPadding),
                        GestureDetector(
                          onTap: () => _launchUrl(
                              context, widget.report.search_results[1]),
                          child: Text(
                            widget.report.search_results[0],
                            style: TextStyle(
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 0.4 * kDefaultPadding),
                        GestureDetector(
                          onTap: () => _launchUrl(
                              context, widget.report.search_results[2]),
                          child: Text(
                            widget.report.search_results[2],
                            style: TextStyle(
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    )
                  : SizedBox.shrink(),
              SizedBox(height: 2 * kDefaultPadding),
              widget.role == 'Teacher'
                  ? widget.report.approved
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Approved',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 16.0,
                              ),
                            ),
                            Icon(Icons.check, color: Colors.green),
                          ],
                        )
                      : Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  await context
                                      .read<APIServices>()
                                      .deleteReport(widget.report.id);
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFE30000),
                                    borderRadius: BorderRadius.circular(5.0),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 7.0,
                                        spreadRadius: 1.0,
                                        offset: Offset(0, 5),
                                        color:
                                            kRedWarningColor.withOpacity(0.20),
                                      )
                                    ],
                                  ),
                                  height: 52.0,
                                  child: Center(
                                    child: Text(
                                      'DELETE',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: kDefaultPadding),
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  await context
                                      .read<APIServices>()
                                      .approveReport(
                                          widget.report.id,
                                          widget.report.approved
                                              ? false
                                              : true);
                                  this.widget.refresh();
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: kPrimaryColor,
                                    borderRadius: BorderRadius.circular(5.0),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 7.0,
                                        spreadRadius: 1.0,
                                        offset: Offset(0, 5),
                                        color: kPrimaryColor.withOpacity(0.20),
                                      )
                                    ],
                                  ),
                                  height: 52.0,
                                  child: Center(
                                    child: Text(
                                      'APPROVE',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildPriorityInfo(String priority) {
    if (priority == 'high') {
      return Row(
        children: [
          SvgPicture.asset('assets/svgs/warning.svg', color: kRedWarningColor),
          SizedBox(width: 0.5 * kDefaultPadding),
          Text(
            'High Priority',
            style: TextStyle(
              color: kRedWarningColor,
              fontSize: 15.0,
            ),
          ),
        ],
      );
    } else if (priority == 'medium') {
      return Row(
        children: [
          SvgPicture.asset('assets/svgs/warning.svg',
              color: kOrangeWarningColor),
          SizedBox(width: 0.5 * kDefaultPadding),
          Text(
            'Medium Priority',
            style: TextStyle(
              color: kOrangeWarningColor,
              fontSize: 15.0,
            ),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          SvgPicture.asset('assets/svgs/warning.svg',
              color: kYellowWarningColor),
          SizedBox(width: 0.5 * kDefaultPadding),
          Text(
            'Low Priority',
            style: TextStyle(
              color: kYellowWarningColor,
              fontSize: 15.0,
            ),
          ),
        ],
      );
    }
  }

  void _launchUrl(BuildContext context, String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Error launching url');
    }
  }
}
