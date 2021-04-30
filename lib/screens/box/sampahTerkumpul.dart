import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: camel_case_types
class sampahTerkumpul extends StatefulWidget {
  @override
  _sampahTerkumpulState createState() => _sampahTerkumpulState();
}

// ignore: camel_case_types
class _sampahTerkumpulState extends State<sampahTerkumpul> {
  getData() {
    String userId = (FirebaseAuth.instance.currentUser).uid;
    return userId;
  }

  @override
  Widget build(BuildContext context) {
    String userID = getData();
    return Container(
        child: Column(
          children: [
            Container(
              child: Text(
                "Sampah Terkumpul",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromRGBO(0, 170, 19, 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('dataUser')
                    .doc(userID)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  return Text(snapshot.data["beratSampah"].toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 75,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ));
                }),
            Text(
              "Kilogram",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(
              height: 25,
            )
          ],
        ),
        margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromRGBO(18, 189, 38, 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 3,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ]));
  }
}
