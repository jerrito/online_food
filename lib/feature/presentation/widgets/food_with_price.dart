import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';

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
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 190,
        height: 100,
        child: Container(
          width: 190,
          height: 100,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)),
          child: Column(children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              backgroundImage: Image.asset(
                "./assets/images/$image",
                fit: BoxFit.fitWidth,
              ).image,
            ),
            // Image.asset(
            //   "./assets/images/$image",
            //   height: 85,
            //   width: 180,
            // ),
            const SizedBox(height: 10),
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
                    fontWeight: FontWeight.bold, color: Colors.black))
          ]),
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
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              backgroundImage: Image.asset(
                "./assets/images/$image",
                fit: BoxFit.fitWidth,
              ).image,
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
