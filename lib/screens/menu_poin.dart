import 'package:buangin_app/screens/box/e-commerce.dart';
import 'package:buangin_app/screens/my_voucher.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

// ignore: camel_case_types
class poinMenu extends StatefulWidget {
  @override
  _poinMenuState createState() => _poinMenuState();
}

class Item {
  final int nominal;
  const Item(this.nominal);
}

class Item1 {
  final String nama;

  const Item1(this.nama);
}

// ignore: camel_case_types
class _poinMenuState extends State<poinMenu> {
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

  Item valueChoose;
  int pulsaTerpilih;
  List pulsa = [
    const Item(5000),
    const Item(10000),
    const Item(15000),
    const Item(20000),
    const Item(25000),
    const Item(30000),
  ];

  Item1 valueChoose1;
  List provider = [
    const Item1("Telkomsel"),
    const Item1("XL"),
    const Item1("Indosat"),
    const Item1("Axis"),
  ];

  void getNominal() {
    setState(() {
      pulsaTerpilih = valueChoose.nominal;
    });
  }

  TextEditingController noHp = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final userID = getData();
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black87),
          title: Text(
            "Poin",
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
                              "Poin Anda",
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
                                    snapshot.data["poin"].toString() + " Poin",
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
            height: 25,
          ),
          Center(
            child: Text("Tukarkan Poin Anda",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
          ),
          SizedBox(
            height: 5,
          ),
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Divider(
                  color: Color.fromRGBO(202, 202, 202, 1),
                  thickness: 1,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
              ),
              Text("Pulsa",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Provider : ",
                  style: TextStyle(fontSize: 15),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.77,
                  child: DropdownButton<Item1>(
                    hint: Text("Provider"),
                    value: valueChoose1,
                    icon: Icon(Icons.arrow_drop_down),
                    isExpanded: true,
                    onChanged: (Item1 newValue) {
                      setState(() {
                        valueChoose1 = newValue;
                      });
                    },
                    items: provider.map((valueItem1) {
                      return DropdownMenuItem<Item1>(
                        value: valueItem1,
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/image/logo_pulsa/" +
                                  valueItem1.nama +
                                  ".png",
                              width: 30,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(valueItem1.nama),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(
                  "No. Hp : ",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.77,
                  height: 30,
                  child: TextField(
                    decoration: InputDecoration(hintText: "08xx-xxxx-xxxx"),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    controller: noHp,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Nominal : ",
                  style: TextStyle(fontSize: 15),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.77,
                  child: DropdownButton<Item>(
                    hint: Text("Nominal"),
                    value: valueChoose,
                    icon: Icon(Icons.arrow_drop_down),
                    isExpanded: true,
                    onChanged: (Item newValue) {
                      setState(() {
                        valueChoose = newValue;
                      });
                    },
                    items: pulsa.map((valueItem) {
                      return DropdownMenuItem<Item>(
                        value: valueItem,
                        child: Row(
                          children: [
                            Text("Rp." +
                                NumberFormat.currency(locale: 'eu', symbol: '')
                                    .format(valueItem.nominal)
                                    .toString()),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.77,
                  child: TextButton(
                      onPressed: () async {
                        getNominal();
                        return showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              double poin = pulsaTerpilih / 1000;
                              int poinInt = poin.toInt();
                              return AlertDialog(
                                title: Text("Pulsa"),
                                content: RichText(
                                  text: TextSpan(
                                      style: new TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                      ),
                                      children: [
                                        TextSpan(
                                            text:
                                                "Apakah anda yakin ingin menukarkan "),
                                        TextSpan(
                                            text: poinInt.toString() + " Poin",
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    0, 170, 19, 1),
                                                fontWeight: FontWeight.w700)),
                                        TextSpan(text: " untuk pulsa senilai "),
                                        TextSpan(
                                            text: "Rp." +
                                                NumberFormat.currency(
                                                        locale: 'eu',
                                                        symbol: '')
                                                    .format(pulsaTerpilih)
                                                    .toString(),
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    0, 170, 19, 1),
                                                fontWeight: FontWeight.w700))
                                      ]),
                                ),
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
                                    child: Text("Lanjutkan",
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(0, 170, 19, 1))),
                                    onPressed: () async {
                                      print(pulsaTerpilih);
                                      print(noHp);
                                      try {
                                        int awal = await _read();
                                        double poin = pulsaTerpilih / 1000;
                                        int poinInt = poin.toInt();
                                        if (awal >= poinInt &&
                                            noHp.text != "" &&
                                            valueChoose1.nama != null) {
                                          _update(awal - poinInt);
                                          Navigator.of(context).pop();
                                          noHp.clear();
                                          return showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                    title: Text("Pulsa"),
                                                    content: Text(
                                                        "Pertukaran Poin Berhasil"),
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
                                                    title: Text("Pulsa"),
                                                    content: Text(
                                                        "Pertukaran Poin Gagal"),
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
                                        Navigator.of(context).pop();
                                        return showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                  title: Text("Pulsa"),
                                                  content: Text(
                                                      "Pertukaran Poin Gagal"),
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
                      child: Text(
                        "Tukarkan Poin",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 1),
                      ),
                      style: TextButton.styleFrom(
                          backgroundColor: Color.fromRGBO(18, 189, 38, 1),
                          padding: EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)))),
                ),
              ])),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
              ),
              Text("Voucher e-Commerce",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              Spacer(),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => myVoucher()));
                  },
                  child: Text(
                    "Voucher Saya",
                    style: TextStyle(color: Color.fromRGBO(0, 170, 19, 1)),
                  )),
              SizedBox(width: MediaQuery.of(context).size.width * 0.1),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Center(
            child: Column(
              children: [
                eCommerce(
                  nama: "Tokopedia",
                  nominal: 5000,
                  poin: 10,
                ),
                eCommerce(
                  nama: "Tokopedia",
                  nominal: 10000,
                  poin: 20,
                ),
                eCommerce(
                  nama: "Tokopedia",
                  nominal: 25000,
                  poin: 50,
                ),
                eCommerce(
                  nama: "Shopee",
                  nominal: 5000,
                  poin: 10,
                ),
                eCommerce(
                  nama: "Shopee",
                  nominal: 10000,
                  poin: 20,
                ),
                eCommerce(
                  nama: "Shopee",
                  nominal: 25000,
                  poin: 50,
                ),
                eCommerce(
                  nama: "Bukalapak",
                  nominal: 5000,
                  poin: 10,
                ),
                eCommerce(
                  nama: "Bukalapak",
                  nominal: 10000,
                  poin: 20,
                ),
                eCommerce(
                  nama: "Bukalapak",
                  nominal: 25000,
                  poin: 50,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
