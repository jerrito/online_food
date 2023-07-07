import 'package:flutter/material.dart';
import 'package:online_food/feature/presentation/widgets/MainButton.dart';

class YourOrder extends StatelessWidget {
  const YourOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your order"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
           // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color:Colors.grey,
                    borderRadius: BorderRadius.circular(10)
                ),
                width:double.infinity,height: 200,
                  child: Image.asset("./assets/images/chef.png",
                    width:200,height: 150,)),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  color:Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                width:double.infinity,height: 200,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Delivery Details",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),

              Text("Address",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              Text("Eastern \nBP \nAK-071-6540"),
              Text("Kumasi-Ghana"),
                  ],
                ),
              ),
              const SizedBox(height:10),
              Container(
                decoration: BoxDecoration(
                    color:Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                width:double.infinity,//height: double.infinity,
                child: Column(
                  children: [
                    const Text("Order Summary"),
                // Expanded(
                //   child: ListView.builder(
                //     itemCount: 10,
                //     itemBuilder: (BuildContext context, int index) {
                //     return  const ListTile(
                //           trailing:Text("10",
                //               style: TextStyle(fontWeight: FontWeight.bold)),
                //           title: Text("Gari and Beans"),
                //           subtitle: Text("Gobe"),
                //           leading: Text("1"));
                //   },
                //   ),
                // ),
                  ],
                ),
              ),
              MainButton(
                onPressed: () {
                  Navigator.pushNamed(context,"orderMap");
                },
              color: Colors.green,
              child: Text("Track order"),)

            ]),
      ),
    );
  }
}
