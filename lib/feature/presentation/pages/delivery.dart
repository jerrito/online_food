import 'package:flutter/material.dart';
import 'package:online_food/feature/presentation/widgets/MainButton.dart';
import 'package:online_food/feature/presentation/widgets/MainInput.dart';
import 'package:online_food/main.dart';

class DeliveryLocation extends StatefulWidget {
  const DeliveryLocation({Key? key}) : super(key: key);

  @override
  State<DeliveryLocation> createState() => _DeliveryLocationState();
}

class _DeliveryLocationState extends State<DeliveryLocation> {
  String regionValue = "Greater Accra";
  var regionItems = [
    "Greater Accra",
    "Ashanti",
    "Eastern",
    "Western",
    "Central",
    "Nothern",
    "Upper East",
    "Upper West",
    "Savannah",
    "Oti",
    "Bono",
    "Ahafo",
    "North East",
    "Western North",
  ];
  bool iconThemeCheck = true;
  bool saveLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Delivery Address')),
      body: Container(
        // width: SizeConfig.blockSizeHorizontal,
        // height: SizeConfig.blockSizeVertical * 71.652,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        margin: const EdgeInsets.all(10),
        child: Form(
          // key: location,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: ListView(children: [
                const Text("Select Region",
                    style: TextStyle(
                      //color: Colors.grey,
                      fontSize: 20,
                    )),
                Container(
                  height: 80,
                  width: w - 20, //alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: Colors.black,
                          width: 1,
                          style: BorderStyle.solid)),
                  child: DropdownButton(
                      value: regionValue,
                      dropdownColor: Colors.grey,
                      // !iconThemeCheck ? Colors.grey : Colors.white,
                      style: TextStyle(color: Colors.white),
                      icon: Icon(Icons.keyboard_arrow_down,
                          color: Colors.amberAccent
                          //!iconThemeCheck ? Colors.amberAccent : Colors.black,
                          ),
                      items: regionItems.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // SizedBox(width: SizeConfig.blockSizeHorizontal*5.56,),
                              Text(items,
                                  style: TextStyle(
                                      color: !iconThemeCheck
                                          ? Colors.amberAccent
                                          : Colors.black)),
                              SizedBox(
                                width: (w - 20) - 117,
                              )
                            ],
                          ),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          regionValue = newValue!;
                          // region = regionValue;
                        });
                      }),
                ),
                SizedBox(height: hS * 2.84375),
                const Text("Address",
                    style: TextStyle(
                      //color: Colors.grey,
                      fontSize: 20,
                    )),
                SecondaryInput(
                  //initialValue: user?.address,
                  onChanged: (value) {
                    //  address = value;
                  },
                  // validator: inputValidator,
                  // controller: usernumber,
                  keyboardType: TextInputType.text,
                  hintText: "Stephen", obscureText: false,
                ),
                SizedBox(height: hS * 2.84375),
                const Text("Nearest Landmark",
                    style: TextStyle(
                      //color: Colors.grey,
                      fontSize: 20,
                    )),
                Focus(
                  onFocusChange: (sees) {
                    setState(() {
                      //see = false;
                    });
                  },
                  child: SecondaryInput(
                    //initialValue: user?.landmark,
                    obscureText: false,
                    onChanged: (value) {
                      // landmark = value;
                      setState(() {
                        //  see = true;
                        // appear = value;
                      });
                    },
                    // validator: inputValidator,
                    // controller: usernumber,
                    keyboardType: TextInputType.text,
                    hintText: "",
                  ),
                ),
              ])),
              SizedBox(height: hS * 14.75),
              SizedBox(
                width: 340,
                child: MainButton(
                  onPressed: () async {
                    //if (location.currentState?.validate() == true) {
                    setState(() {
                      //saveLoading = true;
                    });
                    //var userData = user;
                    // userData?.address = address;
                    // userData?.region = region;
                    // userData?.landmark = landmark;
                    // await updateUser(user: userData!);
                    setState(() {
                      //saveLoading = false;
                    });
                    Navigator.pop(context);
                    //}
                  },
                  color: Colors.pink,
                  backgroundColor: Colors.pink,
                  child: Visibility(
                    visible: saveLoading,
                    child: SizedBox(
                      // width: Dimens.iconNormal,
                      // height: Dimens.iconNormal,
                      child: Text(""),
                    ),
                    replacement: const Text(
                      "Save",
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 3,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
