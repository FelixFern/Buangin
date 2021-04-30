import 'package:buangin_app/screens/box/history_saldo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buangin_app/services/database.dart';
import 'package:intl/intl.dart';

// ignore: camel_case_types
class saldoMenu extends StatefulWidget {
  @override
  _saldoMenuState createState() => _saldoMenuState();
}

class Item {
  final String nama;
  final String logo;
  const Item(this.nama, this.logo);
}

// ignore: camel_case_types
class _saldoMenuState extends State<saldoMenu> {
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
      int x = await documentSnapshot.data()["saldo"];
      return (x);
    } catch (e) {
      print(e);
    }
  }

  void _update(nominal) async {
    try {
      final userID = getData();
      FirebaseFirestore.instance
          .collection('dataUser')
          .doc(userID)
          .update({'saldo': nominal});
    } catch (e) {
      print(e);
    }
  }

  Item valueChoose;
  List namaBank = [
    const Item('Bank BCA', 'assets/image/logo_bank/bca.png'),
    const Item('Bank Mandiri', 'assets/image/logo_bank/mandiri.png'),
    const Item('Bank BNI', 'assets/image/logo_bank/bni.png'),
    const Item('OVO', 'assets/image/logo_bank/ovo.png'),
    const Item('DANA', 'assets/image/logo_bank/dana.png'),
    const Item('Gopay', 'assets/image/logo_bank/gopay.png'),
  ];
  TextEditingController nominalDitarik = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final userID = getData();

    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black87),
          title: Text(
            "Saldo",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.black87,
                fontSize: 20),
          ),
          elevation: 4.0,
          backgroundColor: Colors.white),
      body: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 25,
          ),
          Container(
            alignment: Alignment.topCenter,
            child: Container(
              height: 115,
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
                        Row(
                          children: [
                            Text(
                              "Saldo Anda",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('dataUser')
                                .doc(userID)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData)
                                return CircularProgressIndicator();
                              return Row(
                                children: [
                                  Text(
                                    "Rp.",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    NumberFormat.currency(
                                            locale: 'eu', symbol: '')
                                        .format(snapshot.data['saldo'])
                                        .toString(),
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              );
                            })
                      ],
                    ),
                    SizedBox(
                      width: 15,
                    ),
                  ],
                ),
                color: Color.fromRGBO(0, 170, 19, 1),
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
              child: Text(
            "Penarikan Saldo",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          )),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nominal : ",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 30,
                  child: TextField(
                    decoration: InputDecoration(hintText: "Rp. xxx.xxx"),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    controller: nominalDitarik,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Bank Tujuan : ",
                  style: TextStyle(fontSize: 15),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: DropdownButton<Item>(
                    hint: Text("Bank Tujuan"),
                    value: valueChoose,
                    icon: Icon(Icons.arrow_drop_down),
                    isExpanded: true,
                    onChanged: (Item newValue) {
                      setState(() {
                        valueChoose = newValue;
                      });
                    },
                    items: namaBank.map((valueItem) {
                      return DropdownMenuItem<Item>(
                        value: valueItem,
                        child: Row(
                          children: [
                            Image.asset(
                              valueItem.logo,
                              width: 30,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(valueItem.nama),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "No. Rekening : ",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 30,
                  child: TextField(
                    decoration: InputDecoration(hintText: "Rekening Tujuan"),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextButton(
                      onPressed: () {
                        return showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Penarikan Saldo"),
                                content: Text(
                                    "Apakah anda ingin melanjutkan penarikan saldo ?"),
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
                                        int ditarik =
                                            int.parse(nominalDitarik.text);
                                        int awal = await _read();
                                        if (awal >= ditarik &&
                                            nominalDitarik.text != null &&
                                            valueChoose.nama != null) {
                                          DateTime date = DateTime.now();
                                          String now =
                                              DateFormat('yyyy-MM-dd HH:mm')
                                                  .format(date);
                                          await DatabaseService(uid: userID)
                                              .addHistorySaldo(
                                                  ditarik, now, date, 0);
                                          _update(awal - ditarik);
                                          Navigator.of(context).pop();
                                          nominalDitarik.clear();
                                          return showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                    title:
                                                        Text("Penarikan Saldo"),
                                                    content: Text(
                                                        "Penarikan Saldo Berhasil"),
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
                                          nominalDitarik.clear();
                                          Navigator.of(context).pop();
                                          return showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                    title:
                                                        Text("Penarikan Saldo"),
                                                    content: Text(
                                                        "Penarikan saldo gagal, Saldo Anda Tidak Cukup"),
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
                                                  title:
                                                      Text("Penarikan Saldo"),
                                                  content: Text(
                                                      "Penarikan Saldo Gagal, Mohon Isi Data yang Dibutuhkan"),
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
                                    },
                                  ),
                                ],
                              );
                            });
                      },
                      child: Text("Tarik Saldo",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                              letterSpacing: 1)),
                      style: TextButton.styleFrom(
                          backgroundColor: Color.fromRGBO(18, 189, 38, 1),
                          padding: EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)))),
                )
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Center(
            child: Text(
              "Riwayat Saldo",
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
                    .collection('dataUser')
                    .doc(userID)
                    .collection('history')
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
                            child: historySaldo(
                              jenis: document['jenis'],
                              nominal: document['nominal'],
                              date: document['tanggal'],
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
