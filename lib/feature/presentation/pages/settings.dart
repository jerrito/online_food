import 'package:flutter/material.dart';
import 'package:online_food/feature/presentation/widgets/settings_switch.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool status = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Settings")),
        body: Container(
            child: Column(
          children: [
            const Text("Push Notifications"),
            const SizedBox(height: 20),
            SettingSwitching(title: "Allow Push Notifications"),
            const SizedBox(height: 10),
            SettingSwitching(title: "Order Updates"),
            const SizedBox(height: 10),
            SettingSwitching(title: "New Arrivals"),
            const SizedBox(height: 10),
            SettingSwitching(title: "Promotions"),
          ],
        )));
  }
}
