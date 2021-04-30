import 'package:buangin_app/screens/box/voucher.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class myVoucher extends StatefulWidget {
  @override
  _myVoucherState createState() => _myVoucherState();
}

class _myVoucherState extends State<myVoucher> {
  getData() {
    String userId = (FirebaseAuth.instance.currentUser).uid;
    return userId;
  }

  @override
  Widget build(BuildContext context) {
    final userID = getData();
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black87),
          title: Text(
            "Voucher Saya",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.black87,
                fontSize: 20),
          ),
          elevation: 4.0,
          backgroundColor: Colors.white),
      body: ListView(
        children: [
          SizedBox(
            height: 25,
          ),
          Center(
            child: Text("Voucher Saya",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('dataUser')
                    .doc(userID)
                    .collection('voucherUser')
                    .orderBy("sortDate", descending: true)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) return ListView();
                  return Container(
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: MediaQuery.of(context).size.height * 0.75,
                        child: ListView(
                          shrinkWrap: false,
                          children: snapshot.data.docs.map<Widget>((document) {
                            return Container(
                              child: voucher(
                                  nama: document['nama'],
                                  nominal: document['nominal'],
                                  kode: document['kode'],
                                  tanggal: document['tanggal']),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
