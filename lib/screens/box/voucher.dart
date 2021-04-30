import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class voucher extends StatelessWidget {
  final String nama;
  final int nominal;
  final String kode;
  final String tanggal;

  const voucher({Key key, this.nama, this.nominal, this.kode, this.tanggal})
      : super(key: key);
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
        height: 110,
        width: MediaQuery.of(context).size.width * 0.5,
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
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
                  nama,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                Text(
                  "Rp." +
                      NumberFormat.currency(locale: 'eu', symbol: '')
                          .format(nominal)
                          .toString(),
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w700, color: warna),
                ),
                SizedBox(
                  height: 5,
                ),
                Text("Berlaku Hingga : "),
                Text(tanggal),
              ],
            ),
          ),
          SizedBox(
            width: 5,
          ),
          TextButton(
              onPressed: () {
                Clipboard.setData(new ClipboardData(
                    text: nama.toLowerCase() + nominal.toString() + "buangin"));
                final snackBar = SnackBar(
                  content: Text('Voucher Berhasil disalin'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Text(
                "Salin Kode",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
                softWrap: true,
              ),
              style: TextButton.styleFrom(
                  backgroundColor: warna,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)))),
        ]));
  }
}
