import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_food/feature/presentation/widgets/buy.dart';
import 'package:online_food/userProvider.dart';
import 'package:provider/provider.dart';

class RestaurantMenu extends StatefulWidget {
  final String id;
  final String restaurantName;
  const RestaurantMenu({super.key, required this.id, required this.restaurantName});

  @override
  State<RestaurantMenu> createState() => _RestaurantMenuState();
}

class _RestaurantMenuState extends State<RestaurantMenu> {
  FirebaseFirestore fireStore=FirebaseFirestore.instance;

  CustomerProvider? customerProvider;
  Stream<QuerySnapshot<Map<String, dynamic>>> getRestaurantFoods(){
    final getData = fireStore
        .collection("pashewRestaurantManagerAccount")
        .doc(widget.id)
        .collection("Products")
        .snapshots();
    return getData;

  }

  @override
  void initState(){
    super.initState();
    customerProvider=context.read<CustomerProvider>();
    getRestaurantFoods();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(widget.restaurantName)
      ),
      body: Container(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: getRestaurantFoods(),
              builder: (context, snapshot) {
                if(!snapshot.hasData){
                 return Center(child: CircularProgressIndicator());
                }
                return Flexible(
                    child:ListView.builder(
                      itemCount: snapshot.data?.docs.length,
                        itemBuilder: (BuildContext context ,index){
                          QueryDocumentSnapshot<Object?>? data =
                          snapshot.data?.docs[index];

                return ListTile(
                  onTap: () async {
                    showBuying(
                      widget.id,
                        data["picture"],
                        data["productName"],
                        widget.restaurantName,
                        data["price"],
                        );
                    // // productProvider=context.read<ProductProvider>();
                    // await productProvider?.getProduct(productName: productDetails["productName"],
                    //     id:customerProvider!.appUser!.id! );
                    // if(!context.mounted)return;
                    // Navigator.push(context,
                    //     MaterialPageRoute(
                    //         builder: (BuildContext context){
                    //           return EditProduct(
                    //               productName: productDetails["productName"],
                    //               description:productDetails["description"],
                    //               picture:productDetails["picture"],
                    //               price:productDetails["price"]);}));
                  },
                  isThreeLine: true,
                  title: Text(data?["productName"]),
                  subtitle:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        Text(data?["description"]),
                        Text(data!["price"].toString()),]
                  ),
                  trailing: CircleAvatar(
                    radius: 50,
                    backgroundImage: Image.network(data["picture"],
                    fit:BoxFit.contain).image,
                  ),

                );

                        }));
              }
            )
          ],
        ),
      ),

    );
  }
  void showBuying(String id,String image,String name,String restaurantName,double amount){
    showModalBottomSheet<dynamic>(
      backgroundColor:Theme.of(context).brightness==Brightness.dark?
      Colors.grey:Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      isScrollControlled: true,
      isDismissible:true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Buying(
             id:id,
              image: image,
              name: name,
              restaurantName: restaurantName,
              amount:amount);
        });
      },
    );
  }
}
