import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uniarchive/helpers.dart';
import 'package:uniarchive/models.dart' as model;

class Filecard extends StatefulWidget {
  final model.Material file;
  const Filecard({super.key, required this.file});

  @override
  State<Filecard> createState() => _FilecardState();
}

class _FilecardState extends State<Filecard> {
  late String filePath; // File path for the material
  bool isDownloaded = false;

  @override
  void initState() {
    super.initState();
    _checkFileStatus();
  }

  Future<void> _checkFileStatus() async {
    final downloaded = await isFileDownloaded(widget.file.name);
    setState(() {
      isDownloaded = downloaded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 60,
      decoration: BoxDecoration(
        // color: Colors.blue, // Background color of the container
        border: Border.all(
          // color: Colors.blue, // Border color
          width: 2, // Border width
        ),
        borderRadius: BorderRadius.circular(10), // Rounded corners
      ),
      margin: const EdgeInsets.only(top: 10),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(
                Icons.file_present_rounded,
              ),
              onPressed: () {
                // Add search logic here
              },
            ),
            Text(widget.file.name),
            Spacer(),
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_horiz_outlined),
              onSelected: (String value) async {
                if (value == 'download') {
                  // await _handleDownload();
                } else if (value == 'view') {
                  // Add file viewing logic
                  print('Viewing file: ${widget.file.name}');
                } else if (value == 'share') {
                  // Add file sharing logic
                  print('Sharing file: ${widget.file.name}');
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    value: isDownloaded ? 'view' : 'download',
                    child: Row(
                      children: [
                        Icon(
                          isDownloaded ? Icons.visibility : Icons.download,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(isDownloaded ? 'View' : 'Download'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'share',
                    child: Row(
                      children: const [
                        Icon(Icons.share, size: 20),
                        SizedBox(width: 8),
                        Text('Share'),
                      ],
                    ),
                  ),
                ];
              },
            ), // This will push the following widget to the end of the row
          ],
        ),
      ),
    );
  }
}
