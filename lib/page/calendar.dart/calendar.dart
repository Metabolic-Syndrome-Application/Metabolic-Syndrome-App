import 'package:flutter/material.dart';
import 'package:flutter_application_1/extension/Color.dart';
import 'package:flutter_application_1/page/calendar.dart/selectCalendar.dart';
import 'package:flutter_application_1/widget/calendar/program_card.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class Calendar extends StatelessWidget {
  const Calendar({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('th', 'TH'),
      ],
      locale: Locale('th', 'TH'),
      title: 'Calendar Page',
      home: CalendarPage(),
    );
  }
}

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  Map<String, String> contentsList = {
    '2023-09-26': 'emoji_high',
    '2023-09-25': 'emoji_low',
    '2023-09-22': 'emoji_highest',
    '2023-10-01': 'emoji_highest',
  };

  String? chooseEmoji;

  String emotional = '';

  DateFormat f = DateFormat('yyyy-MM-dd');

  bool hasPlan = false;

  DateTime _isSelected = DateTime.now();
  String? detailsDate;
  String? dateTimeNow;

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

  void initState() {
    emotional = '';

    super.initState();
  }

  @override
  Widget build(BuildContext context1) {
    return Scaffold(
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
                    padding: EdgeInsets.only(left: 20, right: 20),
                    height: 390,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Color(hexColor('#DBDBDB'))),
                        color: Colors.white),
                    child: SfDateRangePicker(
                      onSelectionChanged: _onSelectionChanged,
                      selectionColor: Colors.white,
                      cellBuilder: (BuildContext context,
                          DateRangePickerCellDetails details) {
                        emotional = getEmoji(details.date, contentsList);
                        detailsDate = f.format(details.date).toString();
                        dateTimeNow = f.format(DateTime.now()).toString();

                        //control(emotional);
                        print('สร้างใหม่');
                        print(chooseEmoji);
                        print(detailsDate);
                        print(dateTimeNow);

                        // String? emotional =
                        //     contentsList[(f.format(details.date)).toString()];
                        // print(emotional);
                        bool isToday = isSameDate(details.date, DateTime.now());
                        bool isSpecialDate = isSpecialDay(details.date);
                        bool isSelected =
                            isSelectedDate(details.date, _isSelected);
                        bool isOverMinMax = isOverMinMaxDate(details.date);
                        return Container(
                          margin: const EdgeInsets.all(3),
                          padding: EdgeInsets.only(left: 2, right: 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: isSelected && !isToday
                                ? Color(hexColor('#B7DBC0'))
                                : isToday
                                    ? Color(hexColor('#A6CFFF'))
                                    : isSpecialDate
                                        ? Color(hexColor('#FFE9C9'))
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
                                    fontSize: 14,
                                    fontFamily: 'IBMPlexSansThai',
                                    color: isOverMinMax
                                        ? Color(hexColor('#999999'))
                                        : Colors.black,
                                    fontWeight: FontWeight.normal),
                              ),
                              emotional != ''
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Container(
                                        //   height: 2,
                                        //   width: 5,
                                        //   color: Colors.black,
                                        // ),
                                        Image.asset(
                                          detailsDate == dateTimeNow &&
                                                  chooseEmoji != null
                                              ? 'assets/images/$chooseEmoji.png'
                                              : 'assets/images/$emotional.png',
                                          height: 17,
                                        ),
                                        // Container(
                                        //   height: 2,
                                        //   width: 5,
                                        //   color: Colors.amber,
                                        // ),
                                      ],
                                    )
                                  : Container()
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
                    height: 51,
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
                  Container(
                    width: 300,
                    decoration: BoxDecoration(
                        color: Color(hexColor('#F4F9FF')),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Material(
                          color: chooseEmoji == 'emoji_highest'
                              ? Color(hexColor('#A6CFFF'))
                              : Color(hexColor('#F4F9FF')),
                          borderRadius: BorderRadius.circular(30),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(30),
                            onTap: () {
                              setState(() {
                                imageCache.clear();
                                chooseEmoji = 'emoji_highest';
                              });
                            },
                            child: Container(
                              height: 71,
                              width: 58,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30)),
                              child: Image.asset(
                                'assets/images/emoji_highest.png',
                                width: 45,
                              ),
                            ),
                          ),
                        ),
                        Material(
                          color: chooseEmoji == 'emoji_high'
                              ? Color(hexColor('#A6CFFF'))
                              : Color(hexColor('#F4F9FF')),
                          borderRadius: BorderRadius.circular(30),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(30),
                            onTap: () {
                              setState(() {
                                imageCache.clear();
                                chooseEmoji = 'emoji_high';
                              });
                            },
                            child: Container(
                              height: 71,
                              width: 58,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30)),
                              child: Image.asset(
                                'assets/images/emoji_high.png',
                                width: 45,
                              ),
                            ),
                          ),
                        ),
                        Material(
                          color: chooseEmoji == 'emoji_normal'
                              ? Color(hexColor('#A6CFFF'))
                              : Color(hexColor('#F4F9FF')),
                          borderRadius: BorderRadius.circular(30),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(30),
                            onTap: () {
                              setState(() {
                                imageCache.clear();
                                chooseEmoji = 'emoji_normal';
                              });
                            },
                            child: Container(
                              height: 71,
                              width: 58,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30)),
                              child: Image.asset(
                                'assets/images/emoji_normal.png',
                                width: 45,
                              ),
                            ),
                          ),
                        ),
                        Material(
                          color: chooseEmoji == 'emoji_low'
                              ? Color(hexColor('#A6CFFF'))
                              : Color(hexColor('#F4F9FF')),
                          borderRadius: BorderRadius.circular(30),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(30),
                            onTap: () {
                              setState(() {
                                imageCache.clear();
                                chooseEmoji = 'emoji_low';
                              });
                            },
                            child: Container(
                              height: 71,
                              width: 58,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30)),
                              child: Image.asset(
                                'assets/images/emoji_low.png',
                                width: 45,
                              ),
                            ),
                          ),
                        ),
                        Material(
                          color: chooseEmoji == 'emoji_lowest'
                              ? Color(hexColor('#A6CFFF'))
                              : Color(hexColor('#F4F9FF')),
                          borderRadius: BorderRadius.circular(30),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(30),
                            onTap: () {
                              setState(() {
                                imageCache.clear();
                                chooseEmoji = 'emoji_lowest';
                                print('lowest');
                              });
                            },
                            child: Container(
                              height: 71,
                              width: 58,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30)),
                              child: Image.asset(
                                'assets/images/emoji_lowest.png',
                                width: 45,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
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
                  SizedBox(
                    height: 20,
                  ),
                  ProgramCard(),
                  SizedBox(
                    height: 170,
                  )
                ],
              ),
            ),
          ),
        ));
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

String getEmoji(DateTime detail, Map<String, String> contentsList) {
  DateFormat f = DateFormat('yyyy-MM-dd');
  setState() {}

  String emotional = contentsList[f.format(detail).toString()] ?? '';
  return emotional;
}
// bool hasEmotion(){
//   if
// }
