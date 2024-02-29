import 'package:flutter/material.dart';

import '../../extension/Color.dart';
import '../home/home.dart';

class Notificate extends StatelessWidget {
  const Notificate({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notificate Page',
      home: NotificationPage(),
    );
  }
}

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(hexColor('#FAFCFB')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 58, left: 20, right: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Color(hexColor('#484554')),
                      size: 24,
                    ),
                  ),
                  Text(
                    'กระดานคนเก่ง',
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
                ],
              ),
              SizedBox(height: 28),
              Row(
                children: [
                  Image.asset('assets/images/bezier.png'),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'ล่าสุด',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'IBMPlexSansThai',
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: () {
                  //
                },
                child: Container(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  height: 36,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'อย่าลืมทำภารกิจ3',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'IBMPlexSansThai',
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 16,
                        color: Color(hexColor('#7B7B7B')),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 28,
              ),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 24,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'ย้อนหลัง',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'IBMPlexSansThai',
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      //
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      height: 36,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'อย่าลืมทำภารกิจ1',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'IBMPlexSansThai',
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 16,
                            color: Color(hexColor('#7B7B7B')),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Color(hexColor('#DBDBDB')),
                          thickness: 1,
                          indent: 5,
                          endIndent: 5,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      //
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      height: 36,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'อย่าลืมทำภารกิจ2',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'IBMPlexSansThai',
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 16,
                            color: Color(hexColor('#7B7B7B')),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
