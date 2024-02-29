import 'package:flutter/material.dart';
import 'package:flutter_application_1/authProvider.dart';
import 'package:flutter_application_1/extension/Color.dart';
import 'package:flutter_application_1/page/healthChart/bmiChart.dart';
import 'package:flutter_application_1/page/healthChart/detailBmiRecord.dart';
import 'package:flutter_application_1/response/api.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AllBMIRecord extends StatelessWidget {
  const AllBMIRecord({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: AllBMIRecordPage());
  }
}

class AllBMIRecordPage extends StatefulWidget {
  const AllBMIRecordPage({super.key});

  @override
  State<AllBMIRecordPage> createState() => _AllBMIRecordPageState();
}

class _AllBMIRecordPageState extends State<AllBMIRecordPage> {
  dynamic listOfBmi = '';
  dynamic listOfWaistline = '';

  Future<void> fetchBmi() async {
    try {
      String? token = Provider.of<AuthProvider>(context, listen: false).token;
      Map<String, dynamic> response = await getBmi(token!);
      setState(() {
        listOfBmi = response['data']['record'];
      });
    } catch (e) {
      // print('Error fetching profile: $e');
    }
  }

  Future<void> fetchWaistline() async {
    try {
      String? token = Provider.of<AuthProvider>(context, listen: false).token;
      Map<String, dynamic> response = await getWaistline(token!);
      setState(() {
        listOfWaistline = response['data']['record'];
      });
    } catch (e) {
      // print('Error fetching profile: $e');
    }
  }

  @override
  void initState() {
    setState(() {
      fetchBmi();
      fetchWaistline();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(hexColor('#FAFCFB')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 58),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BMIChart()));
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Color(hexColor('#484554')),
                    size: 24,
                  ),
                ),
                const Text(
                  'ดัชนีมวลกาย',
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'IBMPlexSansThai',
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 24,
                )
              ]),
              const SizedBox(
                height: 25,
              ),
              Text(
                'กก./ม.² (หน่วย)',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'IBMPlexSansThai',
                  color: Color(hexColor('#484554')),
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white),
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(0),
                    shrinkWrap: true,
                    itemCount: listOfBmi.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            index == 0
                                ? const SizedBox(
                                    height: 10,
                                  )
                                : const SizedBox(),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DetailBmiRecordPage(
                                              timestamp: DateFormat(
                                                      'dd MMM HH:mm', 'th')
                                                  .format(DateTime.parse(
                                                      listOfBmi[index]
                                                          ['timestamp'])),
                                              bmi: listOfBmi[index]['bmi'],
                                              waistline: listOfWaistline[index]
                                                  ['waistline'],
                                            )));
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                            'assets/images/heartPressure.png'),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '${listOfBmi[index]['bmi'].toStringAsFixed(2)}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'IBMPlexSansThai',
                                            color: Color(hexColor('#FB6262')),
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          DateFormat('dd MMM HH:mm', 'th')
                                              .format(DateTime.parse(
                                                  listOfBmi[index]
                                                      ['timestamp'])),
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'IBMPlexSansThai',
                                            color: Color(hexColor('#7B7B7B')),
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 14,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            index != listOfBmi.length - 1
                                ? Row(
                                    children: [
                                      Expanded(
                                        child: Divider(
                                          color: Color(hexColor('#DBDBDB')),
                                          thickness: 1,
                                          indent: 22,
                                          endIndent: 22,
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox(
                                    height: 10,
                                  ),
                          ],
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
