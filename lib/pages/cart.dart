import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_food/databases/sql_database.dart';
import 'package:online_food/pages/sql.dart';
import 'package:online_food/widgets/MainButton.dart';
import 'package:online_food/main.dart';
import 'package:online_food/widgets/snackbars.dart';
import 'package:online_food/models/userProvider.dart';
import 'package:path/path.dart' as p;
import 'package:pay_with_paystack/pay_with_paystack.dart';
import 'package:sqflite/sqflite.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:online_food/models/user.dart';
class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {

  String id="";
  String choice="";
  int quantity=0;
 double? price ;
  double? pricing;
  bool isLoading = true;
  bool confirmation = false;
  int total=0;
  int totals=0;
  bool totalsGet=false;
  bool cartCheck=true;
  int? cartLength;
  int? length;
  int x=0;
  var format = DateFormat('yyyyMMdd – kk:mm');
  CustomerProvider? customerProvider;
  @override
  void initState(){
    super.initState();
    customerProvider=context.read<CustomerProvider>();
    cartLengthGet();
    //getCart();
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
            SizedBox(
              height: 50,
              child:  ListTile(
                onTap:(){
                  //print(format.format(DateTime.now()));

                },
                leading: const Text("Qty."),
                title:const Text("Food and Price") ,
                titleTextStyle: const TextStyle(color: Colors.black,
          decoration: TextDecoration.underline) ,
                trailing:const Padding(
                  padding: EdgeInsets.only(left:20.0),
                  child: Text("Total/food"),
                ),
                leadingAndTrailingTextStyle: const TextStyle(
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
                  if(total==0){
                  totals=(totals+data!.totalAmount!);
                 // totals=total;
                  }
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
                                child: Text(data!.totalAmount.toString(),
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
                                                  //Navigator.pop(context);
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
                                                              PrimarySnackBar(
                                                                  context)
                                                                  .displaySnackBar(
                                                                message: "${data
                                                                    .name} deleted from cart",
                                                                //backgroundColor: AppColors.colorPrimary,
                                                              );
                                                             // Navigator.pop(context);
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
                        child: Text("Total= ${totals.toString()}",style:
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
                  if (cartLength == 0) {
                    PrimarySnackBar(context).displaySnackBar(
                        message: "Nothing in cart");
                  } else {
                    showCheck(totals.toDouble());
                  }
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
  void showPayment(){
    showModalBottomSheet(
        backgroundColor:Theme.of(context).brightness==Brightness.dark?
        Colors.grey:Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
         isScrollControlled: true,
         isDismissible:true,
        context: context,
        builder: (BuildContext context) {
    return StatefulBuilder(builder: (context, setState)
    {
      return Container(
          width: double.infinity,
          height:hS*0.5,
          decoration: BoxDecoration(
              color: Theme
                  .of(context)
                  .brightness == Brightness.dark ?
              Colors.grey : const Color.fromRGBO(245, 245, 245, 0.6),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: const Column(
              children: [

              ])
      );
    });
        });
  }
    void showCheck(double totalAmount){
      showModalBottomSheet(
        backgroundColor:Theme.of(context).brightness==Brightness.dark?
        Colors.grey:Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        isScrollControlled: true,
        isDismissible:true,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setStates) {
            return Container(
                padding:const EdgeInsets.all(10),
              width: double.infinity,
              height:h*0.6,
              decoration: BoxDecoration(
                  color: Theme
                      .of(context)
                      .brightness == Brightness.dark ?
                  Colors.grey : const Color.fromRGBO(245, 245, 245, 0.6),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20), topRight: Radius.circular(20))),
              child: Visibility(
                  visible:isLoading,
                  replacement:const Center(
                    child: CircularProgressIndicator(

                    ),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            const SizedBox(height: 20),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                 const Text("Payment option",style:TextStyle(fontSize:16)),
                                Column(
                                  children: [
                                    TextButton.icon(
                                          label:const Text( "Choose here",
                                          style:TextStyle(fontSize:18)),
                                      icon:const Icon(Icons.arrow_downward),
                                      onPressed:()
                                          {showMenu(context: context,
                                                position: const RelativeRect.
                                                fromLTRB(90, 150, 80, 0),
                                                items: [
                                                  PopupMenuItem<int>(
                                                    onTap:(){

                                                    },value:1,

                                                    child:TextButton(
                                                      child:const Text("Momo Pay/ Visa"),
                                                      onPressed:()async{
                                                        setStates((){
                                                          choice="Momo Pay/ Visa";
                                                        });

                                                        await PayWithPayStack().now(
                                                            context: context,
                                                            secretKey:
                                                            "sk_test_4c0ae214f293e21151e0ebb96841b65a91bd2d46",
                                                            customerEmail: "${customerProvider?.appUser?.email}",
                                                            reference:
                                                            DateTime.now().microsecondsSinceEpoch.toString(),
                                                            callbackUrl: "google.com",
                                                            currency: "GHS",
                                                            paymentChannel:["mobile_money","card"],
                                                            amount: "1",
                                                            transactionCompleted: () {
                                                              setStates((){
                                                                confirmation=true;
                                                              });
                                                              Navigator.pop(context);
                                                              print("Transaction Successful");
                                                            },
                                                            transactionNotCompleted: () {
                                                              Navigator.pop(context);
                                                              print("Transaction Not Successful!");
                                                            });
                                                      },),

                                                  ),
                                                  PopupMenuItem<int>(
                                                    onTap:(){

                                                    },value:2,
                                                    child:TextButton(
                                                      child:const Text("Cash on delivery"),
                                                      onPressed:(){
                                                        print(totals);
                                                        if(totals>=100){
                                                          Navigator.pop(context);
                                                          PrimarySnackBar(context).displaySnackBar(
                                                              message:"Amount exceeds GHC 100\nPay via Momo pay or Card");
                                                        }
                                                        else{
                                                          Navigator.pop(context);
                                                          setStates((){
                                                            confirmation=true;
                                                            choice="Cash on delivery";
                                                          });

                                                        }

                                                      },),

                                                  ),


                                                ]);
                                          },),
                                    Text(choice)
                                  ],
                                ),],),
                            const SizedBox(height:20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Deliver to",style:TextStyle(fontSize:16)),
                          Text("${customerProvider?.appUser?.location?.substring(0,22)}...",style:const TextStyle(fontSize:16)),
                              ],),
                            const SizedBox(height:20),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                              const Text("Total",style:TextStyle(fontSize:16)),
                   Text("GHc$totalAmount",style:const TextStyle(fontSize:18)),
                                ]),
                            ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child:MainButton(
                          onPressed:!confirmation?null: () async {
                            setStates((){isLoading=false;});
                            final db = await Data().databases();
                            final List<Map<dynamic, dynamic>> maps = await db.query('CARTTABLE');

                            for(int i=0;i<maps.length;i++){
                              var stringList =  DateTime.now().toIso8601String().split(RegExp(r"[T\.]"));
                              var formatedDate = "${stringList[0]}${stringList[1]}";
                             // print(formatedDate.replaceAll("-", "").replaceAll(":", ""));
                              await placeOrders(
                                maps[i]['name'],
                                maps[i]['quantity'],
                                maps[i]['title'],
                                double.parse(maps[i]['totalAmount'].toString()),
                                double.parse(maps[i]['amount'].toString()),
                                int.parse(formatedDate.replaceAll("-", "").replaceAll(":", "")),
                                  customerProvider!.appUser!.id!,
                              "Pending");
                            }

                            setStates((){isLoading=true;});
                            if(!context.mounted){return;}
                            PrimarySnackBar(context).displaySnackBar(
                                message: "Order placed");
                            db.delete("CARTTABLE");
                            Navigator.pushNamed(context, "ordered_food");

                          },
                          color: Colors.green,
                          backgroundColor: Colors.green,
                          child: Visibility(
                            visible:confirmation,
                            //replacement:const Center(child: CircularProgressIndicator()),
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
                ),
              )
            ;
          });
        },
      );
    }
   late List<PopupMenuItem<dynamic>> items=[
     PopupMenuItem<int>(
       onTap:(){

       },value:1,

       child:TextButton(
         child:const Text("Momo Pay/ Visa"),
         onPressed:()async{

          await PayWithPayStack().now(
               context: context,
               secretKey:
               "",
               customerEmail: "${customerProvider?.appUser?.email}",
               reference:
               DateTime.now().microsecondsSinceEpoch.toString(),
               callbackUrl: "google.com",
               currency: "GHS",
               paymentChannel:["mobile_money","card"],
               amount: "1",
               transactionCompleted: () {
                 setState((){
                   confirmation=true;
                 });
                 Navigator.pop(context);
                 print("Transaction Successful");
               },
               transactionNotCompleted: () {
                 Navigator.pop(context);
                 print("Transaction Not Successful!");
               });
         },),

     ),
     PopupMenuItem<int>(
       onTap:(){

       },value:2,
       child:TextButton(
         child:const Text("Cash on delivery"),
         onPressed:(){
           print(totals);
           if(totals>=100){
             Navigator.pop(context);
             PrimarySnackBar(context).displaySnackBar(
                 message:"Amount exceeds GHC 100\nPay via Momo pay or Card");
           }
           else{
             Navigator.pop(context);
             setState((){
               confirmation=true;
             });

           }

         },),

     ),


    ];
