import 'package:flutter/material.dart';
import 'package:online_food/feature/presentation/pages/contact_us.dart';
import 'package:online_food/feature/presentation/pages/delivery.dart';
import 'package:online_food/feature/presentation/pages/profile.dart';
import 'package:online_food/feature/presentation/pages/settings.dart';
import 'package:online_food/feature/presentation/widgets/drawer_list_tile.dart';
import 'package:online_food/main.dart';

class Drawers extends StatelessWidget {
  const Drawers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
            //mainAxisAlignment: MainAxisAlignment.end,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
          Container(
            width: double.infinity,
            height: 150,
            color: Colors.amber,
            child: Column(
              children: [
                SizedBox(height: hS * 6),
                Text("Joined ",
                    style: TextStyle(
                        fontSize: 15, height: wS * 0.25, color: Colors.white)),
                SizedBox(height: 10),
                Text("Jerry Boateng",
                    style: TextStyle(
                        fontSize: 15, height: wS * 0.25, color: Colors.white)),
              ],
            ),
          ),
          SizedBox(
            height: hS * 10,
            child: Stack(children: [
              Container(
                height: hS * 6.5,
                width: double.infinity,
                color: Colors.amber,
              ),
              Positioned(
                bottom: 0,
                left: 110,
                child: CircleAvatar(
                  child:
                      Icon(Icons.person_rounded, size: 30, color: Colors.white),
                  backgroundColor: Colors.green,
                  radius: 30,
                ),
              )
            ]),
          ),
          Flexible(
            child: ListView(children: const [
              DrawerListTile(svg: "users", title: "Profile", page: Profile()),
              DrawerListTile(
                  svg: "settings", title: "Settings", page: Settings()),
              DrawerListTile(
                  svg: "settings",
                  title: "Delivery Address",
                  page: DeliveryLocation()),
              DrawerListTile(
                  svg: "phone", title: "Contact Us", page: ContactUs())
            ]),
          ),
        ]));
  }
}
