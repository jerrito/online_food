import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_food/databases/sql_database.dart';
import 'package:online_food/widgets/buy.dart';
import 'package:online_food/models/userProvider.dart';
import 'package:provider/provider.dart';
import 'package:animate_to/animate_to.dart';
import 'package:online_food/pages/sql.dart';
import 'package:online_food/widgets/MainButton.dart';
import 'package:online_food/main.dart';
import 'package:online_food/widgets/snackbars.dart';
import 'package:toggle_switch/toggle_switch.dart';
class RestaurantMenu extends StatefulWidget {
  final String id;
  final String restaurantName;
  const RestaurantMenu({super.key, required this.id, required this.restaurantName});

  @override
  State<RestaurantMenu> createState() => _RestaurantMenuState();
}

class _RestaurantMenuState extends State<RestaurantMenu> {
  FirebaseFirestore fireStore=FirebaseFirestore.instance;
  // GlobalKey<AnimateToState> animate_to=GlobalKey<AnimateToState>();
  // GlobalKey<AnimateFromState> anim=GlobalKey<AnimateFromState>();
  // final _animateToController = AnimateToController();
  int cartNumber=0;
  int quantity = 1;


  Future<int> cartLength() async {
    final db = await Data().databases();
    final List<Map<dynamic, dynamic>> maps =  await db.query('CARTTABLE');
    setState(() {
      cartNumber=maps.length;
    });
    return maps.length;
  }
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
    cartLength();
    getRestaurantFoods();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(widget.restaurantName),
        actions: [
          Badge(
              backgroundColor: Colors.green,
              label:Text("$cartNumber"),
              child: IconButton(
                icon: const Icon(Icons.shopping_cart),
                tooltip: 'Open shopping cart',
                onPressed: () {
                  Navigator.pushNamed(context, "cart");
                },
              ),
            ),

         const Padding(padding: EdgeInsets.only(right:10))],
      ),
      body: Container(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: getRestaurantFoods(),
              builder: (context, snapshot) {
                if(!snapshot.hasData){
                 return const Center(child: CircularProgressIndicator());
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

     double price =amount;
     double pricing = amount;
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
            margin: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                SizedBox(height:10),
                // SizedBox(height:31),
                // Container(
                //   width: 250,
                //   height: 320,
                //   decoration: BoxDecoration(
                //       shape: BoxShape.circle,
                //       image: DecorationImage(
                //           image: Image.asset('./assets/images/pizza.jpg',
                //                   width: 250, height: 320, fit: BoxFit.fill)
                //               .image)),
                // ),
                // CircleAvatar(
                //   backgroundImage:
                //       Image.asset('./assets/images/pizza.jpg', fit: BoxFit.fitWidth)
                //           .image, //NetworkImage('$bioimage!'),
                //   radius: 100,
                // ),
                Container(
                    height: 200,
                    width: 200,
                    // padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image:Image.network(image).image))),
                const SizedBox(height: 20),
                // Center(
                //     child: Text("$amount",
                //         style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold))),
                ToggleSwitch(
                  minWidth: wS * 50,
                  minHeight: hS * 8,
                  initialLabelIndex: 1,
                  cornerRadius: 20.0,
                  //iconSize: 0,
                  customTextStyles: const [TextStyle( fontSize: 32,fontWeight: FontWeight.bold),
                    TextStyle( fontSize: 30,),TextStyle( fontWeight: FontWeight.bold,fontSize: 32,),],
                  activeFgColor: Colors.black,
                  //inactiveBgColor: Colors.grey,
                  inactiveFgColor: Colors.black,
                  totalSwitches: 3,
                  labels: ['-', quantity.toString(), '+'],
                  //customIcons: [],
                  //icons: const [Icons.minimize,Icons.note, Icons.add],
                  activeBgColors: const [
                    [Colors.white],
                    [Colors.white]
                  ],
                  onToggle: (index) {
                    // print('switched to: $index');
                    if (index == 0) {
                      if (quantity <= 1) {
                        return;
                      } else {
                        setState(() {
                          quantity--;
                          pricing = price * quantity;
                        });
                      }
                    } else if (index == 2) {
                      setState(() {
                        quantity++;
                        pricing = price * quantity;
                      });
                    }
                  },
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(name,
                        style: const TextStyle(fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    Text("\$$pricing",
                        style: const TextStyle(fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 80),
                SecondaryButton(
                  onPressed: () async{
                    //print(pricing);
                    // Create a Dog and add it to the dogs table
                    print(id);
                    var cartItem = CartData(
                      id:id,
                      name: name,
                      totalAmount: pricing.toInt(),
                      title: restaurantName,
                      quantity: quantity,
                      amount: amount.toInt(),
                    );
                    await SQL().insertCartData(cartItem).whenComplete((){
                      PrimarySnackBar(context).displaySnackBar(
                        message: "${name} added to cart",
                        //backgroundColor: AppColors.colorPrimary,
                      );

                      //Navigator.pushReplacementNamed(context, "home");
                      setState((){
                       // _animateToController.animate(anim);
                        cartLength();
                        quantity=1;
                      });

                      Navigator.pop(context);

                      //_animateToController.dispose();

                    });
                    // print("s");
                    // await  SQL().sql(widget.name, widget.title,
                    //     pricing);
                  },
                  color: Colors.green,
                  text: 'Add to Cart',
                  backgroundColor: Colors.green,
                )
              ],
            ),
          );

        });
      },
    );
  }
}
