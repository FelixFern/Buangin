import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

// ignore: camel_case_types
class kotakSaldo extends StatefulWidget {
  @override
  _kotakSaldoState createState() => _kotakSaldoState();
}

// ignore: camel_case_types
class _kotakSaldoState extends State<kotakSaldo> {
  @override
  // ignore: override_on_non_overriding_member
  getData() {
    String userId = (FirebaseAuth.instance.currentUser).uid;
    return userId;
  }

  Widget build(BuildContext context) {
    final userID = getData();
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .17),
      child: Container(
        height: 85,
        width: MediaQuery.of(context).size.width * 0.51,
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/image/saldo_logo.png',
                width: 40,
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        "Saldo",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
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
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300),
                            ),
                            Text(
                              NumberFormat.currency(locale: 'eu', symbol: '')
                                  .format(snapshot.data['saldo'])
                                  .toString(),
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        );
                      })
                ],
              ),
              SizedBox(
                width: 5,
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
