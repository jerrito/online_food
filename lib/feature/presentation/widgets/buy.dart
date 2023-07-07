import 'package:flutter/material.dart';
import 'package:online_food/feature/presentation/pages/sql.dart';
import 'package:online_food/feature/presentation/widgets/MainButton.dart';
import 'package:online_food/main.dart';
import 'package:online_food/snackbars.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Buying extends StatefulWidget {
  final String image;
  final String name ;
  final String title;
  final double amount;
  const Buying({Key? key, required this.image,
    required this.name, required this.title,
    required this.amount}) : super(key: key);

  @override
  State<Buying> createState() => _BuyingState();
}

class _BuyingState extends State<Buying> {
  int quantity = 1;
 late double price =widget.amount;
 late double pricing = widget.amount;
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
                      image:Image.asset(
    "./assets/images/${widget.image}").image))),
          const SizedBox(height: 20),
          // Center(
          //     child: Text("$amount",
          //         style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold))),
          ToggleSwitch(
            minWidth: wS * 50,
            minHeight: hS * 8,
            initialLabelIndex: 0,
            cornerRadius: 20.0,
            //iconSize: 0,
            customTextStyles: const [TextStyle( fontSize: 32,fontWeight: FontWeight.bold),
              TextStyle( fontSize: 30,),TextStyle( fontWeight: FontWeight.bold,fontSize: 32,),],
            activeFgColor: Colors.black,
            inactiveBgColor: Colors.grey,
            inactiveFgColor: Colors.white,
            totalSwitches: 3,
            labels: ['-', quantity.toString(), '+'],
            //customIcons: [],
            //icons: const [Icons.minimize,Icons.note, Icons.add],
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
                    pricing = price * quantity;
                  });
                }
              } else if (index == 2) {
                setState(() {
                  quantity++;
                  pricing = price * quantity;
                });
              }
            },
          ),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.name,
                  style: const TextStyle(fontSize: 16,
                      fontWeight: FontWeight.bold)),
              Text("\$$pricing",
                  style: const TextStyle(fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 80),
          SecondaryButton(
            onPressed: () async{
              print(pricing);
              // Create a Dog and add it to the dogs table
              var cartItem = CartData(
                name: widget.name,
                totalAmount: pricing.toInt(),
                title: widget.title,
                quantity: quantity,
                amount: widget.amount.toInt(),
              );

              await SQL().insertCartData(cartItem).whenComplete((){
                PrimarySnackBar(context).displaySnackBar(
                  message: "${widget.name} added to cart",
                  //backgroundColor: AppColors.colorPrimary,
                );
                Navigator.pushReplacementNamed(context, "home");
              });
             // print("s");
            // await  SQL().sql(widget.name, widget.title,
            //     pricing);
            },
            color: Colors.green,
            text: 'Add to Cart',
            backgroundColor: Colors.green,
          )
        ],
      ),
    );
  }
}
