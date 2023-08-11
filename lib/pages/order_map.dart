import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
class OrderMap extends StatefulWidget {
  const OrderMap({Key? key}) : super(key: key);

  @override
  State<OrderMap> createState() => _OrderMapState();
}

class _OrderMapState extends State<OrderMap> {
  // default constructor
  // MapController mapController = MapController(
  //   initPosition: GeoPoint(latitude: 47.4358055, longitude: 8.4737324),
  //   areaLimit: BoundingBox(
  //     east: 10.4922941,
  //     north: 47.8084648,
  //     south: 45.817995,
  //     west:  5.9559113,
  //   ),
  // );
// or set manually init position
//   final controller = MapController.withPosition(
//     initPosition: GeoPoint(
//       latitude: 47.4358055,
//       longitude: 8.4737324,
//     ),
//   );
// init the position using the user location
  final mapController = MapController.withUserPosition(
      trackUserLocation: const UserTrackingOption(
        enableTracking: true,
        unFollowUser: false,
      ),
   //areaLimit: BoundingBox.
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your order"),
        actions: [
          IconButton(
            icon: const Icon(Icons.location_on),
            tooltip: 'Current Location',
            onPressed: () async{
              await  mapController.currentLocation();
              print(mapController.myLocation().toString());
              },
          ),
          IconButton(
            icon: const Icon(Icons.zoom_in),
            tooltip: 'Zoom in',
            onPressed: () async{
              await mapController.zoomIn();
            },
          ),
          IconButton(
            icon: const Icon(Icons.zoom_out),
            tooltip: 'Zoom out',
            onPressed: () async{
              await mapController.zoomOut();

            },
          ),



        ],
      ),
      body: SingleChildScrollView(
       // padding: const EdgeInsets.all(10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  decoration: BoxDecoration(
                      color:Colors.grey,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  width:double.infinity,height: 400,
                  child:OSMFlutter(
                    controller:mapController,
                    userTrackingOption: const UserTrackingOption(
                      enableTracking: true,
                      unFollowUser: false,
                    ),
                    //isPicker: true,
                    initZoom: 12,
                    minZoomLevel: 6,
                    maxZoomLevel: 18,
                    stepZoom: 1.0,
                    userLocationMarker: UserLocationMaker(
                      personMarker: const MarkerIcon(
                        icon: Icon(
                          Icons.location_history_rounded,
                          color: Colors.red,
                          size: 48,
                        ),
                      ),
                      directionArrowMarker: const MarkerIcon(
                        icon: Icon(
                          Icons.double_arrow,
                          size: 48,
                        ),
                      ),
                    ),
                    roadConfiguration: const RoadOption(
                      roadColor: Colors.yellowAccent,
                    ),
                    markerOption: MarkerOption(
                        defaultMarker: const MarkerIcon(
                          icon: Icon(
                            Icons.person_pin_circle,
                            color: Colors.blue,
                            size: 56,
                          ),
                        )
                    ),
                  )
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    color:Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                width:double.infinity,height: 200,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Delivery Details",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),

                    Text("Address",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                    Text("Eastern \nBP \nAK-071-6540"),
                    Text("Kumasi-Ghana"),
                  ],
                ),
              ),
              const SizedBox(height:10),



            ]),
      ),
    );
  }
}
