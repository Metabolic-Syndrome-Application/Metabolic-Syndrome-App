import 'package:flutter/material.dart';
import 'package:flutter_application_1/authProvider.dart';
import 'package:flutter_application_1/page/learning/mainLearning.dart';
import 'package:flutter_application_1/response/api.dart';
import 'package:provider/provider.dart';

import '../../extension/Color.dart';

class ArticleCard extends StatefulWidget {
  final String type;
  const ArticleCard({super.key, required this.type});

  @override
  State<ArticleCard> createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
  String name = '';
  String details = '';
  String symptoms = '';
  String medications = '';
  String behaviors = '';

  Future<void> fetchKnowledge(String disease) async {
    try {
      String? token = Provider.of<AuthProvider>(context, listen: false).token;
      Map<String, dynamic> response = await getKnowledge(token!, disease);
      setState(() {
        print(response);
        name = response['data']['name'];
        print(name);
        details = response['data']['details'];
        symptoms = response['data']['symptoms'];
        medications = response['data']['medications'];
        behaviors = response['data']['behaviors'];
      });
    } catch (e) {
      // print('Error fetching profile: $e');
    }
  }

  @override
  void initState() {
    fetchKnowledge(widget.type);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      
      borderRadius: BorderRadius.circular(30),
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MainLearning(
                        photo: widget.type,
                        name: name,
                        details: details,
                        symptoms: symptoms,
                        medications: medications,
                        behaviors: behaviors,
                      )));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                width: 115,
                child: Image.asset('assets/images/${widget.type}.png'),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                  child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                        style: const TextStyle(
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
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      details,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'IBMPlexSansThai',
                        color: Color(hexColor('#999999')),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
