import 'package:flutter/material.dart';

class OrderPlacement extends StatefulWidget {
  const OrderPlacement({Key? key}) : super(key: key);

  @override
  State<OrderPlacement> createState() => _OrderPlacementState();
}

class _OrderPlacementState extends State<OrderPlacement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text("Checkout"),
          Row(
            children: [
              Text("Payment"),
              Text("Cash on Delivery"),
            ],
          ),
          Row(
            children: const[
              Text("Deliver to"),
              Text("123 Steiner Street"),
            ],
          ),
          Row(
            children: const[
              Text("Total"),
              Text("\$100"),
            ],
          ),
        ],
      ),
    );
  }
}
