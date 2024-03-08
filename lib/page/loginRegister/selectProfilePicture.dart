import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/authProvider.dart';
import 'package:flutter_application_1/extension/Color.dart';
import 'package:flutter_application_1/page/loginRegister/createProfile.dart';
import 'package:flutter_application_1/response/api.dart';
import 'package:provider/provider.dart';

class SelectProfilePicturePage extends StatefulWidget {
  final ImageProvider<Object>? profileImage;
  final String? image;
  final String? alias;
  final String? firstname;
  final String? lastname;
  final int? yearOfBirth;
  final String? gender;
  const SelectProfilePicturePage(
      {this.profileImage,
      this.image,
      this.alias,
      this.firstname,
      this.lastname,
      this.yearOfBirth,
      this.gender,
      super.key});

  @override
  State<SelectProfilePicturePage> createState() =>
      _SelectProfilePicturePageState();
}

class _SelectProfilePicturePageState extends State<SelectProfilePicturePage> {
  Uint8List? _image;
  // AssetImage? _defaultImage;

  ImageProvider? _selectImage;
  String? _imageString;
  String? _alias;
  String? _firstname;
  String? _lastname;
  int? _yearOfBirth;
  String? _gender;
  String? _id;
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

  Future<void> fetchProfile() async {
    String? token = Provider.of<AuthProvider>(context, listen: false).token;
    try {
      Map<String, dynamic> response = await getProfile(token!);
      setState(() {
        _id = response['data']['user']['id'];
      });
    } catch (e) {
      // print('Error fetching profile: $e');
    }
  }

  // void cameraImage() async {
  //   Uint8List cameraImg = await pickImage(ImageSource.camera);
  //   setState(() {
  //     _image = cameraImg;
  //     _selectImage = MemoryImage(_image!);
  //   });
  // }

  // void selectImage() async {
  //   Uint8List img = await pickImage(ImageSource.gallery);
  //   setState(() {
  //     _image = img;
  //     _selectImage = MemoryImage(_image!);
  //   });
  // }

  // void saveProfile() async {
  //   String id = _id!;
  //   String resp = await StoreData().saveData(id: id, file: _image!);
  // }

  @override
  void initState() {
    fetchProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // _imageString = widget.image;
    _alias = widget.alias;
    _firstname = widget.firstname;
    _lastname = widget.lastname;
    _yearOfBirth = widget.yearOfBirth;
    _gender = widget.gender;

    return Scaffold(
      backgroundColor: Color(hexColor('#FAFCFB')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 50),
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreateProfilePage(
                                      profileImage: widget.profileImage,
                                      image: widget.image,
                                      alias: _alias,
                                      firstname: _firstname,
                                      lastname: _lastname,
                                      yearOfBirth: _yearOfBirth,
                                      gender: _gender)));
                        },
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Color(hexColor('#484554')),
                          size: 24,
                        ),
                      ),
                      Text(
                        'เลือกตัวละคร',
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'IBMPlexSansThai',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 24,
                      ),
                    ]),
                SizedBox(
                  height: 26,
                ),
                Container(
                    height: 105,
                    width: 105,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(60)),
                    child: _selectImage != null
                        ? CircleAvatar(
                            radius: 52.5,
                            backgroundImage: _selectImage,
                          )
                        : widget.profileImage != null
                            ? CircleAvatar(
                                radius: 52.5,
                                backgroundImage: widget.profileImage,
                              )
                            : CircleAvatar(
                                maxRadius: 52.5,
                                minRadius: 52.5,
                                backgroundColor: Colors.grey[200],
                                backgroundImage: AssetImage(
                                    'assets/images/defaultProfile1.png'),
                              )),
                SizedBox(
                  height: 38,
                ),
                // Image.file(
                //   File(pickedFile!.path!),
                //   width: double.infinity,
                //   fit: BoxFit.cover,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () {
                          setState(() {
                            _selectImage =
                                AssetImage('assets/images/defaultProfile2.png');
                            _imageString = 'assets/images/defaultProfile2.png';
                          });
                        },
                        child:
                            Image.asset('assets/images/defaultProfile2.png')),
                    SizedBox(
                      width: 87,
                    ),
                    InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () {
                          setState(() {
                            _selectImage =
                                AssetImage('assets/images/defaultProfile3.png');
                            _imageString = 'assets/images/defaultProfile3.png';
                          });
                        },
                        child:
                            Image.asset('assets/images/defaultProfile3.png')),
                  ],
                ),
                SizedBox(
                  height: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () {
                          setState(() {
                            _selectImage =
                                AssetImage('assets/images/defaultProfile4.png');
                            _imageString = 'assets/images/defaultProfile4.png';
                          });
                        },
                        child:
                            Image.asset('assets/images/defaultProfile4.png')),
                    SizedBox(
                      width: 87,
                    ),
                    InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () {
                          setState(() {
                            _selectImage =
                                AssetImage('assets/images/defaultProfile5.png');
                            _imageString = 'assets/images/defaultProfile5.png';
                          });
                        },
                        child:
                            Image.asset('assets/images/defaultProfile5.png')),
                  ],
                ),
                SizedBox(
                  height: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () {
                          setState(() {
                            _selectImage =
                                AssetImage('assets/images/defaultProfile6.png');
                            _imageString = 'assets/images/defaultProfile6.png';
                          });
                        },
                        child:
                            Image.asset('assets/images/defaultProfile6.png')),
                    SizedBox(
                      width: 87,
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () {
                        showModalBottomSheet<void>(
                          context: context,
                          showDragHandle: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(25.0),
                            ),
                          ),
                          builder: (BuildContext context) {
                            return Container(
                              height: 180,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      const Text(
                                        'เลือกรูปโปรไฟล์',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontFamily: 'IBMPlexSansThai',
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          selectFile();
                                        },
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.image,
                                                size: 30,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'เลือกจากคลัง',
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  fontFamily: 'IBMPlexSansThai',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              )
                                            ]),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          // FcameraImage();
                                        },
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.photo_camera,
                                                size: 30,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'ถ่ายภาพ',
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  fontFamily: 'IBMPlexSansThai',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              )
                                            ]),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset('assets/images/addProfile.png'),
                          Icon(
                            Icons.add,
                            size: 38,
                            color: Color(hexColor('#2F4EF1')),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                MaterialButton(
                  color: Color(hexColor('#2F4EF1')),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(23.5),
                  ),
                  onPressed: () {
                    // saveProfile();
                    print("check $_imageString");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateProfilePage(
                                profileImage:
                                    _selectImage ?? widget.profileImage,
                                image: _imageString ?? widget.image,
                                alias: _alias,
                                firstname: _firstname,
                                lastname: _lastname,
                                yearOfBirth: _yearOfBirth,
                                gender: _gender)));
                  },
                  child: Container(
                    height: 47,
                    width: 350,
                    alignment: Alignment.center,
                    child: Text("ยืนยัน",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'IBMPlexSansThai',
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                  ),
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
