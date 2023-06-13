import 'package:flutter/material.dart';

class ProfileContainer extends StatelessWidget {
  final String title;
  final void Function() onPressed;
  const ProfileContainer(
      {Key? key, required this.title, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.only(bottom: 10),
        height: 70,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.white70),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("$title"),
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: onPressed,
            )
          ],
        ));
  }
}
