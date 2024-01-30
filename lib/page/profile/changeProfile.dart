import 'dart:async';
import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
//import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/authProvider.dart';
import 'package:flutter_application_1/extension/Color.dart';
import 'package:flutter_application_1/page/home/home.dart';
import 'package:flutter_application_1/page/profile/changeProfilePicture.dart';
import 'package:flutter_application_1/page/profile/profile.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ChangeProfile extends StatefulWidget {
  final ImageProvider<Object>? profileImage;
  final String? alias;
  final String? firstname;
  final String? lastname;
  final int? yearOfBirth;
  final String? gender;
  const ChangeProfile(
      {this.profileImage,
      this.alias,
      this.firstname,
      this.lastname,
      this.yearOfBirth,
      this.gender,
      super.key});

  @override
  State<ChangeProfile> createState() => _ChangeProfileState();
}

class _ChangeProfileState extends State<ChangeProfile> {
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
    final url = Uri.parse("http://10.66.8.149:8000/api/user/profile");
    final response = await http.put(url,
        headers: {'Authorization': 'Bearer ${accesstoken}'},
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

  late TextEditingController _controllerAlias;
  late TextEditingController _controllerFirstname;
  late TextEditingController _controllerLastname;

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

  Future<void> getProfile(String accesstoken) async {
    final url = Uri.parse("http://10.66.8.149:8000/api/user/profile");
    final response = await http
        .get(url, headers: {'Authorization': 'Bearer ${accesstoken}'});
    print('profile Response body: ${response.body}');

    alias = json.decode(response.body)['data']['user']['alias'];
    firstname = json.decode(response.body)['data']['user']['firstName'];
    lastname = json.decode(response.body)['data']['user']['lastName'];
    yearOfBirth = json.decode(response.body)['data']['user']['yearOfBirth'];
    gender = json.decode(response.body)['data']['user']['gender'];
  }

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    String? imageProfile;
    String? token = Provider.of<AuthProvider>(context).token;
    getProfile(token!);

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
                        MaterialPageRoute(builder: (context) => Profile()));
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Color(hexColor('#484554')),
                    size: 24,
                  ),
                ),
                Text(
                  'แก้ไขโปรไฟล์',
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
                      padding: EdgeInsets.only(right: 13),
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChangeProfilePicturePage(
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
                          child: Container(
                              child: Image.asset(
                                  'assets/images/healthInfo.png')))),
                ],
              ),
              SizedBox(
                height: 22,
              ),
              Container(
                padding: EdgeInsets.only(left: 8, bottom: 8),
                alignment: Alignment.centerLeft,
                child: Text(
                  'นามแฝง',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'IBMPlexSansThai',
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Container(
                  height: 47,
                  alignment: Alignment.center,
                  child: TextField(
                    controller: _controllerAlias,
                    onChanged: (value) {
                      setState(() {
                        alias = value;
                      });
                    },
                    textAlign: TextAlign.left,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 15),
                      hintText: alias ?? '',
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontFamily: 'IBMPlexSansThai',
                        color: Color(hexColor('#999999')),
                        fontWeight: FontWeight.normal,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(
                            color: Color(hexColor('#DBDBDB')),
                            width: 1,
                          )),
                    ),
                  )),
              SizedBox(
                height: 14,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 8, bottom: 8),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'ชื่อ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'IBMPlexSansThai',
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Container(
                            height: 47,
                            alignment: Alignment.center,
                            child: TextField(
                              controller: _controllerFirstname,
                              onChanged: (value) {
                                setState(() {
                                  firstname = value;
                                });
                              },
                              textAlign: TextAlign.left,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                hintText: firstname,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 15),
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'IBMPlexSansThai',
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    borderSide: BorderSide(
                                      color: Color(hexColor('#DBDBDB')),
                                      width: 1,
                                    )),
                              ),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 8, bottom: 8),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'นามสกุล',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'IBMPlexSansThai',
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Container(
                            height: 47,
                            alignment: Alignment.center,
                            child: TextField(
                              controller: _controllerLastname,
                              onChanged: (value) {
                                setState(() {
                                  lastname = value;
                                });
                              },
                              textAlign: TextAlign.left,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 15),
                                hintText: lastname ?? '',
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'IBMPlexSansThai',
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey.withOpacity(.3),
                                    )),
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 14,
              ),
              Container(
                padding: EdgeInsets.only(left: 8, bottom: 8),
                alignment: Alignment.centerLeft,
                child: Text(
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
                          'เลือกปีเกิด', //-----------------default
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
                  value: widget.yearOfBirth ?? selectedYear ?? yearOfBirth,
                  onChanged: (int? value) {
                    setState(() {
                      selectedYear = value;
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
                        color: Colors.black26,
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
              SizedBox(
                height: 14,
              ),
              Container(
                padding: EdgeInsets.only(left: 8, bottom: 8),
                alignment: Alignment.centerLeft,
                child: Text(
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
                  value: widget.gender ?? selectedGender ?? gender,
                  onChanged: (String? value) {
                    setState(() {
                      selectedGender = value;
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
                        color: Colors.black26,
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
              SizedBox(
                height: 33,
              ),
              MaterialButton(
                color: Color(hexColor('#2F4EF1')),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(23.5),
                ),
                onPressed: () {
                  alias = alias ?? widget.alias;
                  firstname = firstname ?? widget.firstname;
                  lastname = lastname ?? widget.lastname;
                  selectedYear = selectedYear ?? widget.yearOfBirth;
                  selectedGender = selectedGender ?? widget.gender;
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

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  }
                },
                child: Container(
                  height: 47,
                  width: 350,
                  alignment: Alignment.center,
                  child: Text("บันทึก",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'IBMPlexSansThai',
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
