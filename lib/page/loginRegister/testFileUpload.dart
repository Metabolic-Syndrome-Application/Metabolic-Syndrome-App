import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class TestFileUpload extends StatefulWidget {
  const TestFileUpload({super.key});

  @override
  State<TestFileUpload> createState() => _TestFileUploadState();
}

class _TestFileUploadState extends State<TestFileUpload> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) {
      return;
    }
    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future uploadFile() async {
    final path = 'files/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);
    final snapshot = await uploadTask!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download Link: $urlDownload');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          // if()
          children: [
            if (pickedFile != null)
              Expanded(
                  child: Image.file(
                File(pickedFile!.path!),
                width: double.infinity,
                fit: BoxFit.cover,
              )),
            ElevatedButton(
                onPressed: selectFile, child: const Text('select file')),
            ElevatedButton(
                onPressed: uploadFile, child: const Text('upload file'))
          ],
        ),
      ),
    );
  }
}
