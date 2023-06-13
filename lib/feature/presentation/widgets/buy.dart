import 'package:flutter/material.dart';
import 'package:online_food/feature/presentation/widgets/MainButton.dart';
import 'package:online_food/main.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Buying extends StatefulWidget {
  const Buying({Key? key}) : super(key: key);

  @override
  State<Buying> createState() => _BuyingState();
}

class _BuyingState extends State<Buying> {
  var amount = 1;
  final price = 200;
  var pricing = 200;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: hS * 71.65,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      margin: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // SizedBox(height:31),
          // Container(
          //   width: 250,
          //   height: 320,
          //   decoration: BoxDecoration(
          //       shape: BoxShape.circle,
          //       image: DecorationImage(
          //           image: Image.asset('./assets/images/pizza.jpg',
          //                   width: 250, height: 320, fit: BoxFit.fill)
          //               .image)),
          // ),
          // CircleAvatar(
          //   backgroundImage:
          //       Image.asset('./assets/images/pizza.jpg', fit: BoxFit.fitWidth)
          //           .image, //NetworkImage('$bioimage!'),
          //   radius: 100,
          // ),
          Container(
              height: 200,
              width: 200,
              // padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: Image.asset("./assets/images/burger.jpg").image))),
          SizedBox(height: 20),
          // Center(
          //     child: Text("$amount",
          //         style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold))),
          ToggleSwitch(
            minWidth: wS * 50,
            minHeight: hS * 8,
            fontSize: 30,
            initialLabelIndex: 0,
            cornerRadius: 20.0,
            activeFgColor: Colors.black,
            inactiveBgColor: Colors.grey,
            inactiveFgColor: Colors.white,
            totalSwitches: 3,
            labels: ['', "$amount", ''],
            icons: [Icons.minimize, Icons.numbers, Icons.add],
            activeBgColors: [
              [Colors.white],
              [Colors.red]
            ],
            onToggle: (index) {
              print('switched to: $index');
              if (index == 0) {
                if (amount <= 1) {
                  return;
                } else {
                  setState(() {
                    amount--;
                    pricing = price * amount;
                  });
                }
              } else if (index == 2) {
                setState(() {
                  amount++;
                  pricing = price * amount;
                });
              }
            },
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Beef Burger",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text("\$$pricing"),
            ],
          ),
          SizedBox(height: 30),
          SecondaryButton(
            onPressed: () {},
            color: Colors.pink,
            text: 'Add to Cart',
            backgroundColor: Colors.pink,
          )
        ],
      ),
    );
  }
}
