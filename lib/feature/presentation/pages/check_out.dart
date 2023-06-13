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
        title: Text("Check Out"),
      ),
      body: Container(
          child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                SizedBox(height: 20),
                ListTile(
                    leading: Text("Payment"),
                    trailing: Text("Cash on delivery")),
                ListTile(
                    leading: Text("Deliver to"),
                    trailing: Text("Kwaprow Pimag Hostel")),
                ListTile(leading: Text("Total"), trailing: Text("70 GHc")),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: MainButton(
              onPressed: () async {
                //Navigator.pop(context);
              },
              color: Colors.pink,
              backgroundColor: Colors.pink,
              child: Visibility(
                visible: saveLoading,
                child: SizedBox(
                  // width: Dimens.iconNormal,
                  // height: Dimens.iconNormal,
                  child: Text(""),
                ),
                replacement: const Text(
                  "Place Order",
                  style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 3,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10)
        ],
      )),
    );
  }
}
