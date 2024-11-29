import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uniarchive/consts.dart';

final firebaseApiProvider = Provider((ref) {
  return FirebaseApi();
});

class FirebaseApi {
  Future<TaskSnapshot> uploadFile(File file) async {
    try {
      final uploadTask = storageRef.child(file.path).putFile(file);
      final snapshot = await uploadTask.whenComplete(() {});

      return snapshot;
    } catch (e) {
      throw ("Error $e");
    }
  }
//   uploadTask.snapshotEvents.listen((event) {
//   final percentage = (event.bytesTransferred / event.totalBytes) * 100;
//   print('Upload is ${percentage.toStringAsFixed(2)}% complete.');
// });

  Future downloadFile() async {}
}
