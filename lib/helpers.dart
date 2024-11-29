import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<String> getAppFolderPath() async {
  final directory =
      await getApplicationDocumentsDirectory(); // App-specific storage
  final appFolder = Directory('${directory.path}/uniarchive/downloads');

  if (!await appFolder.exists()) {
    await appFolder.create(
        recursive: true); // Create folder if it doesn't exist
  }
  return appFolder.path;
}

Future<bool> isFileDownloaded(String fileName) async {
  final folderPath = await getAppFolderPath();
  final file = File('$folderPath/$fileName');
  return file.existsSync();
}
