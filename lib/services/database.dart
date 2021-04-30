import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference dataUser =
      FirebaseFirestore.instance.collection("dataUser");
  final CollectionReference statusKurir =
      FirebaseFirestore.instance.collection('statusKurir');

  Future updateUserData(int saldo, double beratSampah, int poin) async {
    return await dataUser.doc(uid).set({
      'saldo': saldo,
      'beratSampah': beratSampah,
      'poin': poin,
    });
  }

  Future updateDataKurir(String status, String nama) async {
    return await statusKurir.doc(uid).set({
      'nama': nama,
      'status': status,
    });
  }

  Future addHistorySaldo(
      int nominal, String tanggal, DateTime sortDate, int jenis) async {
    final CollectionReference historyData = FirebaseFirestore.instance
        .collection('dataUser')
        .doc(uid)
        .collection('history');
    return await historyData.add({
      'nominal': nominal,
      'tanggal': tanggal,
      'sortDate': sortDate,
      'jenis': jenis
    });
  }

  Future addHistorySampah(int nominal, String tanggal, DateTime sortDate,
      double berat, int poin) async {
    final CollectionReference sampahData = FirebaseFirestore.instance
        .collection('statusKurir')
        .doc(uid)
        .collection('historySampah');
    return await sampahData.add({
      'nominal': nominal,
      'poin': poin,
      'tanggal': tanggal,
      'sortDate': sortDate,
      'berat': berat,
    });
  }

  Future addVoucher(String nama, int nominal, String tanggal, DateTime sortDate,
      String kode) async {
    final CollectionReference voucherUser = FirebaseFirestore.instance
        .collection('dataUser')
        .doc(uid)
        .collection("voucherUser");
    return await voucherUser.add({
      'nama': nama,
      'nominal': nominal,
      'tanggal': tanggal,
      'sortDate': sortDate,
      'kode': kode
    });
  }
}
