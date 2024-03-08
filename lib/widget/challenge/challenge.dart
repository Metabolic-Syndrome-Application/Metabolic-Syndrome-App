import 'package:flutter/material.dart';
import 'package:flutter_application_1/extension/Color.dart';
import 'package:flutter_application_1/page/challenge/joinChallenge.dart';
import 'package:flutter_svg/svg.dart';

class ChallengeCard extends StatefulWidget {
  final String id;
  final String photo;
  final String name;
  final int points;
  final int numDays;
  final bool enable;
  const ChallengeCard({
    required this.id,
    required this.photo,
    required this.name,
    required this.points,
    required this.numDays,
    required this.enable,
    super.key,
  });

  @override
  State<ChallengeCard> createState() => _ChallengeCardState();
}

class _ChallengeCardState extends State<ChallengeCard> {
  // print(widget.photo);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Color(hexColor('#FFFFFF')),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.3),
            blurRadius: 4.0,
            spreadRadius: .1,
            offset: const Offset(
              0.0,
              4.0,
            ),
          ),
        ],
      ),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 7, right: 7),
      child: Row(
        children: [
          // CachedNetworkImage(
          //         imageUrl:
          //             widget.photo,
          //         height: 110,
          //         fit: BoxFit.fill,
          //       ),
          SvgPicture.network(
            height: 110,
            widget.photo,
            semanticsLabel: 'A shark?!',
            placeholderBuilder: (BuildContext context) => Container(
                padding: const EdgeInsets.all(30.0),
                child: const CircularProgressIndicator()),
          ),
          // Container(
          //     height: 110,
          //     // child: Image.asset('assets/images/challengeDefault.png')),
          //     child: Image.network(widget.photo)),
          SizedBox(
            width: 7,
          ),
          Expanded(
            child: Container(
              padding:
                  EdgeInsets.only(top: 18, bottom: 10, left: 10, right: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'IBMPlexSansThai',
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                        overflow: TextOverflow.ellipsis),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.monetization_on_outlined,
                          size: 14,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "${widget.points} คะแนน",
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
                          "${widget.numDays} วัน",
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
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MaterialButton(
                          height: 32,
                          minWidth: 73,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => JoinChallenge(
                                        id: widget.id, enable: widget.enable)));
                          },
                          color: Color(hexColor('#2F4EF1')),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            widget.enable ? 'เข้าร่วม' : 'รายละเอียด',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'IBMPlexSansThai',
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
