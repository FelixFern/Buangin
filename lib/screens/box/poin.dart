import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: camel_case_types
class kotakPoin extends StatefulWidget {
  @override
  kotakPoinState createState() => kotakPoinState();
}

// ignore: camel_case_types
class kotakPoinState extends State<kotakPoin> {
  getData() {
    String userId = (FirebaseAuth.instance.currentUser).uid;
    return userId;
  }

  @override
  Widget build(BuildContext context) {
    final userID = getData();
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .17),
      child: Container(
        height: 85,
        width: MediaQuery.of(context).size.width * 0.40,
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/image/poin_logo.png',
                width: 40,
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Poin",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700),
                  ),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('dataUser')
                          .doc(userID)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData)
                          return CircularProgressIndicator();
                        return Text(
                          snapshot.data['poin'].toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w300),
                        );
                      })
                ],
              ),
              SizedBox(
                width: 15,
              ),
              Tab(
                  icon: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ))
            ],
          ),
          color: Color.fromRGBO(0, 170, 19, 1),
          elevation: 4.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
    );
  }
}
