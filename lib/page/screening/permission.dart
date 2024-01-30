import 'package:flutter/material.dart';
import 'package:flutter_application_1/extension/Color.dart';
import 'package:flutter_application_1/page/screening/startScreening.dart';

void main() {
  runApp(Permission());
}

bool isChecked = false;

class Permission extends StatelessWidget {
  const Permission({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Permission Page",
      home: PermissionPage(),
    );
  }
}

class PermissionPage extends StatefulWidget {
  const PermissionPage({super.key});

  @override
  State<PermissionPage> createState() => _PermissionPageState();
}

class _PermissionPageState extends State<PermissionPage> {
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.black;
    }
    return Colors.black;
  }

  void _showPermission() {
    showDialog(
        context: context,
        barrierDismissible: false,
        //context: _scaffoldKey.currentContext,
        builder: (context) {
          return AlertDialog(
            titlePadding: EdgeInsets.only(top: 0),
            contentPadding: EdgeInsets.only(left: 25, right: 25, top: 0),
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 48),
                    Text(
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
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: Container(
              height: 400,
              width: 300,
              child: Scrollbar(
                //isAlwaysShown: true,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text('Name of requestor: }'),
                      Text(
                        'Description:' * 400,
                      ),
                      Text(
                        'Help_Description',
                      ),
                      Text(
                        'Type of help needed:Help_TypeNeeded',
                      )
                    ],
                  ),
                ),
              ),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        alignment: Alignment.topCenter,
                        height: 100,
                        child: Checkbox(
                          checkColor: Colors.white,
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });

                            Navigator.of(context).pop();
                          },
                        )),
                    Container(
                      width: 225,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'รับทราบและให้ความยินยอมตาม     ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'IBMPlexSansThai',
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            'ข้อตกลงเกี่ยวกับการใช้งานเเละนโยบายความเป็นส่วนตัว',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'IBMPlexSansThai',
                              color: Color(hexColor('#FB6262')),
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.black;
      }
      return Colors.black;
    }

    return Scaffold(
      backgroundColor: Color(hexColor('#FAFCFB')),
      body: Column(
        children: [
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: 103,
                ),
                Image.asset('assets/images/permission.png'),
                SizedBox(
                  height: 65,
                ),
                Text(
                  "ความยินยอมเรื่องข้อมูลส่วนบุคคล",
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'IBMPlexSansThai',
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 23,
                ),
                Text(
                  'Telehealth ให้ความสำคัญกับข้อมูลส่วนบุคคล\nของท่าน โปรดอ่านรายละเอียดเกี่ยวกับเงื่อนไข\nการใช้งาน และนโยบายความเป็นส่วนตัว',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'IBMPlexSansThai',
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  alignment: Alignment.topCenter,
                  height: 100,
                  child: Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: isChecked,
                    onChanged: (bool? value) {
                      _showPermission();
                      setState(() {
                        isChecked = !isChecked;
                      });
                    },
                  )),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'รับทราบและให้ความยินยอมตาม            ',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'IBMPlexSansThai',
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    'ข้อตกลงเกี่ยวกับการใช้งานเเละนโยบาย\nความเป็นส่วนตัว',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'IBMPlexSansThai',
                      color: Color(hexColor('#FB6262')),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 29,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(23.5),
                ),
                onPressed: () {
                  _showPermission();
                },
                child: Container(
                  height: 40,
                  width: 150,
                  alignment: Alignment.center,
                  child: Text("ดูรายละเอียด",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'IBMPlexSansThai',
                          color: Colors.black,
                          fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center),
                ),
              ),
              SizedBox(width: 19),
              MaterialButton(
                color: Color(hexColor('#2F4EF1')),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(23.5),
                ),
                onPressed: () {
                  if (isChecked == true) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StartScreening()));
                  }
                },
                child: Container(
                  height: 40,
                  width: 150,
                  alignment: Alignment.center,
                  child: Text("ให้ความยินยอม",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'IBMPlexSansThai',
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
