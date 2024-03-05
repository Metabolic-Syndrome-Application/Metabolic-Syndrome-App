import 'package:flutter/material.dart';
import 'package:flutter_application_1/extension/Color.dart';
import 'package:flutter_application_1/page/plan/planDetail.dart';
import 'package:flutter_application_1/response/api.dart';
import 'package:provider/provider.dart';

import '../../authProvider.dart';

class ProgramCard extends StatefulWidget {
  final String planId;

  const ProgramCard({required this.planId, super.key});
  @override
  State<ProgramCard> createState() => _ProgramCardState();
}

class _ProgramCardState extends State<ProgramCard> {
  String name = '';
  String type = '';
  String photo = '';
  String description = '';

  Future<void> fetchAndPrintPlan(String planId) async {
    try {
      String? token = Provider.of<AuthProvider>(context, listen: false).token;
      Map<String, dynamic> response = await getPlanById(token!, planId);
      setState(() {
        name = response['data']['plan']['name'];
        photo = response['data']['plan']['photo'];
        type = response['data']['plan']['type'];
        description = response['data']['plan']['description'];
      });
    } catch (e) {
      // print('Error fetching plan: $e');
    }
  }

  @override
  void initState() {
    setState(() {
      fetchAndPrintPlan(widget.planId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Material(
        borderRadius: BorderRadius.circular(30),
        color: Color(hexColor("#A6CFFF")),
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PlanDetail(
                          planId: widget.planId,
                          name: name,
                          description: description,
                          type: type,
                        )));
          },
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 7, right: 7),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  SizedBox(
                      height: 79,
                      child: Image.asset(
                          'assets/images/program_image_default.png')),
                  const SizedBox(
                    width: 7,
                  ),
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: false,
                              style: const TextStyle(
                                fontSize: 20,
                                fontFamily: 'IBMPlexSansThai',
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              type == ''
                                  ? const SizedBox()
                                  : Image.asset(
                                      'assets/images/${type}_note_icon.png',
                                      height: 20,
                                    ),
                              const SizedBox(width: 10),
                              Text(
                                type == 'food'
                                    ? 'อาหาร'
                                    : type == 'exercise'
                                        ? 'ออกกำลังกาย'
                                        : type == 'rest'
                                            ? 'พักผ่อน'
                                            : type == 'health'
                                                ? 'สุขภาพ'
                                                : '-',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'IBMPlexSansThai',
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                                textAlign: TextAlign.left,
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 2.0),
                                child: Icon(
                                  Icons.monetization_on_outlined,
                                  color: Color(hexColor('#484554')),
                                  size: 16,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "100 คะแนน",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'IBMPlexSansThai',
                                  color: Color(hexColor('#484554')),
                                  fontWeight: FontWeight.normal,
                                ),
                                textAlign: TextAlign.left,
                              )
                            ],
                          ),
                        ]),
                  )
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
