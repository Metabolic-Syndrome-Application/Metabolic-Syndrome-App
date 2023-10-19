import 'package:flutter/material.dart';
import 'package:flutter_application_1/extension/Color.dart';


class ProgramCard extends StatelessWidget {
  const ProgramCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(30),
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: () {
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => Challenge()));
        },
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 7, right: 7),
          child: Row(
            children: [
              Container(
                  height: 79,
                  child: Image.asset(
                      'assets/images/program_image_default.png')),
              SizedBox(
                width: 7,
              ),
              Container(
                padding:
                    EdgeInsets.only(top: 18, bottom: 18, left: 10, right: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("โปรเเกรมความเสี่ยงต่ำ",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'IBMPlexSansThai',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.monetization_on_outlined,
                            size: 14,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "100 coins",
                            style: TextStyle(
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
                        children: [
                          Icon(
                            Icons.access_time_outlined,
                            size: 14,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "1 สัปดาห์",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'IBMPlexSansThai',
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.left,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      Container(
                        width: 100,
                        height: 6,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: LinearProgressIndicator(
                            value: 0.7,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color(hexColor('#FFC556'))),
                            backgroundColor: Color(hexColor('#D9D9D9')),
                          ),
                        ),
                      )
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
