import 'package:animate_to/animate_to.dart';
import 'package:async/async.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:online_food/constants/Size_of_screen.dart';
import 'package:online_food/pages/delivery.dart';
import 'package:online_food/pages/res_popular_category.dart';
import 'package:online_food/pages/restaurantFood.dart';
import 'package:online_food/main.dart';
import 'package:online_food/pages/sql.dart';
import 'package:online_food/widgets/drawer.dart';
import 'package:online_food/databases/sql_database.dart';
import 'package:online_food/models/userProvider.dart';
import 'package:path/path.dart'  as p;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import '/widgets/food_with_price.dart';
import 'package:online_food/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_food/databases/sql_database.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseFirestore fireStore=FirebaseFirestore.instance;
  final _animateToController = AnimateToController();

  int _current = 0;
  int cartNumber=0;
  final CarouselController _controller = CarouselController();
 GlobalKey<AnimateToState> anim=GlobalKey<AnimateToState>();
  Future<int> cartLength() async {
final db = await Data().databases();
    final List<Map<dynamic, dynamic>> maps =  await db.query('CARTTABLE');
    setState(() {
      cartNumber=maps.length;
    });
    return maps.length;
  }
  CustomerProvider? customerProvider;

  @override
  void initState(){
    super.initState();
    customerProvider=context.read<CustomerProvider>();
    table();
    cartLength();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      drawer: const Drawers(),
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search for a specific food',
            onPressed: () {
              showSearch(context:context,
                  delegate:SearchFood());
              //  Navigator.pushNamed(context, "specificBuyItem");
            },
          ),
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
          const Padding(padding: EdgeInsets.only(right:10))
          
        ],
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () async{
              // await allIds();
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
            color: const Color.fromRGBO(245, 245, 245, 0.6),
            padding: const EdgeInsets.all(10),
            child:  Column(
              mainAxisSize : MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                   SizedBox(height:hS*1.25),
                 // const Text("My Location"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.location_on),
                      TextButton(
                          onPressed:(){
                            Navigator.push(
                              context,MaterialPageRoute(
                              builder:(BuildContext context,){
                                return const DeliveryMap();
                            }
                            )
                            );
                          },
                          child:Text(customerProvider!.appUser!.location==""?
                          "Set Location":"${customerProvider!.appUser!.location!.substring(0,30)}...",
                          style:const TextStyle(fontSize:18))),
                    ],
                  ),
                   SizedBox(height:hS*1.875),
                  const Text("Popular Categories",style:TextStyle(fontSize:18)),
                 SizedBox(height: hS*0.625),
                  Row(
                    //mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      category[0],
                      category[1],
                      category[2],
                      category[3],
                    ],
                  ),

                 const SizedBox(height: 10),
                  // CarouselSlider(
                  //   items: items,
                  //   options: CarouselOptions(
                  //     viewportFraction: 0.6,
                  //     autoPlay: true,
                  //     enlargeCenterPage: false,
                  //     enlargeFactor: 0.3,
                  //     aspectRatio: 16 / 9,
                  //   ),
                  // ),

               // SizedBox(height:hS*3.75),
                  //Row(),

                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream:getRestaurantManagers(),
                      builder: (context, snapshot) {
                        if(!snapshot.hasData){
                          return const Center(child: CircularProgressIndicator());
                        }
                      return CarouselSlider.builder(
                        itemCount:snapshot.data?.docs.length,
                        options: CarouselOptions(
                          pageSnapping:true,
                          //height:400,
                          scrollPhysics: const NeverScrollableScrollPhysics(),
                         // shrinkWrap: true,
                          reverse:true,
                          viewportFraction: 0.9,
                          autoPlay: true,
                          enlargeCenterPage: false,
                          enlargeFactor: 0.3,
                          aspectRatio: 16 / 9,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          },
                          //scrollDirection: Axis.vertical,
                          // autoPlayAnimationDuration: Duration(seconds: 5),
                        ),
                        carouselController: _controller,

                        itemBuilder: (BuildContext context, int i, int index) {
                          QueryDocumentSnapshot<Object?>? data =
                          snapshot.data?.docs[i];
                          return InkWell(
                            onTap:(){
                              Navigator.push(context,
                              MaterialPageRoute(
                                builder: (BuildContext context){
                                  return RestaurantMenu(
                                    id:data?["id"],
                                      restaurantName:data?["fullName"]
                                  );
                                }
                              ));
                            },
                            child: SizedBox(
                              height:  MediaQuery.sizeOf(context).height*35.75,
                              width:wS*84.72,
                              //child:
                                 // shape: BoxShape.rectangle,
                                  // borderRadius: BorderRadius.circular(10),
                                  // image: DecorationImage(
                                  //   image: Image.network(
                                  //     data?["image"],
                                  //     height: hS*26.25,
                                  //     width: double.infinity,
                                  //   ).image,
                                  // )
                               // ),
                                child: Container(
                                  height:  MediaQuery.sizeOf(context).height*33.75,
                                  width:wS*84.72,
                                  decoration:BoxDecoration(
                                    color:Theme.of(context)
                                        .brightness ==
                                        Brightness.dark
                                        ? Colors.white70:Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Stack(
                                      children: [
                                        Align(
                                          alignment:Alignment.center,
                                          child: ClipRRect(
                                            borderRadius:BorderRadius.circular(8),
                                            child:Image.network(
                                              data?["image"],
                                              height: hS*26.25,
                                              width: double.infinity,
                                              fit:BoxFit.fitWidth,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Container(
                                                  color:Colors.white,
                                                  width:double.infinity,
                                                  height: hS*26.25,
                                                );
                                              },
                                            )

                                          ),
                                        ),
                                    // Image.network(
                                    //   data?["image"],
                                    //   height: hS*26.25,
                                    //   width: double.infinity,
                                    // ),
                                    Align(
                                        alignment:Alignment.bottomLeft,
                                        child: Text(data?["fullName"],
                                            style: TextStyle(
                                                color:(Theme.of(context)
                                                    .brightness ==
                                                    Brightness.dark
                                                    ? Colors.amber
                                                    : Colors.amberAccent) ,fontWeight:FontWeight.bold,
                                                fontSize: 20))),
                                    Align(
                                      alignment:Alignment.bottomCenter,
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: snapshot.data!.docs.toList().asMap().entries.map((entry) {
                                            return GestureDetector(
                                              onTap: () =>
                                                  _controller.animateToPage(entry.key),
                                              child: Container(
                                                width: 12.0,
                                                height: 12.0,
                                                margin: const EdgeInsets.symmetric(
                                                    vertical: 8.0, horizontal: 4.0),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: (Theme.of(context)
                                                                    .brightness ==
                                                                Brightness.dark
                                                            ? Colors.white
                                                            : Colors.black)
                                                        .withOpacity(_current == entry.key
                                                            ? 0.9
                                                            : 0.4)),
                                              ),
                                            );
                                          }).toList()),
                                    )
                                  ]),
                                ),

                            ),
                          );
                        },
                      );
                    }
                  ),
                  const SizedBox(height:20),
                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: getRestaurantManagers(),
                    builder: (context, snapshot) {
                      if(!snapshot.hasData){
                        return const Center(child: CircularProgressIndicator());
                      }
                      return Flexible(
                        child: ListView.builder(
                          reverse: true,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:snapshot.data?.docs.length,
                            itemBuilder:(BuildContext context,int index) {
                            QueryDocumentSnapshot<Object?>? data =
                                               snapshot.data?.docs[index];

                           //  paths.add(data?["id"]);
                           // // SharedPreferences.getInstance();
                           //  print(paths);
                              return InkWell(
                                onTap:(){
                                  Navigator.push(context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context){
                                            return RestaurantMenu(
                                                id:data?["id"],
                                                restaurantName:data?["fullName"]
                                            );
                                          }
                                      ));
                                },
                                child: Container(
                                 // alignment: Alignment.bottomLeft,
                                  margin: const EdgeInsets.only(bottom:10),
                                   decoration: BoxDecoration(
                                      color:Theme.of(context).brightness==Brightness.dark?
                                      Colors.white70:Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                   ),
                                    height: 150,width:double.infinity,
                                  child:Stack(
                                    children: [
                                      Align(
                                        alignment:Alignment.center,
                                        child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                           child: Image.network(data?["image"],
                                                height: 150,width:double.infinity,
                                                fit: BoxFit.fitWidth,
                                                errorBuilder:(context, error, stackTrace) {
                                                  return Container(
                                                    color:Theme.of(context).brightness==Brightness.dark?
                                                    Colors.white70:Colors.white,
                                                    width:double.infinity,
                                                    height: 150,
                                                  );})
                                        ),
                                      ),
                                      Align(
                                        alignment:Alignment.bottomLeft,
                                        child: Text(data?["fullName"],
                                        style: const TextStyle(
                                          fontWeight:FontWeight.bold,
                                          fontSize: 18,
                                          color:Colors.amberAccent
                                        ),),
                                      ),
                                    ],
                                  )
                                ),
                              );
                            }),
                      );
                    }
                  ),

                  const SizedBox(height: 5),
                  // FutureBuilder(
                  //   future: getRestaurantManagersFuture(),
                  //     builder:(context,snapshot){
                  //     if(!snapshot.hasData){return const Text("");}
                  //     if(snapshot.connectionState==
                  //         ConnectionState.waiting){
                  //     return  const Text("");
                  //     }
                  //     return Flexible(
                  //       child: ListView.builder(
                  //         itemCount:snapshot.data?.docs.length,
                  //           physics: const NeverScrollableScrollPhysics(),
                  //           shrinkWrap: true,
                  //           itemBuilder: (context,index) {
                  //             QueryDocumentSnapshot<Object?>? data =
                  //             snapshot.data?.docs[index];
                  //             insertProductId(data?["id"]);
                  //             return const Text("");
                  //              // Text("Restaurants: ${snapshot.data?.docs.length}");
                  //           }
                  //         ),
                  //     );
                  //     } )
                ],
              ),
            ),
      ),

    );
  }


  Future<QuerySnapshot<Map<String, dynamic>>> getRestaurantManagersFuture() async{
    final getData = await fireStore
        .collection("pashewRestaurantManagerAccount")
        .get();

    return getData;

  }

