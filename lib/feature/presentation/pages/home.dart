import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:online_food/Size_of_screen.dart';
import 'package:online_food/feature/presentation/widgets/buy.dart';
import 'package:online_food/feature/presentation/widgets/drawer.dart';

import '../widgets/food_with_price.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> imgList = [
    "./assets/images.burger.jpg",
    "./assets/images.god_of war.png",
    "./assets/images.pizza.jpg"
  ];
  int _current = 0;
  final CarouselController _controller = CarouselController();
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
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            tooltip: 'Open shopping cart',
            onPressed: () {
              Navigator.pushNamed(context, "cart");
            },
          ),
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
      body: Container(
        color: const Color.fromRGBO(245, 245, 245, 0.6),
        // padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text("Popular Categories"),
            const SizedBox(height: 10),
            Flexible(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                reverse: true,
                itemCount: category.length,
                itemBuilder: (context, int i) {
                  return category[i];
                },
              ),
            ),
            // SizedBox(height: 20),
            CarouselSlider(
              items: items,
              options: CarouselOptions(
                viewportFraction: 0.6,
                autoPlay: true,
                enlargeCenterPage: false,
                enlargeFactor: 0.3,
                aspectRatio: 16 / 9,
              ),
            ),

            const SizedBox(height: 10),
            CarouselSlider.builder(
              itemCount: 3,
              options: CarouselOptions(
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
                // autoPlayAnimationDuration: Duration(seconds: 5),
              ),
              carouselController: _controller,
              //scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int i, int index) {
                return Row(
                  children: [
                    SizedBox(
                      height: 270,
                      width: 305,
                      child: Container(
                        height: 270,
                        width: 305,
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(children: [
                          Image.asset(
                            "./assets/images/pizza.jpg",
                            height: 210,
                            width: double.infinity - 120,
                          ),
                          const Positioned(
                              left: 110,
                              top: 115,
                              child: Text("Pizza",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 25))),
                          Positioned(
                            left: 110,
                            top: 135,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: imgList.asMap().entries.map((entry) {
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
                  ],
                );
              },
            ),
            // ]),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }

  List<Widget> category = [
    FoodCategory(onTap: () {}, image: "burger.jpg", name: "Sandwich"),
    FoodCategory(onTap: () {}, image: "friedrice.png", name: "Fried Rice"),
    FoodCategory(onTap: () {}, image: "pizza.jpg", name: "Pizza"),
    FoodCategory(onTap: () {}, image: "yam3.png", name: "Yam"),
    FoodCategory(onTap: () {}, image: "awaakye.jpeg", name: "Awaakye"),
  ];
  List<Widget> items = [
    FoodWithPrice(
        onTap: () {},
        image: "friedrice.png",
        name: "Fried Rice",
        title: "Curry Fried rice",
        amount: "25"),
    FoodWithPrice(
        onTap: () {},
        image: "burger.jpg",
        name: "Sandwich",
        title: "Burger Sandwich",
        amount: "45"),
    FoodWithPrice(
        onTap: () {},
        image: "awaakye2.png",
        name: "Awaakye",
        title: "Awaakye/fish",
        amount: "20"),
    FoodWithPrice(
        onTap: () {},
        image: "friedrice.png",
        name: "Fried Rice",
        title: "Curry Fried rice",
        amount: "25"),
    FoodWithPrice(
        onTap: () {},
        image: "gobe2.png",
        name: "Gari and Beans",
        title: "Gobe",
        amount: "25"),
    FoodWithPrice(
        onTap: () {},
        image: "yam3.png",
        name: "Plantain with Stew",
        title: "Bodie Ampesie",
        amount: "25"),
    FoodWithPrice(
        onTap: () {},
        image: "gobe2.png",
        name: "Gari and Beans",
        title: "Gobe",
        amount: "25"),
  ];

  void showModalSheet() {
    showModalBottomSheet<dynamic>(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      isScrollControlled: true,
      isDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return const Buying();
        });
      },
    );
  }
}
