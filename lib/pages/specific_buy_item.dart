import 'package:flutter/material.dart';

class SpecificBuyItem extends StatefulWidget {
  const SpecificBuyItem({Key? key}) : super(key: key);

  @override
  State<SpecificBuyItem> createState() => _SpecificBuyItemState();
}

class _SpecificBuyItemState extends State<SpecificBuyItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Burger')),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              itemBuilder: (context, int i) {
                return Container(
                  padding: EdgeInsets.all(10),
                  child: ListTile(
                    leading: Text("\$100",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    title: Text("Beef Burger"),
                    subtitle: Text("This is the food for you"),
                    trailing: CircleAvatar(
                      radius: 30,
                      foregroundImage:
                          Image.asset("./assets/images/burger.jpg").image,
                    ),
                  ),
                );
              },
              itemCount: 50,
            ),
          ),
        ],
      ),
    );
  }
}
