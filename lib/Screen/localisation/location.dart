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
      appBar: AppBar(title: const Text("Suivre un colis")),
        body: StreamBuilder(
      stream: FirebaseFirestore.instance.collection('locations')
          .orderBy('timestamp', descending: true)
          .limit(1)
          //.where('userId', isEqualTo: widget.transfert.travel.user.userId)
          .snapshots(),
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
                  snapshot.data!.docs.first['latitude'],
                  snapshot.data!.docs.first['longitude'],
                ),
                markerId: MarkerId(widget.transfert.travel.user.userName!),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueRed)),
          },
          initialCameraPosition: CameraPosition(
              target: LatLng(
                snapshot.data!.docs.first['latitude'],
                snapshot.data!.docs.first['longitude'],
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
              snapshot.data!.docs.first['latitude'],
              snapshot.data!.docs.first['longitude'],
            ),
            zoom: 14.47)));
  }
}