import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_file/open_file.dart';

class UploadScreen extends ConsumerStatefulWidget {
  static String routeId = "uploadRoute";
  const UploadScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UploadscreenState();
}

class _UploadscreenState extends ConsumerState<UploadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () async {
                final result = await FilePicker.platform.pickFiles();
                if (result == null) return;
                final file = result.files.first;
                openFile(file);
              },
              child: Text("Upload"),
            ),
          ),
        ],
      )),
    );
  }
}

void openFile(PlatformFile file) {
  OpenFile.open(file.path!);
}
