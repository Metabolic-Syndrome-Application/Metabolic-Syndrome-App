import 'package:flutter/material.dart';
import 'package:flutter_application_1/authProvider.dart';
import 'package:flutter_application_1/extension/Color.dart';
import 'package:flutter_application_1/page/calendar.dart/selectCalendar.dart';
import 'package:flutter_application_1/response/api.dart';
import 'package:flutter_application_1/widget/calendar/program_card.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  Map<String, String> contentsList = {};
  Future<void> fetchAllMood() async {
    try {
      String? token = Provider.of<AuthProvider>(context, listen: false).token;
      Map<String, dynamic> response = await getAllMood(token!);
      setState(() {
        var allMood = response['data'];
        for (var record in allMood) {
          contentsList[record["date"]] = record["mood"];
        }
      });
    } catch (e) {
      // print('Error fetching profile: $e');
    }
  }

  DateTime currentDateTime = DateTime.now();

  String chooseEmoji = '';

  String emotional = '';

  DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  bool hasPlan = true;

  DateTime _isSelected = DateTime.now();
  String? detailsDate;
  String? dateTimeNow;

  String latestMood = "";

  dynamic listOfPlan = '';

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is DateTime) {
        _isSelected = args.value;
      }
    });

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SelectedDate(args.value, hasPlan)));
  }

  @override
  void initState() {
    setState(() {
      fetchAllMood();
      fetchLatestMood();
      fetchAllPlan();
    });

    super.initState();
  }

  Future<void> getEmoji(
      DateTime detail, Map<String, String> contentsList) async {
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');

    emotional = contentsList[dateFormat.format(detail).toString()] ?? '';

    //return emotional;
  }

  Future<void> fetchLatestMood() async {
    try {
      String? token = Provider.of<AuthProvider>(context, listen: false).token;
      Map<String, dynamic> response = await getLatestMood(token!);
      setState(() {
        latestMood = response['data']['mood'];
      });
    } catch (e) {
      // print('Error fetching profile: $e');
    }
  }

  Future<void> fetchRecordMood() async {
    try {
      String? token = Provider.of<AuthProvider>(context, listen: false).token;
      await postMood(token!, chooseEmoji);
      setState(() {
        fetchLatestMood();
      });
    } catch (e) {
      // print('Error fetching profile: $e');
    }
  }

  Future<void> fetchAllPlan() async {
    try {
      String? token = Provider.of<AuthProvider>(context, listen: false).token;
      Map<String, dynamic> response = await getAllPlan(token!);
      setState(() {
        listOfPlan = response['data']['plan'];
        // print(listOfPlan[0]['name']);
        // print(listOfPlan);
      });
    } catch (e) {
      // print('Error fetching profile: $e');
    }
  }

  @override
  Widget build(BuildContext context1) {
    return MaterialApp(
      key: UniqueKey(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('th', 'TH'),
      ],
      locale: const Locale('th', 'TH'),
      title: 'Calendar Page',
      home: Scaffold(
          backgroundColor: Color(hexColor('#FAFCFB')),
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 58),
                child: Column(
                  children: [
                    Text(
                      'ปฏิทิน',
                      style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'IBMPlexSansThai',
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      height: 400,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Color(hexColor('#DBDBDB'))),
                          color: Colors.white),
                      child: SfDateRangePicker(
                        key: UniqueKey(),
                        onSelectionChanged: _onSelectionChanged,
                        selectionColor: Colors.white,
                        cellBuilder: (BuildContext context,
                            DateRangePickerCellDetails details) {
                          getEmoji(details.date, contentsList);
                          detailsDate =
                              dateFormat.format(details.date).toString();
                          dateTimeNow =
                              dateFormat.format(DateTime.now()).toString();
                          bool isToday =
                              isSameDate(details.date, DateTime.now());
                          bool isSpecialDate = isSpecialDay(details.date);
                          bool isSelected =
                              isSelectedDate(details.date, _isSelected);
                          bool isOverMinMax = isOverMinMaxDate(details.date);
                          return Container(
                            margin: const EdgeInsets.all(3),
                            padding: const EdgeInsets.only(left: 2, right: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: isSelected && !isToday
                                  ? Color(hexColor('#B7DBC0'))
                                  : isToday
                                      ? Color(hexColor('#A6CFFF'))
                                      : isSpecialDate
                                          ? Color(hexColor('#FEDC86'))
                                          : Color(hexColor('#F4F9FF')),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  isToday
                                      ? 'วันนี้'
                                      : details.date.day.toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'IBMPlexSansThai',
                                      color: isOverMinMax
                                          ? Color(hexColor('#999999'))
                                          : Colors.black,
                                      fontWeight: FontWeight.normal),
                                ),
                                Row(
                                  key: UniqueKey(),
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    latestMood != '' &&
                                            detailsDate == dateTimeNow
                                        ? Image.asset(
                                            'assets/images/$latestMood.png',
                                            height: 17,
                                          )
                                        : emotional != '' ||
                                                (chooseEmoji != '' &&
                                                    detailsDate == dateTimeNow)
                                            ? Image.asset(
                                                detailsDate == dateTimeNow &&
                                                        chooseEmoji != ''
                                                    ? 'assets/images/$chooseEmoji.png'
                                                    : 'assets/images/$emotional.png',
                                                height: 17,
                                              )
                                            : Container()
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                        headerHeight: 80,
                        headerStyle: const DateRangePickerHeaderStyle(
                            textAlign: TextAlign.center,
                            textStyle: TextStyle(
                              fontSize: 16,
                              fontFamily: 'IBMPlexSansThai',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            )),
                        showNavigationArrow: true,
                        allowViewNavigation: false,
                        minDate: DateTime(DateTime.now().year,
                            DateTime.now().month - 1, DateTime.now().day),
                        maxDate: DateTime(DateTime.now().year,
                            DateTime.now().month, DateTime.now().day),
                        view: DateRangePickerView.month,
                        selectionMode: DateRangePickerSelectionMode.single,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
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
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'วันนี้คุณมีความรู้สึกอย่างไร ?',
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'IBMPlexSansThai',
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 22,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Material(
                                color: chooseEmoji == 'emoji_highest' ||
                                        latestMood == 'emoji_highest'
                                    ? Color(hexColor('#A6CFFF'))
                                    : Color(hexColor('#FFFFFF')),
                                borderRadius: BorderRadius.circular(20),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: () {
                                    setState(() {
                                      imageCache.clear();
                                      // print("click $chooseEmoji");
                                      chooseEmoji = 'emoji_highest';
                                      // print("click $chooseEmoji");
                                      fetchRecordMood();
                                    });
                                  },
                                  child: Container(
                                    height: 88,
                                    width: 70,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Image.asset(
                                          'assets/images/emoji_highest.png',
                                          width: 45,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'ท้อ',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'IBMPlexSansThai',
                                              color: chooseEmoji ==
                                                          'emoji_highest' ||
                                                      latestMood ==
                                                          'emoji_highest'
                                                  ? Color(hexColor('#FFFFFF'))
                                                  : Color(hexColor('#7B7B7B')),
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Material(
                                color: chooseEmoji == 'emoji_high' ||
                                        latestMood == 'emoji_high'
                                    ? Color(hexColor('#A6CFFF'))
                                    : Color(hexColor('#FFFFFF')),
                                borderRadius: BorderRadius.circular(20),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: () {
                                    setState(() {
                                      chooseEmoji = 'emoji_high';
                                      fetchRecordMood();
                                    });
                                  },
                                  child: Container(
                                    height: 88,
                                    width: 70,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Image.asset(
                                          'assets/images/emoji_high.png',
                                          width: 45,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'เศร้า',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'IBMPlexSansThai',
                                              color: chooseEmoji ==
                                                          'emoji_high' ||
                                                      latestMood == 'emoji_high'
                                                  ? Color(hexColor('#FFFFFF'))
                                                  : Color(hexColor('#7B7B7B')),
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Material(
                                color: chooseEmoji == 'emoji_normal' ||
                                        latestMood == 'emoji_normal'
                                    ? Color(hexColor('#A6CFFF'))
                                    : Color(hexColor('#FFFFFF')),
                                borderRadius: BorderRadius.circular(20),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: () {
                                    setState(() {
                                      chooseEmoji = 'emoji_normal';
                                      fetchRecordMood();
                                    });
                                  },
                                  child: Container(
                                    height: 88,
                                    width: 70,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Image.asset(
                                          'assets/images/emoji_normal.png',
                                          width: 45,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'เฉยๆ',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'IBMPlexSansThai',
                                              color: chooseEmoji ==
                                                          'emoji_normal' ||
                                                      latestMood ==
                                                          'emoji_normal'
                                                  ? Color(hexColor('#FFFFFF'))
                                                  : Color(hexColor('#7B7B7B')),
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Material(
                                color: chooseEmoji == 'emoji_low' ||
                                        latestMood == 'emoji_low'
                                    ? Color(hexColor('#A6CFFF'))
                                    : Color(hexColor('#FFFFFF')),
                                borderRadius: BorderRadius.circular(20),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: () {
                                    setState(() {
                                      chooseEmoji = 'emoji_low';
                                      fetchRecordMood();
                                    });
                                  },
                                  child: Container(
                                    height: 88,
                                    width: 70,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Image.asset(
                                          'assets/images/emoji_low.png',
                                          width: 45,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'มีความสุข',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'IBMPlexSansThai',
                                              color: chooseEmoji ==
                                                          'emoji_low' ||
                                                      latestMood == 'emoji_low'
                                                  ? Color(hexColor('#FFFFFF'))
                                                  : Color(hexColor('#7B7B7B')),
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Material(
                                color: chooseEmoji == 'emoji_lowest' ||
                                        latestMood == 'emoji_lowest'
                                    ? Color(hexColor('#A6CFFF'))
                                    : Color(hexColor('#FFFFFF')),
                                borderRadius: BorderRadius.circular(20),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: () {
                                    setState(() {
                                      chooseEmoji = 'emoji_lowest';
                                      fetchRecordMood();
                                    });
                                  },
                                  child: Container(
                                    height: 88,
                                    width: 70,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Image.asset(
                                          'assets/images/emoji_lowest.png',
                                          width: 45,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'เบิกบาน',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'IBMPlexSansThai',
                                              color: chooseEmoji ==
                                                          'emoji_lowest' ||
                                                      latestMood ==
                                                          'emoji_lowest'
                                                  ? Color(hexColor('#FFFFFF'))
                                                  : Color(hexColor('#7B7B7B')),
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'แผนสุขภาพ',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'IBMPlexSansThai',
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: listOfPlan.length,
                        itemBuilder: (context, index) {
                          return ProgramCard(
                            planId: listOfPlan[index]['id'],
                            planName: listOfPlan[index]['name'],
                            planType: listOfPlan[index]['type'],
                          );
                        }),
                    SizedBox(
                      height: 170,
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

bool isSpecialDay(DateTime date) {
  if ((date.day == DateTime.now().day - 1 ||
          date.day == DateTime.now().day - 2 ||
          date.day == DateTime.now().day - 3) &&
      date.month == DateTime.now().month) {
    return true;
  }

  return false;
}

bool isSameDate(DateTime date, DateTime dateTime) {
  if (date.year == dateTime.year &&
      date.month == dateTime.month &&
      date.day == dateTime.day) {
    return true;
  }

  return false;
}

bool isSelectedDate(DateTime date, DateTime isSelected) {
  if (date.day == isSelected.day &&
      date.month == isSelected.month &&
      date.year == isSelected.year) {
    return true;
  }
  return false;
}

bool isOverMinMaxDate(DateTime date) {
  if ((date.day > DateTime.now().day && date.month == DateTime.now().month) ||
      (date.day < DateTime.now().day &&
          date.month == DateTime.now().month - 1)) {
    return true;
  }
  return false;
}
