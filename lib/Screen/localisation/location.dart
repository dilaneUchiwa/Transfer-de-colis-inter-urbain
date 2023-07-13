// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:firebase_database/firebase_database.dart';

// class MapScreen extends StatefulWidget {
//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   GoogleMapController? _mapController;
//   Marker? _marker;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GoogleMap(
//         onMapCreated: (controller) {
//           _mapController = controller;
//         },
//         initialCameraPosition: CameraPosition(
//           target: LatLng(5.478, 10.417),
//           zoom: 12,
//         ),
//           markers: _marker != null ? Set<Marker>.of([_marker!]) : Set<Marker>(),
//       ),
//     );
//   }

//   Future<void> afficherDernierPointSurCarte() async {
//     DatabaseReference databaseReference =
//         FirebaseDatabase.instance.ref().child('locations');

//     databaseReference
//         .orderByChild('timestamp')
//         .limitToLast(1)
//         .onValue
//         .listen((DatabaseEvent event) {
//       if (event.snapshot.value != null) {
//         String jsonString = json.encode(event.snapshot.value);
//         Map<String, dynamic> data = json.decode(jsonString);
//         data.forEach((key, value) {
//           double latitude = value['latitude'];
//           double longitude = value['longitude'];
//           String userId = value['userId'];
//           Marker marker = Marker(
//             markerId: MarkerId(userId),
//             position: LatLng(latitude, longitude),
//             infoWindow: InfoWindow(title: 'User $userId'),
//           );
//           setState(() {
//             _marker = marker;
//           });
//           _mapController!.animateCamera(
//             CameraUpdate.newCameraPosition(
//               CameraPosition(
//                 target: LatLng(latitude, longitude),
//                 zoom: 15.0,
//               ),
//             ),
//           );
//         });
//       }
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     afficherDernierPointSurCarte();
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:transfert_colis_interurbain/Domain/Model/Transfert.dart';

class MapScreen extends StatefulWidget {
  Transfert transfert;
  MapScreen(this.transfert, {super.key});
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final loc.Location location = loc.Location();
  late GoogleMapController _controller;
  bool _added = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseFirestore.instance.collection('location').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (_added) {
          MapScreen(snapshot);
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        return GoogleMap(
          mapType: MapType.normal,
          markers: {
            Marker(
                position: LatLng(
                  snapshot.data!.docs.singleWhere(
                      (element) => element.id == widget.transfert.travel.user.userId)['latitude'],
                  snapshot.data!.docs.singleWhere(
                      (element) => element.id ==  widget.transfert.travel.user.userId)['longitude'],
                ),
                markerId: MarkerId(widget.transfert.travel.user.userName!),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueMagenta)),
          },
          initialCameraPosition: CameraPosition(
              target: LatLng(
                snapshot.data!.docs.singleWhere(
                    (element) => element.id == widget.transfert.travel.user.userId)['latitude'],
                snapshot.data!.docs.singleWhere(
                    (element) => element.id == widget.transfert.travel.user.userId)['longitude'],
              ),
              zoom: 14.47),
          onMapCreated: (GoogleMapController controller) async {
            setState(() {
              _controller = controller;
              _added = true;
            });
          },
        );
      },
    ));
  }

  Future<void> MapScreen(AsyncSnapshot<QuerySnapshot> snapshot) async {
    await _controller
        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(
              snapshot.data!.docs.singleWhere(
                  (element) => element.id == widget.transfert.travel.user.userId)['latitude'],
              snapshot.data!.docs.singleWhere(
                  (element) => element.id == widget.transfert.travel.user.userId)['longitude'],
            ),
            zoom: 14.47)));
  }
}
