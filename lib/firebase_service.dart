import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase/userdata.dart';

class FirebaseService {
  static final COLLECTION_REF = "user";

  final firestore = FirebaseFirestore.instance;
  late final CollectionReference userREF;

  FirebaseService() {
    userREF = firestore.collection(COLLECTION_REF);
  }

  Stream<QuerySnapshot<Object?>> ambilData() {
    return userREF.snapshots();
  }

  void tambah(UserData userData) async {
    DocumentReference documentReference = userREF.doc(userData.nama);
    documentReference.set(userData.toJson());
  }

  void hapus(UserData userData) {
    DocumentReference documentReference = userREF.doc(userData.nama);
    documentReference.delete();
  }

  void ubah(UserData userData) {
    DocumentReference documentReference = userREF.doc(userData.nama);
    documentReference.update(userData.toJson());
  }
}
