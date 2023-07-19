import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:online_food/Size_of_screen.dart';
import 'package:online_food/feature/presentation/pages/delivery.dart';
import 'package:online_food/feature/presentation/pages/restaurantFood.dart';
import 'package:online_food/feature/presentation/widgets/buy.dart';
import 'package:online_food/feature/presentation/widgets/drawer.dart';
import 'package:online_food/user.dart';
import 'package:online_food/userProvider.dart';
import 'package:path/path.dart'  as p;
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import '../widgets/food_with_price.dart';
import 'package:online_food/sql_database.dart';
import 'package:provider/provider.dart';
import 'package:online_food/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseFirestore fireStore=FirebaseFirestore.instance;
  final List<String> imgList = [
    "./assets/images.burger.jpg",
    "./assets/images.god_of war.png",
    "./assets/images.pizza.jpg",
    "./assets/images.pizza.jpg",
    "./assets/images.pizza.jpg"
  ];
  int _current = 0;
  int cartNumber=0;
  final CarouselController _controller = CarouselController();

  Future<int> cartLength() async {
    final database = openDatabase(
      p.join(await getDatabasesPath(), 'pashewCart.db'),
      version: 1,);
final db = await database;
    final List<Map<dynamic, dynamic>> maps =  await db.query('CARTTABLE');
    setState(() {
      cartNumber=maps.length;
    });
    //print(maps.length);
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
              Navigator.pushNamed(context, "specificBuyItem");
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
          // IconButton(
          //   icon: const Icon(Icons.shopping_cart),
          //   tooltip: 'Open shopping cart',
          //   onPressed: () {
          //     Navigator.pushNamed(context, "cart");
          //   },
          // ),
        ],
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
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
                   SizedBox(height:hS*1.875),
                  const Text("Popular Categories",style:TextStyle(fontSize:18)),
                 SizedBox(height: hS*0.625),

                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      category[0],
                      category[1],
                      category[2],
                      category[3],

                    ],
                  ),

                 SizedBox(height: 10),
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
                          return Center(child: const CircularProgressIndicator());
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
                                builder: (BuildContext cotext){
                                  return RestaurantMenu(
                                    id:data?["id"],
                                      restaurantName:data?["fullName"]
                                  );
                                }
                              ));
                            },
                            child: SizedBox(
                              height:  MediaQuery.sizeOf(context).height*33.75,
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
                                child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius:BorderRadius.circular(8),
                                        child:Image.network(
                                          data?["image"],
                                          height: hS*26.25,
                                          width: double.infinity,
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
                                                  : Colors.black) ,fontWeight:FontWeight.bold,
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
                          );
                        },
                      );
                    }
                  ),
                  SizedBox(height:20),
                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: getRestaurantManagers(),
                    builder: (context, snapshot) {
                      if(!snapshot.hasData){
                        return const Center(child: CircularProgressIndicator());
                      }
                      return Flexible(
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:snapshot.data?.docs.length,
                            itemBuilder:
                                (BuildContext context,int index)
                            {
                              QueryDocumentSnapshot<Object?>? data =
                                               snapshot.data?.docs[index];
                              return Container(
                                alignment: Alignment.bottomLeft,
                                margin: const EdgeInsets.only(bottom:10),
                                decoration: BoxDecoration(
                                    color:Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: Image.network(data?["image"],
                                    fit: BoxFit.fitWidth,
                            errorBuilder:(context, error, stackTrace) {
                                      return Container(
                                  color:Colors.white,
                                  width:double.infinity,
                                        height: 150,
                            );}).image
                                  )
                                ),
                                  height: 150,width:double.infinity,
                                child:Text(data?["fullName"],
                                style: const TextStyle(
                                  fontWeight:FontWeight.bold,
                                  fontSize: 18
                                ),)
                              );
                            }),
                      );
                    }
                  ),
                  // ]),
                  const SizedBox(height: 5)
                ],
              ),
            ),
      ),

    );
  }

Stream<QuerySnapshot<Map<String, dynamic>>> getRestaurantManagers(){
  final getData = fireStore
      .collection("pashewRestaurantManagerAccount")
      .snapshots();
  return getData;

}

late  List<Widget> category = [
    FoodCategory(onTap: () {
      },
        image: "salad.png",
        name: "All Food", amount: 20),
    FoodCategory(onTap: () {

      },
        image: "food.png",
        name: "BreakFast",
        amount: 25),
    FoodCategory(onTap: () {}, image: "snacks.png", name: "Snacks",
        amount: 55),
    FoodCategory(onTap: () {
      },
        image: "turkey.png", name: "Lunch",
        amount: 20),
    FoodCategory(onTap: () {
      },
        image: "awaakye.jpeg",
        name: "Awaakye",
        amount: 25),
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

 

  Future<Database> table()async{
    final database = openDatabase(

        p.join(await getDatabasesPath(), 'cart.db'),
            onCreate: (db, version) {
    return db.execute(
        'CREATE TABLE IF NOT EXISTS CARTTABLE (name TEXT PRIMARY KEY , amount INTEGER, totalAmount INTEGER, title TEXT, quantity INTEGER, id TEXT)');
    },
    version: 1,
    );
    print("ss");
    return database;
  }
}
