import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/profile/profile.dart';

import '../../extension/Color.dart';

class hospitalConnect extends StatelessWidget {
  const hospitalConnect({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: hospitalConnectPage(),
    );
  }
}

class hospitalConnectPage extends StatefulWidget {
  const hospitalConnectPage({super.key});

  @override
  State<hospitalConnectPage> createState() => _hospitalConnectPageState();
}

class _hospitalConnectPageState extends State<hospitalConnectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(hexColor('#FAFCFB')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 50),
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
                  'การเชื่อมต่อสถานพยาบาล',
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
                height: 56,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