Stream<QuerySnapshot<Map<String, dynamic>>> getRestaurantManagers(){
  final getData = fireStore
      .collection("pashewRestaurantManagerAccount")
      .snapshots();
  return getData;

}

late  List<Widget> category = [
    const FoodCategory(
        image: "salad.png",
        name: "Supper",
        category: "supper"),
    const FoodCategory(
        image: "food.png",
        name: "Breakfast",
        category: "breakfast"),
    const FoodCategory(
        image: "snacks.png", name: "Snacks",
        category: "snacks"),
    const FoodCategory(
        image: "turkey.png",
        name: "Lunch",
       category: "lunch"),

  ];
//  late List<Widget> items = [
//     FoodWithPrice(
//         onTap:(){
//           showBuying("friedrice.png","Fried Rice","Curry Fried rice",25);},
//         image: "friedrice.png",
//         name: "Fried Rice",
//         title: "Curry Fried rice",
//         amount: 25),
//     FoodWithPrice(
//         onTap: () {
//           showBuying("burger.jpg","Sandwich","Burger Sandwich",45);},
//         image: "burger.jpg",
//         name: "Sandwich",
//         title: "Burger Sandwich",
//         amount: 45),
//     FoodWithPrice(
//         onTap: () {
//           showBuying("awaakye2.png","Awaakye","Awaakye/fish",25);},
//         image: "awaakye2.png",
//         name: "Awaakye",
//         title: "Awaakye/fish",
//         amount: 25),
//     FoodWithPrice(
//         onTap: () {
//           showBuying("friedrice.png","Fried Rice","Curry Fried rice",30);},
//         image: "friedrice.png",
//         name: "Fried Rice",
//         title: "Curry Fried rice",
//         amount: 30),
//     FoodWithPrice(
//         onTap: () {
//           showBuying("gobe2.png","Gari and Beans","Gobe",20);},
//         image: "gobe2.png",
//         name: "Gari and Beans",
//         title: "Gobe",
//         amount: 20),
//     FoodWithPrice(
//         onTap: () {
//           showBuying("yam3.png","Plantain with Stew","Bodie Ampesie",25);},
//         image: "yam3.png",
//         name: "Plantain with Stew",
//         title: "Bodie Ampesie",
//         amount: 25),
//     FoodWithPrice(
//         onTap: () {showBuying("gobe2.png","Gari and Beans","Gobe",20);},
//         image: "gobe2.png",
//         name: "Gari and Beans",
//         title: "Gobe",
//         amount: 20),
//   ];


  Future<void> insertProductId(String id) async {
    final db = await Data().databases();
    // await db.delete("ProductIds");
    int id1 = await db.rawInsert(
          'REPLACE INTO ProductIds (id) VALUES("$id")');
     // print('inserted1: $id1');

  }

  Future<void> table()async{
    final db=await Data().databases();
    db.database.execute(
        'CREATE TABLE IF NOT EXISTS ProductIds (id TEXT Primary KEY)');

    return db.execute(
        'CREATE TABLE IF NOT EXISTS CARTTABLE (name TEXT PRIMARY KEY , amount INTEGER, totalAmount INTEGER, title TEXT, quantity INTEGER, id TEXT)');
  }

}

