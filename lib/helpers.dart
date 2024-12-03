import 'dart:io';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';

Future<String> getAppDownloadFolderPath() async {
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
  final folderPath = await getAppDownloadFolderPath();
  final file = File('$folderPath/$fileName');
  return file.existsSync();
}

// void openFile(String filePath) async {
//   await OpenFile.open(
//     filePath,
//   );

// final extension =
//     path.extension(file.path!); //import 'package:path/path.dart' as path;
// await OpenFile.open(file.path, type: extension);
// }

Future<void> openFile(String filePath) async {
  // final filePath = '/storage/emulated/0/update.apk';
  // final result = await OpenFile.open(filePath);
  await OpenFile.open(filePath);
}
