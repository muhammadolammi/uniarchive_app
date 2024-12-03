import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uniarchive/apis/helper.dart';
import 'package:uniarchive/consts.dart';
import 'package:uniarchive/helpers.dart';

final firebaseApiProvider = Provider((ref) {
  return FirebaseApi();
});

class FirebaseApi {
  // let  firebaseToken = firebaseApp

  Future<String> uploadFile(
    PlatformFile file,
  ) async {
    // debugAppCheck();
    try {
      final fileref = storageRef.child("/files/${file.name}");
      final uploadTask = fileref.putFile(File(file.path!));
      await uploadTask.whenComplete(() {});

      return fileref.getDownloadURL();
    } catch (e) {
      throw ("Error $e");
    }
  }

  Future<String> downloadFile(
      String fileName, Function(double) onProgress) async {
    try {
      final firebasePath = "/files/$fileName";

      // debugAppCheck();

      // Get a reference to the file in Firebase Storage
      final storageRef = FirebaseStorage.instance.ref(firebasePath);

      // Get file metadata to get the total size
      final metadata = await storageRef.getMetadata();
      final totalBytes = metadata.size!;

      // Download file in chunks
      int bytesReceived = 0;
      List<int> bytes = [];

      // Download the file as bytes
      await storageRef.getData(totalBytes).then((data) {
        bytesReceived += data!.length;

        // Show progress
        double progress = bytesReceived / totalBytes;
        onProgress(progress);

        // Add data to bytes
        bytes.addAll(data);
      });

      // Save the file locally after download completes
      final directory = await getAppDownloadFolderPath();

      final filePath = '$directory/${firebasePath.split('/').last}';
      final file = File(filePath);
      log(filePath);

      // Write the data to a local file
      await file.writeAsBytes(bytes);

      return filePath; // Return the local file path
    } on FirebaseException catch (e) {
      throw Exception("Firebase error: ${e.message}");
    } catch (e) {
      throw Exception("Error downloading file: $e");
    }
  }
}
