import 'dart:async';
import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
//import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/authProvider.dart';
import 'package:flutter_application_1/extension/Color.dart';
import 'package:flutter_application_1/page/loginRegister/login.dart';
import 'package:flutter_application_1/page/loginRegister/selectProfilePicture.dart';
import 'package:flutter_application_1/page/screening/startScreening.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CreateProfilePage extends StatefulWidget {
  final ImageProvider<Object>? profileImage;
  final String? alias;
  final String? firstname;
  final String? lastname;
  final int? yearOfBirth;
  final String? gender;
  const CreateProfilePage(
      {this.profileImage,
      this.alias,
      this.firstname,
      this.lastname,
      this.yearOfBirth,
      this.gender,
      super.key});

  @override
  State<CreateProfilePage> createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  final List<int> items = [];
  bool acceptPermission = false;
  int? selectedYear;
  String? selectedGender;

  ImageProvider? selectedProfile;
  String? alias;
  String? firstname;
  String? lastname;
  int? yearOfBirth;
  String? gender;

  Future<void> updateProfile(
      String? accesstoken,
      String? alias,
      String? firstname,
      String? lastname,
      int? yearOfBirth,
      String? gender,
      String? photo) async {
    final url = Uri.parse("http://192.168.0.107:8000/api/user/profile");
    final response = await http.put(url,
        headers: {'Authorization': 'Bearer $accesstoken'},
        body: json.encode({
          "alias": alias,
          "firstName": firstname,
          "lastName": lastname,
          "yearOfBirth": yearOfBirth,
          "gender": gender,
          "photo": photo
        }));

    print('update profile:${response.statusCode}');
    print('update profile:${response.body}');
  }

  Future<void> refreshToken(
    String? accesstoken,
  ) async {
    final url = Uri.parse("http://192.168.0.107:8000/api/auth/refresh");
    final response = await http.post(
      url,
      headers: {'Authorization': 'Bearer $accesstoken'},
    );

    print('refresh:${response.statusCode}');
    print('update token:${response.body}');
  }

  late TextEditingController _controllerAlias;
  late TextEditingController _controllerFirstname;
  late TextEditingController _controllerLastname;

  bool checkAlias = false;
  bool checkFirstname = false;
  bool checkLastname = false;
  bool checkYear = false;
  bool checkGender = false;

  @override
  void initState() {
    _controllerAlias = TextEditingController(text: widget.alias);
    _controllerFirstname = TextEditingController(text: widget.firstname);
    _controllerLastname = TextEditingController(text: widget.lastname);
    super.initState();
  }

  @override
  void dispose() {
    _controllerAlias.dispose();
    _controllerFirstname.dispose();
    _controllerLastname.dispose();
    super.dispose();
  }

  bool isChecked = false;

  void _showPermission() {
    showDialog(
        context: context,
        barrierDismissible: false,
        //context: _scaffoldKey.currentContext,
        builder: (context) {
          return AlertDialog(
            titlePadding: const EdgeInsets.only(top: 0),
            contentPadding:
                const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 20),
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 48),
                    const Text(
                      'ข้อตกลงและเงื่อนไข',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'IBMPlexSansThai',
                          color: Colors.black,
                          fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      child: IconButton(
                          icon: const Icon(Icons.cancel),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                    )
                  ],
                )
              ],
            ),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: SizedBox(
              height: 450,
              child: Scrollbar(
                //isAlwaysShown: true,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const Text('Name of requestor: }'),
                      Text(
                        'Description:' * 400,
                      ),
                      const Text(
                        'Help_Description',
                      ),
                      const Text(
                        'Type of help needed:Help_TypeNeeded',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Checkbox(
                            activeColor: Color(hexColor('#2F4EF1')),
                            shape: const CircleBorder(),
                            value: isChecked,
                            onChanged: (bool? acceptPermission) {
                              setState(() {
                                isChecked = acceptPermission!;
                              });
                              Navigator.of(context).pop();
                            },
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "รับทราบและให้ความยินยอมตาม Telehealth",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'IBMPlexSansThai',
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                  "ข้อตกลงเกี่ยวกับการใช้งานเเละนโยบายความเป็นส่วนตัว",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'IBMPlexSansThai',
                                    color: Color(hexColor('#2F4EF1')),
                                    fontWeight: FontWeight.normal,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // actions: <Widget>[
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Container(
            //         child: Checkbox(
            //           activeColor: Color(hexColor('#2F4EF1')),
            //           shape: CircleBorder(),
            //           value: isChecked,
            //           onChanged: (bool? acceptPermission) {
            //             setState(() {
            //               isChecked = acceptPermission!;
            //             });
            //             Navigator.of(context).pop();
            //           },
            //         ), //Che
            //       ),
            //       Expanded(
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text(
            //               "รับทราบและให้ความยินยอมตาม Telehealth",
            //               style: TextStyle(
            //                 fontSize: 14,
            //                 fontFamily: 'IBMPlexSansThai',
            //                 color: Colors.black,
            //                 fontWeight: FontWeight.normal,
            //               ),
            //               textAlign: TextAlign.start,
            //             ),
            //             Container(
            //               child: Text(
            //                 "ข้อตกลงเกี่ยวกับการใช้งานเเละนโยบายความเป็นส่วนตัว",
            //                 style: TextStyle(
            //                   fontSize: 14,
            //                   fontFamily: 'IBMPlexSansThai',
            //                   color: Color(hexColor('#2F4EF1')),
            //                   fontWeight: FontWeight.normal,
            //                 ),
            //                 textAlign: TextAlign.start,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    String? token = Provider.of<AuthProvider>(context).token;
    final List<int> items = [];

    for (int i = 2499; i <= 2550; i++) {
      items.add(i);
    }

    final List<String> genders = ['หญิง', 'ชาย'];

    return Scaffold(
      backgroundColor: Color(hexColor('#FAFCFB')),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Login()));
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Color(hexColor('#484554')),
                    size: 24,
                  ),
                ),
                const Text(
                  'สร้างโปรไฟล์',
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'IBMPlexSansThai',
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 24,
                ),
              ]),
              const SizedBox(
                height: 19,
              ),
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                      alignment: Alignment.topCenter,
                      height: 105,
                      width: 105,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60)),
                      child: CircleAvatar(
                        maxRadius: 52.5,
                        minRadius: 52.5,
                        backgroundColor: Colors.grey[200],
                        backgroundImage: widget.profileImage ??
                            const AssetImage(
                                'assets/images/defaultProfile1.png'),
                      )),
                  Container(
                      height: 120,
                      width: 105,
                      padding: const EdgeInsets.only(right: 13),
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SelectProfilePicturePage(
                                        profileImage: widget.profileImage ??
                                            const AssetImage(
                                                'assets/images/defaultProfile1.png'),
                                        alias: alias ?? widget.alias,
                                        firstname:
                                            firstname ?? widget.firstname,
                                        lastname: lastname ?? widget.lastname,
                                        yearOfBirth:
                                            selectedYear ?? widget.yearOfBirth,
                                        gender:
                                            selectedGender ?? widget.gender)));
                          },
                          child: Image.asset('assets/images/healthInfo.png'))),
                ],
              ),
              const SizedBox(
                height: 22,
              ),
              Container(
                padding: const EdgeInsets.only(left: 8, bottom: 8),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'นามแฝง',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'IBMPlexSansThai',
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              SizedBox(
                  child: TextField(
                onChanged: (value) {
                  setState(() {
                    alias = value;
                    checkAlias = false;
                  });
                },
                controller: _controllerAlias,
                textAlign: TextAlign.left,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  errorBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide(
                        color: Color(hexColor('#FB6262')),
                        width: 1,
                      )),
                  errorText: checkAlias && (alias == '' || alias == null)
                      ? "กรุณากรอกนามแฝง"
                      : null,
                  errorStyle: TextStyle(
                    fontSize: 14,
                    fontFamily: 'IBMPlexSansThai',
                    color: Color(hexColor('#FB6262')),
                    fontWeight: FontWeight.normal,
                  ),
                  hintText: 'นามแฝง',
                  hintStyle: TextStyle(
                    fontSize: 16,
                    fontFamily: 'IBMPlexSansThai',
                    color: Color(hexColor('#999999')),
                    fontWeight: FontWeight.normal,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                        color: Color(hexColor('#DBDBDB')),
                      )),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                        color: Color(hexColor('#DBDBDB')),
                      )),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                        color: Color(hexColor('#DBDBDB')),
                      )),
                ),
              )),
              const SizedBox(
                height: 14,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 8, bottom: 8),
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'ชื่อ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'IBMPlexSansThai',
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        SizedBox(
                            child: TextField(
                          controller: _controllerFirstname,
                          onChanged: (value) {
                            setState(() {
                              firstname = value;
                              checkFirstname = false;
                            });
                          },
                          textAlign: TextAlign.left,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            hintText: 'ชื่อจริง',
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 15),
                            hintStyle: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'IBMPlexSansThai',
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                            ),
                            errorBorder: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(30)),
                                borderSide: BorderSide(
                                  color: Color(hexColor('#FB6262')),
                                  width: 1,
                                )),
                            errorText: checkFirstname &&
                                    (firstname == '' || firstname == null)
                                ? "กรุณากรอกชื่อจริง"
                                : null,
                            errorStyle: TextStyle(
                              fontSize: 14,
                              fontFamily: 'IBMPlexSansThai',
                              color: Color(hexColor('#FB6262')),
                              fontWeight: FontWeight.normal,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(
                                  color: Color(hexColor('#DBDBDB')),
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(
                                  color: Color(hexColor('#DBDBDB')),
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(
                                  color: Color(hexColor('#DBDBDB')),
                                )),
                          ),
                        )),
                        checkLastname && (lastname == '' || lastname == null)
                            ? const SizedBox(
                                height: 28,
                              )
                            : const SizedBox(
                                height: 0,
                              ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 8, bottom: 8),
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'นามสกุล',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'IBMPlexSansThai',
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        SizedBox(
                            child: TextField(
                          controller: _controllerLastname,
                          onChanged: (value) {
                            setState(() {
                              lastname = value;
                              checkLastname = false;
                            });
                          },
                          textAlign: TextAlign.left,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 15),
                            hintText: 'นามสกุล',
                            hintStyle: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'IBMPlexSansThai',
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                            ),
                            errorBorder: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(30)),
                                borderSide: BorderSide(
                                  color: Color(hexColor('#FB6262')),
                                  width: 1,
                                )),
                            errorText: checkLastname &&
                                    (lastname == '' || lastname == null)
                                ? "กรุณากรอกนามสกุล"
                                : null,
                            errorStyle: TextStyle(
                              fontSize: 14,
                              fontFamily: 'IBMPlexSansThai',
                              color: Color(hexColor('#FB6262')),
                              fontWeight: FontWeight.normal,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(
                                  color: Color(hexColor('#DBDBDB')),
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(
                                  color: Color(hexColor('#DBDBDB')),
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(
                                  color: Color(hexColor('#DBDBDB')),
                                )),
                          ),
                        )),
                        checkFirstname && (firstname == '' || firstname == null)
                            ? const SizedBox(
                                height: 28,
                              )
                            : const SizedBox(
                                height: 0,
                              ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              Container(
                padding: const EdgeInsets.only(left: 8, bottom: 8),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'ปีเกิด',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'IBMPlexSansThai',
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              DropdownButtonHideUnderline(
                child: DropdownButton2<int>(
                  isExpanded: true,
                  hint: const Row(
                    children: [
                      SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: Text(
                          'เลือกปีเกิด',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'IBMPlexSansThai',
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                  items: items
                      .map((int item) => DropdownMenuItem<int>(
                            value: item,
                            child: Text(
                              item.toString(),
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'IBMPlexSansThai',
                                color: Color(hexColor('#3D3D3D')),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ))
                      .toList(),
                  value: widget.yearOfBirth ?? selectedYear,
                  onChanged: (int? value) {
                    setState(() {
                      selectedYear = value;
                      checkYear = false;
                    });
                  },
                  buttonStyleData: ButtonStyleData(
                    height: 47,
                    padding: const EdgeInsets.only(right: 15),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(.3),
                          blurRadius: 4.0,
                          spreadRadius: .1,
                          offset: const Offset(
                            2.0,
                            4.0,
                          ),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: checkYear
                            ? Color(hexColor('#FB6262'))
                            : Colors.black26,
                      ),
                      color: Colors.white,
                    ),
                    elevation: 2,
                  ),
                  iconStyleData: const IconStyleData(
                      openMenuIcon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                      ),
                      icon: Icon(
                        Icons.keyboard_arrow_right_rounded,
                      ),
                      iconSize: 20),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 200,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(.3),
                          blurRadius: 4.0,
                          spreadRadius: .1,
                          offset: const Offset(
                            2.0,
                            4.0,
                          ),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(0),
                      color: Colors.white,
                    ),
                    scrollbarTheme: ScrollbarThemeData(
                      radius: const Radius.circular(3),
                      thickness: MaterialStateProperty.all<double>(6),
                      thumbVisibility: MaterialStateProperty.all<bool>(true),
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 40,
                    padding: EdgeInsets.only(left: 14, right: 14),
                  ),
                ),
              ),
              checkYear == true
                  ? Container(
                      padding: const EdgeInsets.only(left: 15, top: 7),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'กรุณาเลือกปีเกิด',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'IBMPlexSansThai',
                          color: Color(hexColor('#FB6262')),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    )
                  : const SizedBox(
                      height: 0,
                    ),
              const SizedBox(
                height: 14,
              ),
              Container(
                padding: const EdgeInsets.only(left: 8, bottom: 8),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'เพศ',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'IBMPlexSansThai',
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  isExpanded: true,
                  hint: const Row(
                    children: [
                      SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: Text(
                          'เลือกเพศของคุณ',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'IBMPlexSansThai',
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                  items: genders
                      .map((String gender) => DropdownMenuItem<String>(
                            value: gender,
                            child: Text(
                              gender,
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'IBMPlexSansThai',
                                color: Color(hexColor('#3D3D3D')),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ))
                      .toList(),
                  value: widget.gender ?? selectedGender,
                  onChanged: (String? value) {
                    setState(() {
                      selectedGender = value;
                      checkGender = false;
                    });
                  },
                  buttonStyleData: ButtonStyleData(
                    height: 47,
                    padding: const EdgeInsets.only(right: 15),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(.3),
                          blurRadius: 4.0,
                          spreadRadius: .1,
                          offset: const Offset(
                            2.0,
                            4.0,
                          ),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: checkGender
                            ? Color(hexColor('#FB6262'))
                            : Colors.black26,
                      ),
                      color: Colors.white,
                    ),
                    elevation: 2,
                  ),
                  iconStyleData: const IconStyleData(
                      openMenuIcon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                      ),
                      icon: Icon(
                        Icons.keyboard_arrow_right_rounded,
                      ),
                      iconSize: 20),
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(.3),
                          blurRadius: 4.0,
                          spreadRadius: .1,
                          offset: const Offset(
                            2.0,
                            4.0,
                          ),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(0),
                      color: Colors.white,
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 40,
                    padding: EdgeInsets.only(left: 14, right: 14),
                  ),
                ),
              ),
              checkGender == true
                  ? Container(
                      padding: const EdgeInsets.only(left: 15, top: 7),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'กรุณาเลือกเพศ',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'IBMPlexSansThai',
                          color: Color(hexColor('#FB6262')),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    )
                  : const SizedBox(
                      height: 0,
                    ),
              const SizedBox(
                height: 33,
              ),
              MaterialButton(
                color: Color(hexColor('#2F4EF1')),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(23.5),
                ),
                onPressed: () async {
                  alias = alias ?? widget.alias;
                  firstname = firstname ?? widget.firstname;
                  lastname = lastname ?? widget.lastname;
                  selectedYear = selectedYear ?? widget.yearOfBirth;
                  selectedGender = selectedGender ?? widget.gender;
                  if (_controllerAlias.text.isEmpty == true) {
                    setState(() {
                      checkAlias = true;
                      checkFirstname = false;
                      checkLastname = false;
                      checkYear = false;
                      checkGender = false;
                    });
                  } else if (_controllerFirstname.text.isEmpty == true) {
                    setState(() {
                      checkAlias = false;
                      checkFirstname = true;
                      checkLastname = false;
                      checkYear = false;
                      checkGender = false;
                    });
                  } else if (_controllerLastname.text.isEmpty == true) {
                    setState(() {
                      checkAlias = false;
                      checkFirstname = false;
                      checkLastname = true;
                      checkYear = false;
                      checkGender = false;
                    });
                  } else if (selectedYear == null) {
                    setState(() {
                      checkAlias = false;
                      checkFirstname = false;
                      checkLastname = false;
                      checkYear = true;
                      checkGender = false;
                    });
                  } else if (selectedGender == null) {
                    setState(() {
                      checkAlias = false;
                      checkFirstname = false;
                      checkLastname = false;
                      checkYear = false;
                      checkGender = true;
                    });
                  } else {
                    if (alias != null &&
                        firstname != null &&
                        lastname != null &&
                        selectedYear != null &&
                        selectedGender != null &&
                        isChecked == true) {
                      updateProfile(
                          token,
                          alias ?? widget.alias,
                          firstname ?? widget.firstname,
                          lastname ?? widget.lastname,
                          selectedYear ?? widget.yearOfBirth,
                          selectedGender ?? widget.gender,
                          (widget.profileImage ??
                              'assets/images/defaultProfile1.png') as String?);
                      // refreshToken(token);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const StartScreening()));
                    }
                  }
                },
                child: Container(
                  height: 47,
                  width: 350,
                  alignment: Alignment.center,
                  child: const Text("สร้างบัญชี",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'IBMPlexSansThai',
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                ),
              ),
              const SizedBox(
                height: 33,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    activeColor: Color(hexColor('#2F4EF1')),
                    shape: const CircleBorder(),
                    value: isChecked,
                    onChanged: (bool? acceptPermission) {
                      setState(() {
                        _showPermission();
                        // this.acceptPermission = !this.acceptPermission;
                      });
                    },
                  ), //Che
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "รับทราบและให้ความยินยอมตาม Telehealth",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'IBMPlexSansThai',
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          "ข้อตกลงเกี่ยวกับการใช้งานเเละนโยบายความเป็นส่วนตัว",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'IBMPlexSansThai',
                            color: Color(hexColor('#2F4EF1')),
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }
}
