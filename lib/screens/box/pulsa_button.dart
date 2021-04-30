import 'package:flutter/material.dart';

class pulsaButton extends StatelessWidget {
  @override
  final logo;

  const pulsaButton({Key key, this.logo}) : super(key: key);
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: 55,
            height: 55,
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
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
            child: Image.asset(
              "assets/image/logo_pulsa/" + logo + ".png",
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            logo,
            style: TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }
}