class SearchFood extends SearchDelegate{
  CustomerProvider? customerProvider;
  //BookProvider? productProvider;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
    throw UnimplementedError();
  }


  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          close(
              context,
              SearchFood(

              ));
        });
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    customerProvider=context.read<CustomerProvider>();
   // productProvider=context.read<ProductProvider>();
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('pashewRestaurantManagerAccount')
        //     .doc(customerProvider?.appUser?.id).
        // collection("Products")
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {

          if (snapshot.hasData) {
            final results =
            snapshot.data?.docs.where((restaurant) => restaurant['fullName'].contains(query));

            var booksCount = snapshot.data?.docs.length;
            return ListView(
              children: results!.map<Widget>((restaurant) => ListTile(
                  onTap:()async{
                    // await productProvider?.getProduct(
                    //     productName: book["productName"],
                    //     id:customerProvider!.appUser!.id! );
                    if(!context.mounted)return;
                    Navigator.push(context,
                        MaterialPageRoute(
                        builder: (BuildContext context){
                      return RestaurantMenu(
                          id:restaurant["id"],
                          restaurantName:restaurant["fullName"]
                      );
                    }
                    ));
                  },
                  leading: CircleAvatar(
                      backgroundImage:Image.network( restaurant['image'],).image),
                  title: Text(restaurant["fullName"]),
                  trailing:Text(restaurant["number"].toString()))).toList(),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SizedBox(
                width: wS * 72.22,
                height: hS * 20.625,
                child: const Center(
                    child: SpinKitFadingCube(
                      color: Colors.green,
                      size: 50.0,
                    )),
              ),
            );
          } else if (!snapshot.hasData) {
            return const Center(
                child: Text("No results match your search",
                    style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold)));
          } else {
            return Center(
              child: SizedBox(
                width: wS * 72.22,
                height: hS * 20.625,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.wifi_off,
                      color: Colors.green,
                      size: 30,
                    ),
                    SizedBox(height: 30),
                    Text("Network error",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            );
          }
        });
    //throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    customerProvider=context.read<CustomerProvider>();
    // productProvider=context.read<BookProvider>();
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('pashewRestaurantManagerAccount')
        //     .doc(customerProvider?.appUser?.id).
        // collection("Products")
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            final results =
            snapshot.data?.docs.where((restaurant) => restaurant['fullName'].contains(query));
           // var bookCount =  snapshot.data?.docs.length;
            return ListView(
              children: results!.map<Widget>((restaurant) => ListTile(
                  onTap: ()async{
                    // await productProvider?.getProduct(
                    //     productName: book["productName"],
                    //     id:customerProvider!.appUser!.id! );
                    if(!context.mounted)return;
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (BuildContext context){
                              return RestaurantMenu(
                                  id:restaurant["id"],
                                  restaurantName:restaurant["fullName"]
                              );
                            }
                        ));
                  },
                  leading: CircleAvatar(
                      backgroundImage:Image.network( restaurant['image'],).image),
                  title: Text(restaurant["fullName"]),
                  trailing:Text(restaurant["number"].toString()))).toList(),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SizedBox(
                width: wS * 72.22,
                height: hS * 20.625,
                child: const Center(
                    child: SpinKitFadingCube(
                      color: Colors.green,
                      size: 50.0,
                    )),
              ),
            );
          } else if (!snapshot.hasData) {
            return const Center(
                child: Text("No results match your search",
                    style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold)));
          } else {
            return Center(
              child: SizedBox(
                width: wS * 72.22,
                height: hS * 20.625,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.wifi_off,
                      color: Colors.green,
                      size: 30,
                    ),
                    SizedBox(height: 30),
                    Text("Network error",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            );
          }
        });
    throw UnimplementedError();
  }

}