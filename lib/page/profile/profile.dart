import 'package:flutter/material.dart';
import 'package:flutter_application_1/extension/Color.dart';
import 'package:flutter_application_1/page/home/home.dart';
import 'package:flutter_application_1/page/profile/changeProfile.dart';
import 'package:flutter_application_1/page/profile/healthChart.dart';
import 'package:flutter_application_1/page/profile/hospitalConnect.dart';
import 'package:flutter_application_1/page/profile/treatmentInformation.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile',
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool hospitalConnected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(hexColor('#FAFCFB')),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 50),
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Home()));
                        },
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Color(hexColor('#484554')),
                          size: 24,
                        ),
                      ),
                      Text(
                        'โปรไฟล์',
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'IBMPlexSansThai',
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(
                        width: 24,
                      )
                    ]),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: Row(
                    children: [
                      Container(
                        height: 66,
                        decoration: BoxDecoration(
                            color: Color(hexColor('#999999')),
                            borderRadius: BorderRadius.circular(33)),
                        child: Image.asset('assets/images/person.png'),
                      ),
                      SizedBox(
                        width: 13,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'นันท์',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'IBMPlexSansThai',
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChangeProfile()));
                            },
                            child: Text(
                              'เเก้ไขโปรไฟล์ >',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'IBMPlexSansThai',
                                color: Color(hexColor('#999999')),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'บัญชีผู้ใช้',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'IBMPlexSansThai',
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      InkWell(
                        onTap: () {
                          //
                        },
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset('assets/images/profile.png'),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'ข้อมูลส่วนตัว',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'IBMPlexSansThai',
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 14,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      InkWell(
                        onTap: () {
                          //
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => HealthChart()));
                        },
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset('assets/images/healthInfo.png'),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'กราฟข้อมูลสุขภาพ',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'IBMPlexSansThai',
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 14,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      InkWell(
                        onTap: () {
                          //
                        },
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset('assets/images/screening.png'),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'เเบบประเมิน',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'IBMPlexSansThai',
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 14,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      hospitalConnected
                          ? InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TreatmentInformation()));
                              },
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                            'assets/images/connectHospital.png'),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          'ข้อมูลการรักษา',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'IBMPlexSansThai',
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 14,
                                    )
                                  ],
                                ),
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            hospitalConnect()));
                              },
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                            'assets/images/connectHospital.png'),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          'เชื่อมต่อกับสถานพยาบาล',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'IBMPlexSansThai',
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 14,
                                    )
                                  ],
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 17,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ทั่วไป',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'IBMPlexSansThai',
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      InkWell(
                        onTap: () {
                          //
                        },
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset('assets/images/help.png'),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'ศูนย์ช่วยเหลือ',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'IBMPlexSansThai',
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 14,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      InkWell(
                        onTap: () {
                          //
                        },
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset('assets/images/setting.png'),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'ตั้งค่า',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'IBMPlexSansThai',
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 14,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      InkWell(
                        onTap: () {
                          //
                        },
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset('assets/images/like.png'),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'เเชร์ข้อเสนอเเนะ',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'IBMPlexSansThai',
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 14,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 65,
                ),
                MaterialButton(
                  color: Color(hexColor('#DBDBDB')),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(23.5),
                  ),
                  onPressed: () {
                    // login by email
                  },
                  child: Container(
                    height: 47,
                    width: 350,
                    alignment: Alignment.center,
                    child: Text("ออกจากระบบ",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'IBMPlexSansThai',
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                  ),
                ),
                SizedBox(
                  height: 97,
                )
              ],
            ),
          ),
        ));
  }
}
