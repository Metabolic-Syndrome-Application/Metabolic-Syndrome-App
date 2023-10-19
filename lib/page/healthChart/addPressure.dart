import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/healthChart/pressureChart.dart';

import '../../extension/Color.dart';

class AddPressure extends StatelessWidget {
  const AddPressure({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AddPressurePage(),
    );
  }
}

class AddPressurePage extends StatefulWidget {
  const AddPressurePage({super.key});

  @override
  State<AddPressurePage> createState() => _AddPressurePageState();
}

class _AddPressurePageState extends State<AddPressurePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PressureChart()));
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Color(hexColor('#484554')),
                    size: 24,
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
                const Text(
                  'ความดันโลหิต',
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'IBMPlexSansThai',
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Material(
                  color: Color(hexColor('#2F4EF1')),
                  borderRadius: BorderRadius.circular(30),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddPressure()));
                    },
                    child: Container(
                      width: 76,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_circle_outline_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text("เพิ่ม",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'IBMPlexSansThai',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  ),
                )
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
