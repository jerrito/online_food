import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_food/databases/sql_database.dart';
import 'package:online_food/widgets/buy.dart';
import 'package:online_food/models/userProvider.dart';
import 'package:provider/provider.dart';
import 'package:animate_to/animate_to.dart';
import 'package:async/async.dart';

class RestaurantPopularCategory extends StatefulWidget {
  final String category;

  const RestaurantPopularCategory({super.key, required this.category});

  @override
  State<RestaurantPopularCategory> createState() => _RestaurantPopularCategoryState();
}

class _RestaurantPopularCategoryState extends State<RestaurantPopularCategory> {
  FirebaseFirestore fireStore=FirebaseFirestore.instance;
  // GlobalKey<AnimateTo> animate_to=GlobalKey<AnimateTo>();

  CustomerProvider? customerProvider;


  Stream<QuerySnapshot<Map<String, dynamic>>> getRestaurantFoods(){
    final getData = fireStore
        .collection("pashewRestaurantManagerAccount")
        .doc("category")
        .collection(widget.category)

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
          title:Text(widget.category)
      ),
      body: Container(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: getRestaurantFoods(),
                builder: (context, snapshot) {
                  if(!snapshot.hasData){
                    return Center(child: const Text("No food found"));
                  }
                  else if(snapshot.connectionState==ConnectionState.waiting){
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Flexible(
                      child:ListView.builder(
                          itemCount:
                          snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context ,index){
                            QueryDocumentSnapshot<Object?>? data =
                            snapshot.data?.docs[index];

                            return ListTile(
                              onTap: () async {
                                showBuying(
                                  widget.category,
                                  data["picture"],
                                  data["productName"],
                                  widget.category,
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
                                    Text(data?["restaurantName"]),
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
  // Future<List<Map<String, Object?>>> allIds()async {
  //   final db = await Data().databases();
  //   final List<Map<dynamic, dynamic>> maps=await db.query('ProductIds');
  //   //print(all);
  //   return   List.generate(maps.length, (i) {
  //     print(  maps[i]['id']);
  //     return {
  //       "id":maps[i]["id"]
  //     };});
  // }
  // // Future<StreamGroup<QuerySnapshot<Map<String, dynamic>>>> alls(){
  // //
  // // }
  // Future<QuerySnapshot<Map<String, dynamic>>> ss()async{
  //   final db = await Data().databases();
  //   var result;
  //   final List<Map<dynamic, dynamic>> maps=await db.query('ProductIds');
  //   for(int i=0;i<=maps.length;i++){
  //     print(maps[i]["id"]);
  //     result= StreamGroup<QuerySnapshot<Map<String, dynamic>>>().add(fireStore
  //         .collection("pashewRestaurantManagerAccount")
  //         .doc(maps[i]["id"])
  //         .collection("Products")
  //         .where("category",isEqualTo: widget.category)
  //     //.get();
  //         .snapshots());
  //   }
  //   return result;
  // }
}
