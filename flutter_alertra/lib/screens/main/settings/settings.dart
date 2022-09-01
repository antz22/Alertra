import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alertra/screens/main/settings/account.dart';
import 'package:flutter_alertra/screens/main/settings/notifications.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  Future<void> _launchUrl(String url) async {
    Uri parsedUrl = Uri.parse(url);

    if (!await launchUrl(parsedUrl)) {
      throw 'Could not launch $parsedUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDF0F7),
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
        elevation: 0,
        backgroundColor: const Color(0xFFEDF0F7),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text("Preferences", style: TextStyle(fontSize: 24)),
            ),
            const Divider(thickness: 1, color: Colors.grey, height: 0),
            _settingsCard(context, "Account", const Account(), null),
            const Divider(thickness: 1, color: Colors.grey, height: 0),
            _settingsCard(
                context, "Notifications", const Notifications(), null),
            const Divider(thickness: 1, color: Colors.grey, height: 0),
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text("Legal", style: TextStyle(fontSize: 24)),
            ),
            const Divider(thickness: 1, color: Colors.grey, height: 0),
            _settingsCard(
                context, "Privacy Policy", null, "https://www.google.com"),
            const Divider(thickness: 1, color: Colors.grey, height: 0),
            _settingsCard(
                context, "Terms of Use", null, "https://www.google.com"),
            const Divider(thickness: 1, color: Colors.grey, height: 0),
            _settingsCard(context, "Alertra on GitHub", null,
                "https://github.com/antz22/Alertra"),
            const Divider(thickness: 1, color: Colors.grey, height: 0),
          ],
        ),
      ),
    );
  }

  Widget _settingsCard(
      BuildContext context, String text, Widget? NextPage, String? link) {
    return Card(
      elevation: 0,
      color: const Color(0xFFEDF0F7),
      child: ListTile(
        title: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
        trailing: const Icon(Icons.arrow_right, size: 40),
        onTap: NextPage != null
            ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NextPage,
                  ),
                );
              }
            : link != null
                ? () {
                    _launchUrl(link);
                  }
                : null,
      ),
    );
  }
}
