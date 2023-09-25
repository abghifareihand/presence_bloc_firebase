import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';

class LocationDatasource {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Position> getPermissionLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    final position = await Geolocator.getCurrentPosition();
    return position;
  }

  Future<String> getAddressPosition(Position position) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      String address = '';
      if (placemarks.isNotEmpty) {
        final firstPlacemark = placemarks.first;
        address = firstPlacemark.street ?? '';

        address += ', ${firstPlacemark.subLocality}';
        address += ', ${firstPlacemark.locality}';
        address += ', ${firstPlacemark.subAdministrativeArea}';
        address += ', ${firstPlacemark.postalCode}';
      }

      // Memperbarui Firestore dengan alamat
      String uid = auth.currentUser!.uid;
      await firestore.collection('pegawai').doc(uid).update({
        'position': {
          'lat': position.latitude,
          'lng': position.longitude,
        },
        'address': address,
      });

      return address;
    } catch (e) {
      throw Exception('Failed to get address: $e');
    }
  }

  Future<void> presensi(
      Position position, String address, double distance) async {
    // masuk ke collection pegawai dan ke uid nya si pegawai
    String uid = auth.currentUser!.uid;
    CollectionReference<Map<String, dynamic>> colPresence =
        firestore.collection('pegawai').doc(uid).collection('presence');

    // buat database
    QuerySnapshot snapPresence = await colPresence.get();

    DateTime now = DateTime.now();
    String todayDocId = DateFormat.yMd().format(now).replaceAll('/', '-');

    String status = 'Diluar luar area';

    if (distance <= 200) {
      status = 'Diluar dalam area';
    }

    // cek doc
    if (snapPresence.docs.isEmpty) {
      // belum pernah absen dan set absen masuk pertama kali

      colPresence.doc(todayDocId).set({
        'date': now.toIso8601String(),
        'masuk': {
          'date': now.toIso8601String(),
          'lat': position.latitude,
          'lng': position.longitude,
          'address': address,
          'distance': distance,
        }
      });
    } else {
      // sudah pernah absen -> hari ini udah absen masuk/keluar belum?
      DocumentSnapshot<Map<String, dynamic>> todayDoc =
          await colPresence.doc(todayDocId).get();

      // print buat cek hari ini dah absen (true) = sudah absen

      if (todayDoc.exists == true) {
        //jika today doc true tinggal absen keluar / sudah absen masuk dan keluar
        Map<String, dynamic>? dataPresenceToday = todayDoc.data();
        if (dataPresenceToday?['keluar'] != null) {
          // sudah absen masuk dan keluar
        } else {
          // Hitung jarak antara lokasi absen keluar dan lokasi yang diharapkan
          double distance = Geolocator.distanceBetween(
            -6.325912189356302,
            106.8011669839052,
            position.latitude,
            position.longitude,
          ); // Ganti dengan koordinat lng yang diharapkan

          // absen keluar
          await colPresence.doc(todayDocId).update({
            'keluar': {
              'date': now.toIso8601String(),
              'lat': position.latitude,
              'lng': position.longitude,
              'address': address,
              'status': status,
              'distance': distance,
            }
          });
        }
      } else {
        // absen masuk
        await colPresence.doc(todayDocId).set({
          'date': now.toIso8601String(),
          'masuk': {
            'date': now.toIso8601String(),
            'lat': position.latitude,
            'lng': position.longitude,
            'address': address,
            'status': status,
            'distance': distance,
          }
        });
      }
    }
  }

  
}
