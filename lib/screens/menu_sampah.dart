import 'package:buangin_app/screens/box/history_sampah.dart';
import 'package:buangin_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'dart:math';

// ignore: camel_case_types
class sampahMenu extends StatefulWidget {
  @override
  _sampahMenuState createState() => _sampahMenuState();
}

// ignore: camel_case_types
class _sampahMenuState extends State<sampahMenu> {
  Color warna;
  getData() {
    String userId = (FirebaseAuth.instance.currentUser).uid;
    return userId;
  }

  _readSaldo() async {
    DocumentSnapshot documentSnapshot;
    try {
      final userID = getData();
      documentSnapshot = await FirebaseFirestore.instance
          .collection('dataUser')
          .doc(userID)
          .get();
      int x = await documentSnapshot.data()["saldo"];
      return (x);
    } catch (e) {
      print(e);
    }
  }

  _readPoin() async {
    DocumentSnapshot documentSnapshot;
    try {
      final userID = getData();
      documentSnapshot = await FirebaseFirestore.instance
          .collection('dataUser')
          .doc(userID)
          .get();
      int x = await documentSnapshot.data()["poin"];
      return (x);
    } catch (e) {
      print(e);
    }
  }

  _readBerat() async {
    DocumentSnapshot documentSnapshot;
    try {
      final userID = getData();
      documentSnapshot = await FirebaseFirestore.instance
          .collection('dataUser')
          .doc(userID)
          .get();
      double x = await documentSnapshot.data()["beratSampah"];
      return (x);
    } catch (e) {
      print(e);
    }
  }

  void _update(nominal, poin, berat) async {
    try {
      final userID = getData();
      FirebaseFirestore.instance
          .collection('dataUser')
          .doc(userID)
          .update({'saldo': nominal, 'poin': poin, 'beratSampah': berat});
    } catch (e) {
      print(e);
    }
  }

  _getColor() async {
    DocumentSnapshot documentSnapshot;
    try {
      final userID = getData();
      documentSnapshot = await FirebaseFirestore.instance
          .collection("statusKurir")
          .doc(userID)
          .get();
      String x = await documentSnapshot.data()["status"];
      return x;
    } catch (e) {
      print(e);
    }
    _getColor().then((value) {
      if (value == "Tidak Aktif") {
        warna = Colors.black54;
      } else {
        warna = Colors.yellow[900];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String userID = getData();
    Color warna = Color.fromRGBO(0, 170, 19, 1);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Sampah Terkumpul",
          style: TextStyle(
              fontWeight: FontWeight.w700, color: Colors.white, fontSize: 20),
        ),
        backgroundColor: Color.fromRGBO(18, 189, 38, 1),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            decoration: BoxDecoration(
              color: Color.fromRGBO(18, 189, 38, 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('dataUser')
                        .doc(userID)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return CircularProgressIndicator();
                      return Text(
                          snapshot.data["beratSampah"].toStringAsFixed(2),
                          style: TextStyle(
                            fontSize: 85,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ));
                    }),
                Text(
                  "Kilogram",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.topCenter,
            child: GestureDetector(
              onTap: () async {
                double tambahBeratDouble = Random().nextDouble() * 5;
                double tambahSaldo = 3000 * tambahBeratDouble;
                double tambahPoin = 10 * tambahBeratDouble;
                DateTime date = DateTime.now();
                String now = DateFormat('yyyy-MM-dd HH:mm').format(date);
                DatabaseService(uid: userID).updateDataKurir("Tidak Aktif", "");
                DatabaseService(uid: userID).addHistorySampah(
                    tambahSaldo.toInt(),
                    now,
                    date,
                    tambahBeratDouble,
                    tambahPoin.toInt());
                DatabaseService(uid: userID)
                    .addHistorySaldo(tambahSaldo.toInt(), now, date, 1);
                int saldoAwal = await _readSaldo();
                int poinAwal = await _readPoin();
                double beratAwal = await _readBerat();
                _update(
                    saldoAwal + tambahSaldo.toInt(),
                    poinAwal + tambahPoin.toInt(),
                    beratAwal + tambahBeratDouble);
                String status = _getColor();
                if (status == "Tidak Aktif") {
                  warna = Colors.black54;
                } else {
                  warna = Colors.yellow[900];
                }
              },
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 25,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('statusKurir')
                                      .doc(userID)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData)
                                      return CircularProgressIndicator();
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          snapshot.data["status"],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20),
                                        ),
                                        Text(
                                          "Kurir - " + snapshot.data["nama"],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        )
                                      ],
                                    );
                                  }),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                  color: warna,
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Center(
            child: Text(
              "Riwayat Pengumpulan Sampah",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('statusKurir')
                    .doc(userID)
                    .collection('historySampah')
                    .orderBy("sortDate", descending: true)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) return ListView();
                  return Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width * 0.83,
                      child: ListView(
                        shrinkWrap: true,
                        children: snapshot.data.docs.map<Widget>((document) {
                          return Container(
                            child: historySampah(
                              nominal: document["nominal"],
                              poin: document["poin"],
                              date: document["tanggal"],
                              berat: document["berat"],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                }),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
