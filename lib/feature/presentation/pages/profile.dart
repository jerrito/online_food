import "package:flutter/material.dart";
import "package:online_food/feature/presentation/widgets/profile_container.dart";

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Profile")),
        body: Container(
            color: const Color.fromRGBO(245, 245, 245, 0.6),
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const SizedBox(height: 20),
                CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.green,
                  backgroundImage:
                      Image.asset("./assets/images/god_of war.png").image,
                ),
                Flexible(
                  child: ListView(
                    children: [
                      const SizedBox(height: 50),
                      ProfileContainer(
                        title: 'Jerry Boateng',
                        onPressed: () {},
                      ),
                      ProfileContainer(
                        title: 'jerrito0240@gmail.com',
                        onPressed: () {},
                      ),
                      ProfileContainer(
                        title: '+233240845898',
                        onPressed: () {},
                      ),
                      ProfileContainer(
                        title: 'Oforikurom',
                        onPressed: () {},
                      ),
                      ProfileContainer(
                        title: 'Kumasi',
                        onPressed: () {},
                      ),
                      ProfileContainer(
                        title: 'exit',
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, "login");
                        },
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}
