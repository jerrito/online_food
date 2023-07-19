import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_food/feature/presentation/pages/sql.dart';
import 'package:online_food/feature/presentation/widgets/MainButton.dart';
import 'package:online_food/main.dart';
import 'package:online_food/snackbars.dart';
import 'package:online_food/userProvider.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {

  String id="";
  int quantity=0;
 double? price ;
  double? pricing;
  bool isLoading = true;
  int total=0;
  int totals=0;
  bool totalsGet=false;
  int? length;
  int x=0;

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
      appBar: AppBar(title: const Text('My Cart')),
      body: Container(
         color: const Color.fromRGBO(245, 245, 245, 0.6),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              height: 50,
              child: const ListTile(
                leading: Text("Qty."),
                title:Text("Food and Price") ,
                titleTextStyle: TextStyle(color: Colors.black,
          decoration: TextDecoration.underline) ,
                trailing:Padding(
                  padding: EdgeInsets.only(left:20.0),
                  child: Text("Total/food"),
                ),
                leadingAndTrailingTextStyle: TextStyle(
                    color: Colors.black,
                  decoration: TextDecoration.underline
                ),
              ),
            ),
            FutureBuilder(
              //initialData: [getCart()],
    future:getCart(),
    builder: (context,snapshot) {

    if(!snapshot.hasData) {
        return const SizedBox(
        height: 400,
          child: Center(child: Text("Nothing added to cart")));
    }
   else if(snapshot.data!.isEmpty) {
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
                  length=snapshot.data?.length;
                  total=(total+data!.totalAmount!);
                  totals=total;
                  //print(total);
                  // print(length);
                  // if(snapshot.data?.length == i+1 ){
                  //
                  //   if(context.mounted) {
                  //     print("GG");
                  //   }else{
                  //     setState(() {
                  //       total = totals;
                  //       totalsGet = true;
                  //     });
                  //   }
                  //
                  // }

                  return Column(
                    children: [
                      Container(
                           // padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              // border: Border.fromBorderSide(
                              //   BorderSide()
                              // )
                            ),
                            child: ListTile(
                              trailing:Padding(
                                padding: const EdgeInsets.only(right:20.0),
                                child: Text(data.totalAmount.toString(),
                                    style: const TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              title: Text(data.name!),
                              subtitle:
                              Text("${data.title!}\nPrice: ${data.amount}"),
                              leading: Text((data.totalAmount!/data.amount!).toString().substring(0,1)),
                              onTap: () {

                                quantity=data.quantity!;
                                  price=data.amount!.toDouble();
                                  pricing=data.totalAmount!.toDouble();

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
                                                        id:data.id,
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
                                                          id:data.id,
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
                          ),
                      Visibility(
                        visible:i+1==snapshot.data?.length? true:false,
                        replacement: const Text(""),
                        child: Text("Total ${totals.toString()}",style:
                        const TextStyle(fontWeight:FontWeight.bold,fontSize:18)),
                      ),
                    ],
                  );
                    }));

                },),

           // const SQL(),

            const SizedBox(height:10),
            SizedBox(
              height: 60,
              child: SecondaryButton(
                onPressed: () {
                 showCheck(totals.toDouble());
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (BuildContext context) {
                  //   return  CheckOut(
                  //     total: totals.toDouble(),
                  //     address:customerProvider!.appUser!.location!,
                  //   );
                  // }));
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
    void showCheck(double totalAmount){
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
            return Container(
              width: double.infinity,
              height: hS * 71.65,
              decoration: BoxDecoration(
                  color: Theme.of(context).brightness==Brightness.dark?
                  Colors.grey: const Color.fromRGBO(245, 245, 245, 0.6),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20), topRight: Radius.circular(20))),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        const SizedBox(height: 20),
                        const ListTile(
                            leading: Text("Payment",style:TextStyle(fontSize:16)),
                            trailing: Text("Cash on delivery",style:TextStyle(fontSize:18))),
                        ListTile(
                            leading: const Text("Deliver to",style:TextStyle(fontSize:16)),
                            trailing: Text("${customerProvider?.appUser?.location?.substring(0,22)}...",style:const TextStyle(fontSize:16))),
                        ListTile(leading: const Text("Total",style:TextStyle(fontSize:16)), trailing: Text("GHc$totalAmount",style:const TextStyle(fontSize:18))),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: MainButton(
                      onPressed:!isLoading?null: () async {
                        setState((){isLoading=false;});
                        final database = openDatabase(
                          p.join(await getDatabasesPath(), 'pashewCart.db'),
                          version: 1,);
                        final db = await database;
                        final List<Map<dynamic, dynamic>> maps = await db.query('CARTTABLE');

                        for(int i=0;i<maps.length;i++){
                          //print(  maps[i]['id']);
                          //String name= maps[i]['name'];
                          await placeOrders(
                            maps[i]['name'],
                            maps[i]['quantity'],
                            maps[i]['title'],
                            double.parse(maps[i]['totalAmount'].toString()),
                            double.parse(maps[i]['amount'].toString()),
                            DateTime.now().toUtc().toString(),
                            maps[i]["id"],);
                        }
                        setState((){isLoading=true;});
                        if(!context.mounted){return;}
                        Navigator.pushNamed(context, "ordered_food");
                        //getCart();
                        // await placeOrders( "name", 3,
                        //     "title", 444,
                        //     30,
                        //     DateTime.now().toUtc().toString(),
                        // "YLnon6FLoQ2C4k8m57TC");
                      },
                      color: Colors.green,
                      backgroundColor: Colors.green,
                      child: Visibility(
                        visible:isLoading,
                        replacement:const Center(child: CircularProgressIndicator()),
                        child: const Text(
                          "Place Order",
                          style: TextStyle(
                            fontSize: 16,
                            letterSpacing: 3,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10)
                ],
              ),
            );
          });
        },
      );
    }

  Future<List<CartData>> getCart() async {

    final database = openDatabase(
      p.join(await getDatabasesPath(), 'pashewCart.db'),
      version: 1,);
    final db = await database;

    final List<Map<dynamic, dynamic>> maps = await db.query('CARTTABLE ');

    // print(maps.length);
    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      print(  maps[i]['id']);
      return CartData(
        name: maps[i]['name'],
        id: maps[i]['id'],
        amount: maps[i]['amount'],
        quantity: maps[i]['quantity'],
        title: maps[i]['title'],
        totalAmount: maps[i]['totalAmount'],
      );
    });
  }
  Future<Map<dynamic, dynamic>> placeOrders(
      String name,
      int quantity,
      String title,
      double totalAmount,
      double amount,
      String date,
      String id) async {
    var order =  CartData(
        name: name,
        totalAmount: int.parse(totalAmount.toString().substring(0,2)),
        id: id,
        amount: int.parse(amount.toString().substring(0,2)),
        quantity: quantity,
        title: title);
    var orders = <String, dynamic>{
      "name": name,
      "quantity":quantity,
      "amount": amount,
      "title":title,
      "totalAmount":totalAmount,
      "date": date,
    "id":id};
    //if(widget.)
    await FirebaseFirestore.instance
        .collection("pashewRestaurantManagerAccount")
        .doc(id)
        .collection("Orders")
        .doc(customerProvider?.appUser?.id)
        .collection(customerProvider!.appUser!.email!)
        .doc()
        .set(orders).whenComplete(() async{
      await FirebaseFirestore.instance
          .collection("pashewFoodAccount")
          .doc(customerProvider?.appUser?.id)
          .collection("Orders")
          .doc()
          .set(orders);
    });


    return orders;
  }

}
