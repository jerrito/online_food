import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:online_food/main.dart';

class FoodWithPrice extends StatelessWidget {
  final Function() onTap;
  final String image;
  final String name;
  final String title;
  final double amount;

  const FoodWithPrice(
      {Key? key,
      required this.onTap,
      required this.image,
      required this.name,
      required this.title,
      required this.amount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:hS*15.625,
      width:wS*52.78,
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            SizedBox(
              width:wS*52.78,
              height: hS*13,
              child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
              Container(
              width:  wS*52.78,
                height:( MediaQuery.sizeOf(context).height/100)*7,
                decoration: const BoxDecoration(
                   // shape: BoxShape.rectangle,
                    color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),)),
                Positioned(
                  top:0,left:wS*12.5,
                  child: CircleAvatar(
                    radius:50,
                    backgroundColor: Colors.white,
                    backgroundImage: Image.asset(
                      "./assets/images/$image",
                      fit: BoxFit.fitWidth,
                    ).image,
                  ),
                ),
                  ]),),
                // Image.asset(
                //   "./assets/images/$image",
                //   height: 85,
                //   width: 180,
                // ),
               // const SizedBox(height: 10),
                Container(
                  width: (w/100)*52.78,
                  height:
                  hS*12,
                  decoration: const BoxDecoration(
                    // shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),),
                  child: Column(
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
               const SizedBox(height: 5),
                Text(title),
                const SizedBox(height: 10),
                Text(amount.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black))
                    ],
                  ),
                ),

          ],
        ),
      ),
    );
  }
}

class FoodCategory extends StatelessWidget {
  final Function() onTap;
  final String image;
  final String name;
  final double amount;

  const FoodCategory({
    Key? key,
    required this.onTap,
    required this.image,
    required this.name, required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child:Image.asset(
                "./assets/images/$image",
                fit: BoxFit.scaleDown,
              ),

          ),
          // Container(
          //     height: 100,
          //     width: 100,
          //     margin: const EdgeInsets.all(10),
          //     decoration: BoxDecoration(
          //       shape: BoxShape.circle,
          //       image: DecorationImage(
          //           image: Image.asset("./assets/images/$image").image),
          //     )),
          Text(
            name,
          )
        ]));
  }
}

class FoodTypes extends StatelessWidget {
  final Function() onTap;
  final String image;
  final String name;
  final CarouselController controller;
  int? current = 0;
  final List<String> imgList;

  FoodTypes({
    Key? key,
    required this.onTap,
    required this.image,
    required this.name,
    required this.controller,
    this.current,
    required this.imgList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: SizedBox(
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
                      style: TextStyle(color: Colors.black, fontSize: 25))),
              Positioned(
                left: 110,
                top: 135,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imgList.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => controller.animateToPage(entry.key),
                        child: Container(
                          width: 12.0,
                          height: 12.0,
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black)
                                  .withOpacity(
                                      current == entry.key ? 0.9 : 0.4)),
                        ),
                      );
                    }).toList()),
              )
            ]),
          ),
        ));
  }
}
