import 'package:flutter/material.dart';
import 'package:flutter_alertra/constants/constants.dart';
import 'package:flutter_alertra/screens/main/alert.dart';
import 'package:flutter_alertra/screens/main/feed/feed.dart';
import 'package:flutter_alertra/screens/main/learn.dart';
import 'package:flutter_alertra/screens/main/news.dart';
import 'package:flutter_alertra/screens/main/settings/settings.dart';
import 'package:flutter_alertra/widgets/page_button.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';

class TeacherHomePage extends StatelessWidget {
  const TeacherHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDF0F7),
      appBar: AppBar(
        title: Row(
          children: [
            const Text(
              'Alertra',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Settings(),
                  ),
                );
              },
              icon: const Icon(
                Icons.settings,
                color: Colors.black,
              ),
            )
          ],
        ),
        elevation: 0,
        backgroundColor: const Color(0xFFEDF0F7),
        centerTitle: false,
      ),
      body: Container(
        // padding: const EdgeInsets.symmetric(horizontal: 16),
        child: DefaultTabController(
          length: 4,
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
                unselectedLabelStyle: const TextStyle(color: Colors.grey),
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
                  Tab(
                    child: PageButton(
                      text: "Learn",
                    ),
                  ),
                ],
              ),
              const Divider(height: 16, thickness: 2),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    const Feed(role: "Teacher"),
                    Alerts(),
                    const News(),
                    const Learn(),
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
