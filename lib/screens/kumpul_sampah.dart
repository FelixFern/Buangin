import 'dart:async';

import 'package:buangin_app/screens/kurir.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: camel_case_types
class kumpulSampah extends StatefulWidget {
  @override
  _kumpulSampahState createState() => _kumpulSampahState();
}

// ignore: camel_case_types
class _kumpulSampahState extends State<kumpulSampah> {
  Completer<GoogleMapController> _controller = Completer();

  List<Marker> markerLokasi = [];
  _handleTap(LatLng tappedPoint) {
    setState(() {
      markerLokasi = [];
      markerLokasi.add(Marker(
          markerId: MarkerId(tappedPoint.toString()), position: tappedPoint));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black87),
          title: Text(
            "Kumpulkan Sampah",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.black87,
                fontSize: 20),
          ),
          elevation: 4.0,
          backgroundColor: Colors.white),
      body: ListView(children: [
        Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 1), // changes position of shadow
            )
          ]),
          height: MediaQuery.of(context).size.height * 0.6,
          child: Stack(children: [
            GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                target: LatLng(3.595196, 98.672226),
                zoom: 15.0,
              ),
              markers: Set.from(markerLokasi),
              onTap: _handleTap,
            ),
          ]),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.22,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  child: Text(
                    "Pilih Lokasi",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 30,
                    child: TextField(
                      decoration: InputDecoration(hintText: "Alamat Tujuan"),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => kurirScreen()));
                        },
                        child: Text(
                          "Panggil Kurir",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              letterSpacing: 1),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Color.fromRGBO(18, 189, 38, 1),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                        )),
                  ),
                ],
              ),
            ],
          ),
        )
      ]),
    );
  }
}
