import 'package:flutter/material.dart';

class OrderedFood extends StatefulWidget {
  const OrderedFood({Key? key}) : super(key: key);

  @override
  State<OrderedFood> createState() => _OrderedFoodState();
}

class _OrderedFoodState extends State<OrderedFood> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Your Order")),
        body: Container(child: Column(children: [Text("")])));
  }
}
