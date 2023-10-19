import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/profile/profile.dart';

import '../../extension/Color.dart';

class ChangeProfile extends StatelessWidget {
  const ChangeProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Change Profile Page',
      home: ChangeProfilePage(),
    );
  }
}

class ChangeProfilePage extends StatefulWidget {
  const ChangeProfilePage({super.key});

  @override
  State<ChangeProfilePage> createState() => _ChangeProfilePageState();
}

class _ChangeProfilePageState extends State<ChangeProfilePage> {
  final List<int> items = [];

  int? selectedYear;
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    final List<int> items = [];

    for (int i = 2499; i <= 2550; i++) {
      items.add(i);
    }
    ;

    final List<String> gender = ['เพศหญิง', 'เพศชาย'];

    return Scaffold(
      backgroundColor: Color(hexColor('#FAFCFB')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 50),
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
                  'เเก้ไขโปรไฟล์',
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
                        maxRadius: 53,
                        minRadius: 53,
                        backgroundColor: Colors.grey[200],

                        child: Image.asset('assets/images/healthInfo.png'),
                      )),
                  Container(
                      height: 120,
                      width: 105,
                      padding: EdgeInsets.only(right: 13),
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                          onTap: () {
                            //
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
                  'ชื่อผู้ใช้',
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
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      hintText: 'นันท์',
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontFamily: 'IBMPlexSansThai',
                        color: Color(hexColor('#3D3D3D')),
                        fontWeight: FontWeight.normal,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  )),
              SizedBox(
                height: 14,
              ),
              Container(
                padding: EdgeInsets.only(left: 8, bottom: 8),
                alignment: Alignment.centerLeft,
                child: Text(
                  'ชื่อ-นามสกุล',
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
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontFamily: 'IBMPlexSansThai',
                        color: Color(hexColor('#3D3D3D')),
                        fontWeight: FontWeight.normal,
                      ),
                      hintText: 'นนทิชา สุขเจริญ',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  )),
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
                          '2499', //-----------------default
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'IBMPlexSansThai',
                            color: Colors.black,
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
                                fontSize: 14,
                                fontFamily: 'IBMPlexSansThai',
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ))
                      .toList(),
                  value: selectedYear,
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
                          'เพศหญิง',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'IBMPlexSansThai',
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                  items: gender
                      .map((String gender) => DropdownMenuItem<String>(
                            value: gender,
                            child: Text(
                              gender,
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'IBMPlexSansThai',
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ))
                      .toList(),
                  value: selectedGender,
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
                height: 14,
              ),
              Container(
                padding: EdgeInsets.only(left: 8, bottom: 8),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Phone',
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
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontFamily: 'IBMPlexSansThai',
                        color: Color(hexColor('#3D3D3D')),
                        fontWeight: FontWeight.normal,
                      ),
                      hintText: '086407xxxx',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  )),
              SizedBox(
                height: 33,
              ),
              MaterialButton(
                color: Color(hexColor('#2F4EF1')),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(23.5),
                ),
                onPressed: () {
                  // save
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
        ),
      ),
    );
  }
}
