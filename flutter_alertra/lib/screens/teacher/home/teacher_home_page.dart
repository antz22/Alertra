import 'package:flutter/material.dart';
import 'package:flutter_alertra/constants/constants.dart';
import 'package:flutter_alertra/screens/main/alerts.dart';
import 'package:flutter_alertra/screens/main/feed.dart';
import 'package:flutter_alertra/screens/main/news.dart';
import 'package:flutter_alertra/widgets/page_button.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';

class TeacherHomePage extends StatelessWidget {
  const TeacherHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDF0F7),
      appBar: AppBar(
        title: const Text(
          'Alertra',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
        elevation: 0,
        backgroundColor: const Color(0xFFEDF0F7),
        centerTitle: false,
      ),
      body: Container(
        // padding: const EdgeInsets.symmetric(horizontal: 16),
        child: DefaultTabController(
          length: 3,
          child: Column(
            children: <Widget>[
              ButtonsTabBar(
                backgroundColor: Colors.transparent,
                unselectedBackgroundColor: Colors.transparent,
                splashColor: Colors.transparent,
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w900,
                  // color: Colors.red
                ),
                unselectedLabelStyle: const TextStyle(
                  color: Colors.grey
                ),
                radius: 4,
                height: 53,
                tabs: const [
                  Tab(
                    child: PageButton(
                      text: 'Feed',
                    ),
                  ),
                  Tab(
                    child: PageButton(
                      text: "Alerts",
                    ),
                  ),
                  Tab(
                    child: PageButton(
                      text: "News",
                    ),
                  ),
                ],
              ),
              const Divider(height: 16, thickness: 2),
              const Expanded(
                child: TabBarView(
                  children: <Widget>[
                    Feed(),
                    Alerts(),
                    News(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
