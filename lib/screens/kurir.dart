import 'dart:math';

import 'package:buangin_app/screens/home.dart';
import 'package:buangin_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: camel_case_types
class kurirScreen extends StatefulWidget {
  @override
  _kurirScreenState createState() => _kurirScreenState();
}

// ignore: camel_case_types
class _kurirScreenState extends State<kurirScreen> {
  getData() {
    String userId = (FirebaseAuth.instance.currentUser).uid;
    return userId;
  }

  List namaKurir = ["Budi Hartono", "Bambang", "Rudi Septiyadi"];
  List noHp = ["+6285123473328", "+6283144512349", "+628123456789"];

  int x = Random().nextInt(2);

  @override
  Widget build(BuildContext context) {
    String userID = getData();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Info Kurir",
          style: TextStyle(
              fontWeight: FontWeight.w700, color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(18, 189, 38, 1),
        elevation: 4.0,
        backwardsCompatibility: false,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Kurir Berhasil Ditemukan",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300)),
            SizedBox(
              height: 50,
            ),
            Image.asset(
              'assets/image/no_profile.jpg',
              width: 100,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              namaKurir[x],
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
            ),
            Text(
              "Kontak : " + noHp[x],
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              child: TextButton(
                  onPressed: () {
                    DatabaseService(uid: userID)
                        .updateDataKurir("Dalam Perjalanan", namaKurir[x]);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                  child: Text(
                    "Konfirmasi",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 1),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Color.fromRGBO(18, 189, 38, 1),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  )),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                  child: Text(
                    "Batalkan",
                    style: TextStyle(
                        color: Color.fromRGBO(18, 189, 38, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 1),
                  ),
                  style: TextButton.styleFrom(
                    side: BorderSide(
                        color: Color.fromRGBO(18, 189, 38, 1), width: 2),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
