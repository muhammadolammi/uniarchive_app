import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uniarchive/apis/firebase/firebase.dart';
import 'package:uniarchive/consts.dart';
import 'package:uniarchive/helpers.dart';
import 'package:uniarchive/models.dart' as model;
import 'package:uniarchive/widgets/showsnackbar.dart';

class Filecard extends ConsumerStatefulWidget {
  final model.Material material;
  const Filecard({super.key, required this.material});

  @override
  ConsumerState<Filecard> createState() => _FilecardState();
}

class _FilecardState extends ConsumerState<Filecard> {
  bool isDownloaded = false;

  @override
  void initState() {
    super.initState();
    _checkFileStatus();
  }

  Future<void> _checkFileStatus() async {
    final downloaded = await isFileDownloaded(widget.material.name);
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
            Text(widget.material.name),
            Spacer(),
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_horiz_outlined),
              onSelected: (String value) async {
                if (value == 'download') {
                  // await _handleDownload();
                } else if (value == 'view') {
                  // Add file viewing logic
                  print('Viewing file: ${widget.material.name}');
                } else if (value == 'share') {
                  // Add file sharing logic
                  print('Sharing file: ${widget.material.name}');
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    value: isDownloaded ? 'view' : 'download',
                    child: isDownloaded
                        ? GestureDetector(
                            onTap: () async {
                              final appDownloadPath =
                                  await getAppDownloadFolderPath();
                              final filePath =
                                  "$appDownloadPath/${widget.material.name}";
                              openFile(filePath);

                              Navigator.pop(context);
                            },
                            child: const Row(
                              children: [
                                Icon(Icons.visibility),
                                SizedBox(width: 8),
                                Text('View'),
                              ],
                            ),
                          )
                        : GestureDetector(
                            onTap: () async {
                              double progress = 0.0;

                              // Show progress dialog
                              showProgressDialog(context, progress);

                              try {
                                final filePath = await ref
                                    .read(firebaseApiProvider)
                                    .downloadFile(
                                  widget.material.name,
                                  (progress) {
                                    // This will be called when progress is updated
                                    showProgressDialog(context, progress);
                                  },
                                );

                                Navigator.pop(context); // Close dialog
                                showSnackBar(
                                  context: context,
                                  content:
                                      "Download complete! Saved at: $filePath",
                                );
                                log(filePath);

                                // Update file status
                                _checkFileStatus();
                                Navigator.pop(context);
                              } catch (e) {
                                Navigator.pop(context);

                                showSnackBar(
                                  context: context,
                                  content: "Download failed: $e",
                                );
                              }
                            },
                            child: const Row(
                              children: [
                                Icon(Icons.download),
                                SizedBox(width: 8),
                                Text('Download'),
                              ],
                            ),
                          ),
                  ),
                  const PopupMenuItem(
                    value: 'share',
                    child: Row(
                      children: [
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
