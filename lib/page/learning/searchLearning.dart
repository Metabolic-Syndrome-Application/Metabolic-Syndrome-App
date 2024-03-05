import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/home/home.dart';
import 'package:flutter_application_1/widget/learning/learningCard.dart';

import '../../extension/Color.dart';

class SearchingLearning extends StatefulWidget {
  const SearchingLearning({super.key});

  @override
  State<SearchingLearning> createState() => _SearchingLearningState();
}

class _SearchingLearningState extends State<SearchingLearning> {
  final TextEditingController _searchController = TextEditingController();
  List<String> allTypes = [
    'โรคความดันโลหิตสูง',
    'โรคอ้วน',
    'โรคเบาหวาน',
    'ภาวะไขมันในเลือดสูง'
  ];
  List<String> filteredTypes = [];

  @override
  void initState() {
    super.initState();
    filteredTypes = allTypes;
    _searchController.addListener(_updateFilteredTypes);
  }

  void _updateFilteredTypes() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredTypes =
          allTypes.where((type) => type.toLowerCase().contains(query)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(hexColor('#FAFCFB')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 58, left: 20, right: 20),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Color(hexColor('#484554')),
                    size: 24,
                  ),
                ),
                const Text(
                  'ความรู้',
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
                height: 35,
              ),
              Container(
                  height: 35,
                  alignment: Alignment.center,
                  child: TextField(
                    textAlignVertical: TextAlignVertical.bottom,
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintStyle: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'IBMPlexSansThai',
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                      hintText: 'ค้นหาโรคหรืออาการ',
                      // Add a search icon or button to the search bar
                      prefixIcon: IconButton(
                        icon: const Icon(
                          Icons.search,
                          size: 20,
                        ),
                        onPressed: () {
                          // Perform the search here
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  )),
              const SizedBox(
                height: 15,
              ),

              ListView.builder(
                  padding: const EdgeInsets.all(0),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: filteredTypes.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: ArticleCard(
                        type: filteredTypes[index] == 'โรคความดันโลหิตสูง'
                            ? 'hypertension'
                            : filteredTypes[index] == 'โรคอ้วน'
                                ? 'obesity'
                                : filteredTypes[index] == 'โรคเบาหวาน'
                                    ? 'diabetes'
                                    : filteredTypes[index] ==
                                            'ภาวะไขมันในเลือดสูง'
                                        ? 'hyperlipidemia'
                                        : '',
                      ),
                    );
                  }),
              // ArticleCard()
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.removeListener(_updateFilteredTypes);
    _searchController.dispose();
    super.dispose();
  }
}
