import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class StoreData {
  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    Reference ref = _storage.ref().child(childName);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    print("store: $downloadUrl");
    return downloadUrl;
  }

  Future<String> saveData({
    required String id,
    required Uint8List file,
  }) async {
    String resp = " Some Error Occurred";
    try {
      if (id.isNotEmpty) {
        String imageUrl = await uploadImageToStorage('profileImage', file);
        await _firestore
            .collection('userProfile')
            .add({'id': id, 'imageLink': imageUrl});
        resp = 'success';
      }
    } catch (err) {
      resp = err.toString();
    }
    return resp;
  }
}
