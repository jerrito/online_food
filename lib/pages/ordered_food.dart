import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_food/widgets/MainButton.dart';
import 'package:online_food/models/userProvider.dart';
import 'package:provider/provider.dart';

class OrderedFood extends StatefulWidget {
  const OrderedFood({Key? key}) : super(key: key);

  @override
  State<OrderedFood> createState() => _OrderedFoodState();
}

class _OrderedFoodState extends State<OrderedFood> {
  CustomerProvider? customerProvider;


  @override
  void initState(){
    super.initState();
    customerProvider=context.read<CustomerProvider>();
    print(customerProvider?.appUser?.id);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Your Order")),
        body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                width:double.infinity,height:200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: Image.asset("./assets/images/chef.png",
                            width:double.infinity,
                            height:MediaQuery.of(context).size.height*0.25).image,
                      ),
                      color: Colors.grey
                    ),
                  ),
                  const Text("Address"),
                  Text("${customerProvider?.appUser?.location}"),
                  SizedBox(height:10),
                  Text("Type"),
                  Text("Deliver to door"),
                  const SizedBox(height:10),
                  Center(
                    child: MainButton(
                      onPressed: () {
                        Navigator.pushNamed(context,"orderMap");
                      },
                      color: Colors.green,
                      child: Text("Track order"),),
                  ),
                  const SizedBox(height:10),
                  const Text("Order Summary"),
                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: allOrders(),
                    builder: (context, snapshot) {
                      if(!snapshot.hasData){
                        return const Center(child: Text("No orders"));
                      }
                      return Flexible(child: ListView.builder(
                        itemCount: snapshot.data?.docs.length,
                          itemBuilder: (BuildContext context,index ){
                           QueryDocumentSnapshot<Map<String, dynamic>>?
                            data=snapshot.data?.docs[index];
                            return ListTile(
                              leading: Text(data!["quantity"]!.toString()),
                              title: Text(data["name"]),
                              trailing: Text(data["totalAmount"].toString()),
                            );
                          }));
                    }
                  )

                ])));
  }
  Stream<QuerySnapshot<Map<String, dynamic>>> allOrders(){
    final products= FirebaseFirestore.instance.
    collection('pashewFoodAccount')
        .doc(customerProvider?.appUser?.id)
        .collection("Orders")
        .snapshots();
    return products;
  }
}
