import 'package:flutter/material.dart';
import 'package:online_food/feature/presentation/pages/check_out.dart';
import 'package:online_food/feature/presentation/widgets/MainButton.dart';
import 'package:online_food/main.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  var amount = 1;
  bool saveLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              itemBuilder: (context, int i) {
                return Container(
                  padding: EdgeInsets.all(10),
                  child: ListTile(
                    trailing: Text("\$100",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    title: Text("Beef Burger"),
                    subtitle: Text("This is the food for you"),
                    leading: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.redAccent,
                                width: 2,
                                style: BorderStyle.solid)),
                        child: Text("3")),
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          isScrollControlled: true,
                          isDismissible: true,
                          builder: (BuildContext context) {
                            return StatefulBuilder(
                                builder: (context, setState) {
                              return Container(
                                  width: double.infinity,
                                  height: 300,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20))),
                                  margin: const EdgeInsets.all(10),
                                  child: Column(children: [
                                    Expanded(
                                      child: ListView(
                                        children: [
                                          Text("Burger"),
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
                                            icons: [
                                              Icons.minimize,
                                              Icons.numbers,
                                              Icons.add
                                            ],
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
                                                  });
                                                }
                                                // setAsLight();
                                                // Navigator.pop(context);
                                              } else if (index == 2) {
                                                setState(() {
                                                  amount++;
                                                });
                                                // setAsDark();
                                                // Navigator.pop(context);
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    // SizedBox(height: 50),
                                    SecondaryButton(
                                      onPressed: () {},
                                      color: Colors.pink,
                                      text: 'Update Cart',
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    TextButton(
                                        onPressed: () {},
                                        child: Text('Removefrom Cart')),
                                  ]));
                            });
                          });
                    },
                  ),
                );
              },
              itemCount: 50,
            ),
          ),
          SizedBox(
            height: 70,
            child: SecondaryButton(
              onPressed: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return const CheckOut();
                }));
              },
              color: Colors.pink,
              backgroundColor: Colors.pink,
              text: 'Checkout',
            ),
          )
        ],
      ),
    );
  }
}
