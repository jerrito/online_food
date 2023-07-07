import 'package:flutter/material.dart';
import 'package:online_food/feature/presentation/widgets/MainButton.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({Key? key}) : super(key: key);

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  bool saveLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Check Out"),
      ),
      body: Container(
          child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                const SizedBox(height: 20),
                const ListTile(
                    leading: Text("Payment"),
                    trailing: Text("Cash on delivery")),
                const ListTile(
                    leading: Text("Deliver to"),
                    trailing: Text("Kwaprow Pimag Hostel")),
                const ListTile(leading: Text("Total"), trailing: Text("70 GHc")),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: MainButton(
              onPressed: () async {
                Navigator.pushNamed(context,"your_order");
              },
              color: Colors.green,
              backgroundColor: Colors.green,
              child: Visibility(
                visible: saveLoading,
                replacement: const Text(
                  "Place Order",
                  style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 3,
                  ),
                ),
                child: const SizedBox(
                  // width: Dimens.iconNormal,
                  // height: Dimens.iconNormal,
                  child: Text(""),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10)
        ],
      )),
    );
  }
}
