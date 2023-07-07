import 'package:flutter/material.dart';
import 'package:online_food/feature/presentation/pages/check_out.dart';
import 'package:online_food/feature/presentation/pages/sql.dart';
import 'package:online_food/feature/presentation/widgets/MainButton.dart';
import 'package:online_food/main.dart';
import 'package:online_food/snackbars.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  int quantity=0;
 double? price ;
  double? pricing;
  bool isLoading = false;
  Future<List<CartData>> getCart() async {

    // Get a reference to the database.
    final database = openDatabase(
      join(await getDatabasesPath(), 'pashewCart.db'),
      version: 1,);
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<dynamic, dynamic>> maps = await db.query('CARTDATA');

    print(maps.length);
    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return CartData(
        name: maps[i]['name'],
        amount: maps[i]['amount'],
        quantity: maps[i]['quantity'],
        title: maps[i]['title'],
        totalAmount: maps[i]['totalAmount'],
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            FutureBuilder(
    future:getCart(),
    builder: (context,snapshot) {

    if(!snapshot.hasData) {
        return const SizedBox(
        height: 400,
          child: Center(child: Text("Nothing in cart")));
    }
    return Flexible(
              child: ListView.builder(
                itemCount:snapshot.data?.length,
                itemBuilder: (context, int i) {
                  CartData? data =
                  snapshot.data?[i];
                  print(snapshot.data?.length);
                  return Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          // border: Border.fromBorderSide(
                          //   BorderSide()
                          // )
                        ),
                        child: ListTile(
                          trailing:Text(data!.totalAmount.toString(),
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                          title: Text(data.name!),
                          subtitle: Text(data.title!),
                          leading: Text(i.toString()),
                          onTap: () {
                            setState(() {
                              quantity=data.quantity!;
                              price=data.amount!.toDouble();
                              pricing=data.totalAmount!.toDouble();

                            });
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

                                                ToggleSwitch(
                                                  minWidth: wS * 50,
                                                  minHeight: hS * 8,
                                                  customTextStyles: const [TextStyle( fontSize: 32,
                                                      fontWeight: FontWeight.bold),
                                                    TextStyle( fontSize: 30,),TextStyle(
                                                      fontWeight: FontWeight.bold,fontSize: 32,),],
                                                  initialLabelIndex: 0,
                                                  cornerRadius: 20.0,
                                                  activeFgColor: Colors.black,
                                                  inactiveBgColor: Colors.grey,
                                                  inactiveFgColor: Colors.white,
                                                  totalSwitches: 3,
                                                  labels: ['-', "$quantity", '+'],
                                                  activeBgColors: const [
                                                    [Colors.white],
                                                    [Colors.red]
                                                  ],
                                                  onToggle: (index) {
                                                   // print('switched to: $index');
                                                    if (index == 0) {
                                                      if (quantity <= 1) {
                                                        return;
                                                      } else {
                                                        setState(() {
                                                          quantity--;
                                                          pricing = (price! * quantity);
                                                        });
                                                      }
                                                      // setAsLight();
                                                      // Navigator.pop(context);
                                                    } else if (index == 2) {
                                                      setState(() {
                                                        quantity++;
                                                        pricing = (price! * quantity);
                                                      });
                                                      // setAsDark();
                                                      // Navigator.pop(context);
                                                    }
                                                  },
                                                ),
                                                const SizedBox(height:25),
                                                const Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children:[
                                                      Text("Food Type",
                                                          style: TextStyle(fontSize: 16,
                                                              decoration: TextDecoration.underline,
                                                              fontWeight: FontWeight.bold)),
                                                      Text("Total price",
                                                          style: TextStyle(fontSize: 16,
                                                              decoration: TextDecoration.underline,
                                                              //decorationStyle: TextDecorationStyle.dotted,
                                                              fontWeight: FontWeight.bold)),
                                                    ]
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children:[
                                                    Text(data.name!,
                                                        style: const TextStyle(fontSize: 16,
                                                            fontWeight: FontWeight.bold)),
                                                    Padding(
                                                      padding: const EdgeInsets.only(right:20.0),
                                                      child: Text(pricing.toString(),
                                                          style: const TextStyle(fontSize: 16,
                                                              fontWeight: FontWeight.bold)),
                                                    ),
                                                  ]
                                                )
                                              ],
                                            ),
                                          ),
                                          // SizedBox(height: 50),
                                          SecondaryButton(
                                            onPressed: () {
                                              SQL().updateSQL(
                                                CartData(
                                                    name: data.name,
                                                    amount: data.amount,
                                                    quantity: quantity,
                                                    title: data.title,
                                                    totalAmount: pricing?.toInt())
                                              ).whenComplete(() {
                                              PrimarySnackBar(context).displaySnackBar(
                                              message: "${data.name} updated on cart",
                                              //backgroundColor: AppColors.colorPrimary,
                                              );
                                                  Navigator.pushReplacementNamed(context, "home");
                                              });
                                            },
                                            color: Colors.green,
                                            text: 'Update Cart',
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                SQL().deleteSQL(
                                                    CartData(
                                                        name: data.name,
                                                        amount: data.amount,
                                                        quantity: quantity,
                                                        title: data.title,
                                                        totalAmount:pricing?.toInt())).whenComplete(
                                                        () {
                                                            PrimarySnackBar(context).displaySnackBar(
                                                              message: "${data.name} deleted from cart",
                                                              //backgroundColor: AppColors.colorPrimary,
                                                            );
                                                    Navigator.pushReplacementNamed(context, "home");}
                                                );
                                              },
                                              child: const Text('Remove from Cart')),
                                        ]));
                                  });
                                });
                          },
                        ),
                      );
                    }));

                },),

           // const SQL(),
            SizedBox(
              height: 60,
              child: SecondaryButton(
                onPressed: () async {
                  getCart();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return const CheckOut();
                  }));
                },
                color: Colors.green,
                backgroundColor: Colors.green,
                text: 'Checkout',
              ),
            ),
            const SizedBox(height:10)
          ],
        ),
      ),
    );
  }
}
