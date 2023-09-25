import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthDatasource {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<User> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw ('User belum ada');
      } else if (e.code == 'wrong-password') {
        throw ('Password kamu salah');
      } else {
        throw ('Error: ${e.message}');
      }
    }
  }

  Future<User> registerUser(
      String nip, String name, String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String? uid = userCredential.user?.uid;

      await firestore.collection('pegawai').doc(uid).set({
        'nip': nip,
        'name': name,
        'email': email,
        'uid': uid,
        'role': 'karyawan',
        'createdAt': DateTime.now().toIso8601String()
      });
      return userCredential.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw ('Password kurang bagus');
      } else if (e.code == 'email-already-in-use') {
        throw ('Email sudah ada');
      } else {
        throw ('Error: ${e.message}');
      }
    }
  }

  Future<void> logoutUser() async {
    try {
      await auth.signOut();
    } catch (e) {
      throw ('Error: $e');
    }
  }
}
