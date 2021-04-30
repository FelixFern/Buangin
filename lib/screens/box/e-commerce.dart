import 'package:buangin_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class eCommerce extends StatelessWidget {
  @override
  final String nama;
  final int nominal;
  final int poin;

  const eCommerce({Key key, this.nama, this.nominal, this.poin})
      : super(key: key);
  getData() {
    String userId = (FirebaseAuth.instance.currentUser).uid;
    return userId;
  }

  _read() async {
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

  void _update(poinNow) async {
    try {
      final userID = getData();
      FirebaseFirestore.instance
          .collection('dataUser')
          .doc(userID)
          .update({'poin': poinNow});
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var warna;
    if (nama == "Tokopedia") {
      warna = Color.fromRGBO(0, 170, 19, 1);
    } else if (nama == "Shopee") {
      warna = Color.fromRGBO(238, 76, 46, 1);
    } else {
      warna = Color.fromRGBO(231, 34, 84, 1);
    }
    final userID = getData();

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: Color.fromRGBO(244, 244, 244, 1),
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ]),
      height: 80,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 5,
          ),
          Image.asset(
            "assets/image/logo_e_commerce/" + nama + ".png",
            width: 80,
            height: 80,
          ),
          SizedBox(
            width: 3,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.37,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Voucher " + nama,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  "Rp." +
                      NumberFormat.currency(locale: 'eu', symbol: '')
                          .format(nominal)
                          .toString(),
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w700, color: warna),
                )
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 28,
                child: TextButton(
                    onPressed: () {
                      return showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Voucher " + nama),
                              content: Text(
                                  "Apakah anda ingin menukarkan voucher " +
                                      nama +
                                      " sejumlah" +
                                      " Rp." +
                                      NumberFormat.currency(
                                              locale: 'eu', symbol: '')
                                          .format(nominal)
                                          .toString() +
                                      "?"),
                              actions: [
                                TextButton(
                                  child: Text("Batal",
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(0, 170, 19, 1))),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text(
                                    "Lanjutkan",
                                    style: TextStyle(
                                        color: Color.fromRGBO(0, 170, 19, 1)),
                                  ),
                                  onPressed: () async {
                                    try {
                                      int awal = await _read();
                                      DateTime date = DateTime.now();
                                      DateTime monthAfter = DateTime(
                                          date.year, date.month + 1, date.day);
                                      String now = DateFormat('yyyy-MM-dd')
                                          .format(monthAfter);
                                      if (awal >= poin) {
                                        _update(awal - poin);
                                        DatabaseService(uid: userID).addVoucher(
                                            nama,
                                            nominal,
                                            now,
                                            date,
                                            nama +
                                                nominal.toString() +
                                                "buangin");
                                        Navigator.of(context).pop();
                                        return showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                  title:
                                                      Text("Voucher " + nama),
                                                  content: Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.1,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                            "Poin Berhasil Ditukarkan"),
                                                        Text(
                                                            "Kode Voucher : (Klik untuk copy)"),
                                                        GestureDetector(
                                                          onTap: () {
                                                            Clipboard.setData(
                                                                new ClipboardData(
                                                                    text: nama
                                                                            .toLowerCase() +
                                                                        nominal
                                                                            .toString() +
                                                                        "buangin"));
                                                            final snackBar =
                                                                SnackBar(
                                                              content: Text(
                                                                  'Voucher Berhasil disalin'),
                                                            );
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    snackBar);
                                                          },
                                                          child: Text(
                                                            nama.toLowerCase() +
                                                                nominal
                                                                    .toString() +
                                                                "buangin",
                                                            style: TextStyle(
                                                                color: warna,
                                                                fontSize: 20),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      child: Text("Tutup",
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      0,
                                                                      170,
                                                                      19,
                                                                      1))),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ]);
                                            });
                                      } else {
                                        Navigator.of(context).pop();
                                        return showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                  title:
                                                      Text("Voucher " + nama),
                                                  content: Text(
                                                      "Poin gagal ditukarkan"),
                                                  actions: [
                                                    TextButton(
                                                      child: Text("Tutup",
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      0,
                                                                      170,
                                                                      19,
                                                                      1))),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ]);
                                            });
                                      }
                                    } catch (e) {
                                      print(e);
                                      Navigator.of(context).pop();
                                      return showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                                title: Text("Voucher " + nama),
                                                content: Text(
                                                    "Poin gagal ditukarkan"),
                                                actions: [
                                                  TextButton(
                                                    child: Text("Tutup",
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    0,
                                                                    170,
                                                                    19,
                                                                    1))),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ]);
                                          });
                                    }
                                  },
                                ),
                              ],
                            );
                          });
                    },
                    child: Text(
                      "Tukarkan",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                      softWrap: true,
                    ),
                    style: TextButton.styleFrom(
                        backgroundColor: warna,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)))),
              ),
              SizedBox(
                height: 3,
              ),
              Row(
                children: [
                  Text(poin.toString(),
                      style: TextStyle(
                          color: warna,
                          fontWeight: FontWeight.w700,
                          fontSize: 14)),
                  Text(
                    " Poin",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