void cartLengthGet()async{
  final db = await Data().databases();
  final List<Map<dynamic, dynamic>> maps = await db.query('CARTTABLE');

  cartLength=maps.length;

}
  Future<List<CartData>> getCart() async {
    final db = await Data().databases();

    final List<Map<dynamic, dynamic>> maps = await db.query('CARTTABLE ');

    print( maps.length);
    return List.generate(maps.length, (i) {
     // print(  maps[i]['id']);
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
      int date,
      String id,
      String status) async {

    var orders =Orders();
    orders.name=name;
    orders.quantity=quantity;
    orders.amount= amount;
    orders.title=title;
    orders.totalAmount=totalAmount;
    orders.date=date;
    orders.id=id;
    orders.status=status;
    orders.statusCheck=false;
    orders.customerName=customerProvider?.appUser?.fullName;
    orders.customerNumber=customerProvider?.appUser?.number;
    orders.customerEmail=customerProvider?.appUser?.email;
    orders.customerLocation=customerProvider?.appUser?.location;
    orders.customerLongitude=customerProvider?.appUser?.longitude;
    orders.customerLatitude=customerProvider?.appUser?.latitude;
    //if(widget.)
    await FirebaseFirestore.instance
        // .collection("pashewRestaurantManagerAccount")
        // .doc(id)
        .collection("Orders")
        // .doc(customerProvider?.appUser?.id)
        // .collection("${customerProvider?.appUser?.id}")
        .add(orders.toJson()).whenComplete(() async{
      await FirebaseFirestore.instance
          .collection("pashewFoodAccount")
          .doc(customerProvider?.appUser?.id)
          .collection("Orders")
          .add(orders.toJson());
    });


    return orders.toJson();
  }

}
