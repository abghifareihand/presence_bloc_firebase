import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:presence_bloc_firebase/data/models/user_model.dart';

class UserDatasource {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<UserModel> streamUser() {
    String uid = auth.currentUser!.uid;
    return firestore.collection("pegawai").doc(uid).snapshots().map(
      (docSnapshot) {
        if (docSnapshot.exists) {
          final snapshot = docSnapshot.data() as Map<String, dynamic>;
          return UserModel(
            address: snapshot['address'] ?? '',
            createdAt: snapshot['createdAt'] ?? '',
            email: snapshot['email'] ?? '',
            name: snapshot['name'] ?? '',
            nip: snapshot['nip'] ?? '',
            position: Position(
              lat: (snapshot['position'] != null)
                  ? (snapshot['position']['lat'] as num?)?.toDouble() ?? 0.0
                  : 0.0,
              lng: (snapshot['position'] != null)
                  ? (snapshot['position']['lng'] as num?)?.toDouble() ?? 0.0
                  : 0.0,
            ),
            role: snapshot['role'] ?? '',
            uid: snapshot['uid'] ?? '',
          );
        } else {
          throw Exception("Dokumen tidak ditemukan");
        }
      },
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamLastPresence() async* {
    String uid = auth.currentUser!.uid;
    yield* firestore
        .collection("pegawai")
        .doc(uid)
        .collection("presence")
        .orderBy("date", descending: true)
        .limitToLast(5)
        .snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamTodayPresence() async* {
    String uid = auth.currentUser!.uid;
    String todayId =
        DateFormat.yMd().format(DateTime.now()).replaceAll('/', '-');
    yield* firestore
        .collection("pegawai")
        .doc(uid)
        .collection("presence")
        .doc(todayId)
        .snapshots();
  }
}
