import 'package:flutter/material.dart';
import 'package:online_food/pages/contact_us.dart';
import 'package:online_food/pages/delivery.dart';
import 'package:online_food/pages/order.dart';
import 'package:online_food/pages/ordered_food.dart';
import 'package:online_food/pages/profile.dart';
import 'package:online_food/pages/settings.dart';
import 'package:online_food/widgets/drawer_list_tile.dart';
import 'package:online_food/main.dart';

class Drawers extends StatelessWidget {
  const Drawers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
           // mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
          Container(
            width: double.infinity,
            height: 150,
            color: Colors.green,
            child: Column(
              children: [
                SizedBox(height: hS * 10),
                Text("Joined ",
                    style: TextStyle(
                        fontSize: 15, height: wS * 0.25,color:Colors.white)),
                const SizedBox(height: 10),
                Text("Jerry Boateng",
                    style: TextStyle(
                        fontSize: 15, height: wS * 0.25,color:Colors.white )),
              ],
            ),
          ),
          SizedBox(
            height: hS * 10,
            child: Stack(children: [
              Container(
                height: hS * 6.5,
                width: double.infinity,
                color: Colors.green,
              ),
              const Positioned(
                bottom: 0,
                left: 110,
                child: CircleAvatar(
                  backgroundColor: Colors.orange,
                  radius: 30,
                  child:
                      Icon(Icons.person_rounded, size: 30,
                          color: Colors.white),
                ),
              )
            ]),
          ),
          Flexible(
            child: ListView(children:  [
              DrawerListTile(svg: "users", title: "Profile",
                  page: Profile(
                    profileUpdate: ProfileUpdate(
                        imagePath: '',
                      check:"see"

                    ),)),
              const DrawerListTile(
                  svg: "settings", title: "Settings", page: Settings()),
              const DrawerListTile(
                  svg: "map-pin",
                  title: "Delivery Address",
                  page: DeliveryMap()),
              const DrawerListTile(
                  svg: "package",
                  title: "Orders",
                  page: Order()),
              const DrawerListTile(
                  svg: "package",
                  title: "My current Orders",
                  page: OrderedFood()),
              const DrawerListTile(
                  svg: "phone", title: "Contact Us",
                  page: ContactUs())
            ]),
          ),
        ]));
  }
}
