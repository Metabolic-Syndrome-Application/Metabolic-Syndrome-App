import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/authProvider.dart';
import 'package:flutter_application_1/data/planList.dart';
import 'package:flutter_application_1/extension/Color.dart';
import 'package:flutter_application_1/page/calendar.dart/calendar.dart';
import 'package:flutter_application_1/response/api.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SelectedDate extends StatelessWidget {
  final DateTime selectedDate;
  final bool hasPlan;
  const SelectedDate(this.selectedDate, this.hasPlan, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SelectedDatePage(selectedDate, hasPlan));
  }
}

class SelectedDatePage extends StatefulWidget {
  final DateTime selectedDate;
  final bool hasPlan;
  const SelectedDatePage(this.selectedDate, this.hasPlan, {super.key});

  @override
  State<SelectedDatePage> createState() => _SelectedDatePageState();
}

class _SelectedDatePageState extends State<SelectedDatePage> {
  String selectedfilter = "ทั้งหมด";

  final List<String> items = [];

  int initial = 1;
  late final CustomSegmentedController<int> controller;
  String? selectedPlanType = 'ทั้งหมด';
  int pageChanged = 1;
  DateFormat f = DateFormat('dd/MM/yyyy');
  DateFormat formatForCheck = DateFormat('yyyy-MM-dd 00:00:00.000');
  PageController _pageController = PageController();

  bool isChecked1 = false;
  bool isChecked2 = false;

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Color(hexColor('#2F4EF1'));
    }
    return Color(hexColor('#2F4EF1'));
  }

  Widget taskManagement(List<Item> planItem, int index, bool checkEnable) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Color(hexColor('#FFFFFF')),
          borderRadius: BorderRadius.circular(20),
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Checkbox(
                activeColor:
                    checkEnable ? Color(hexColor('#2F4EF1')) : Colors.grey,
                shape: const CircleBorder(),
                value: planItem[index].check,
                onChanged: checkEnable
                    ? (value) {
                        setState(() {
                          planItem[index].check = value!;
                          List<Map<String, dynamic>> itemList =
                              planItem.map((item) => item.toMap()).toList();
                          fetchUpdatePlan(itemList);
                        });
                      }
                    : null,
              ),
              Expanded(
                child: Text(
                  planItem[index].name,
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'IBMPlexSansThai',
                      color: checkEnable
                          ? Colors.black
                          : Color(hexColor('#7B7B7B')),
                      fontWeight: FontWeight.normal,
                      decoration: planItem[index].check == true
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Image.asset(
                  'assets/images/${planItem[index].type}_note_icon.png',
                  width: 20,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _warningPopup(String warningText) {
    showDialog(
        context: context,
        barrierDismissible: false,
        //context: _scaffoldKey.currentContext,
        builder: (context) {
          return AlertDialog(
            titlePadding: const EdgeInsets.only(top: 0),
            contentPadding:
                const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 20),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: SizedBox(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/icon_warning_record.png',
                      height: 100,
                    ),
                    Text(
                      warningText,
                      style: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'IBMPlexSansThai',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    MaterialButton(
                      height: 44,
                      color: Color(hexColor('#2F4EF1')),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(23.5),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text("ปิด",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'IBMPlexSansThai',
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  late int height = 0;
  late int weight = 0;
  late int waistline = 0;

  late int systolicBloodPressure = 0;
  late int diastolicBloodPressure = 0;
  late int pulseRate = 0;

  late int bloodGlucose = 0;

  late int cholesterol = 0;
  late int triglyceride = 0;
  late int hdl = 0;
  late int ldl = 0;

  late int heightEnable = 0;
  late int weightEnable = 0;
  late int waistlineEnable = 0;

  late int systolicBloodPressureEnable = 0;
  late int diastolicBloodPressureEnable = 0;
  late int pulseRateEnable = 0;

  late int bloodGlucoseEnable = 0;
  late double bmiEnable = 0.0;

  late int cholesterolEnable = 0;
  late int triglycerideEnable = 0;
  late int hdlEnable = 0;
  late int ldlEnable = 0;

  late int heightHint = 0;
  late int weightHint = 0;
  late int waistlineHint = 0;

  late int systolicBloodPressureHint = 0;
  late int diastolicBloodPressureHint = 0;
  late int pulseRateHint = 0;
  late int bloodGlucoseHint = 0;

  late int cholesterolHint = 0;
  late int triglycerideHint = 0;
  late int hdlHint = 0;
  late int ldlHint = 0;

  late String timeStamp = '';
  late String formatDate = '';

  dynamic listOfPressure;
  dynamic listOfLipid;
  dynamic listOfGlucose;
  dynamic listOfBmi;
  dynamic listOfWaistline;

  Future<void> fetchLatest() async {
    try {
      String? token = Provider.of<AuthProvider>(context, listen: false).token;
      Map<String, dynamic> response = await getLatestRecord(token!);
      setState(() {
        systolicBloodPressureHint =
            response['data']['record'][0]['systolicBloodPressure'];
        diastolicBloodPressureHint =
            response['data']['record'][0]['diastolicBloodPressure'];
        pulseRateHint = response['data']['record'][0]['pulseRate'];
        heightHint = response['data']['record'][0]['height'];
        weightHint = response['data']['record'][0]['weight'];
        waistlineHint = response['data']['record'][0]['waistline'];
        bloodGlucoseHint = response['data']['record'][0]['bloodGlucose'];
        cholesterolHint = response['data']['record'][0]['cholesterol'];
        hdlHint = response['data']['record'][0]['hdl'];
        ldlHint = response['data']['record'][0]['ldl'];
        triglycerideHint = response['data']['record'][0]['triglyceride'];
        timeStamp = response['data']['record'][0]['timestamp'];
        DateTime inputDateTime = DateTime.parse(timeStamp);
        timeStamp = DateFormat('dd MMM HH:mm', 'th').format(inputDateTime);
      });
    } catch (e) {
      // print('Error fetching profile: $e');
    }
  }

  Future<void> fetchRecord() async {
    try {
      String? token = Provider.of<AuthProvider>(context, listen: false).token;
      await postHealthRecord(
          token!,
          systolicBloodPressure == 0
              ? systolicBloodPressureHint
              : systolicBloodPressure,
          diastolicBloodPressure == 0
              ? diastolicBloodPressureHint
              : diastolicBloodPressure,
          pulseRate == 0 ? pulseRateHint : pulseRate,
          height == 0 ? heightHint : height,
          weight == 0 ? weightHint : weight,
          waistline == 0 ? waistlineHint : waistline,
          bloodGlucose == 0 ? bloodGlucoseHint : bloodGlucose,
          cholesterol == 0 ? cholesterolHint : cholesterol,
          hdl == 0 ? hdlHint : hdl,
          ldl == 0 ? ldlHint : ldl,
          triglyceride == 0 ? triglycerideHint : triglyceride);
      setState(() {
        //print(response);
        fetchLatest();
      });
    } catch (e) {
      // print('Error fetching profile: $e');
    }
  }

  Future<void> fetchBloodPressure(DateTime selectDate) async {
    try {
      String? token = Provider.of<AuthProvider>(context, listen: false).token;
      Map<String, dynamic> response = await getBloodPressure(token!);
      setState(() {
        listOfPressure = response['data']['record'];
        final DateFormat formatter = DateFormat('yyyy-MM-dd');
        final targetDate = selectDate;

        var filteredData = listOfPressure.where((entry) {
          DateTime entryDate = DateTime.parse(entry['timestamp']);
          return formatter.format(entryDate) == formatter.format(targetDate);
        }).toList();

        filteredData.sort((a, b) => DateTime.parse(b['timestamp'])
            .compareTo(DateTime.parse(a['timestamp'])));

        var latestEntry = filteredData.isNotEmpty ? filteredData.first : null;

        systolicBloodPressureEnable = latestEntry['systolicBloodPressure'];
        diastolicBloodPressureEnable = latestEntry['diastolicBloodPressure'];
        pulseRateEnable = latestEntry['pulseRate'];
      });
    } catch (e) {
      // print('Error fetching profile: $e');
    }
  }

  Future<void> fetchBloodLipid(DateTime selectDate) async {
    try {
      String? token = Provider.of<AuthProvider>(context, listen: false).token;
      Map<String, dynamic> response = await getBloodLipid(token!);
      setState(() {
        listOfLipid = response['data']['record'];
        final DateFormat formatter = DateFormat('yyyy-MM-dd');
        final targetDate = selectDate;
        var filteredData = listOfLipid.where((entry) {
          DateTime entryDate = DateTime.parse(entry['timestamp']);
          return formatter.format(entryDate) == formatter.format(targetDate);
        }).toList();

        filteredData.sort((a, b) => DateTime.parse(b['timestamp'])
            .compareTo(DateTime.parse(a['timestamp'])));

        var latestEntry = filteredData.isNotEmpty ? filteredData.first : null;

        cholesterolEnable = latestEntry['cholesterol'];
        hdlEnable = latestEntry['hdl'];
        ldlEnable = latestEntry['ldl'];
        triglycerideEnable = latestEntry['triglyceride'];
      });
    } catch (e) {
      // print('Error fetching profile: $e');
    }
  }

  Future<void> fetchBloodGlucose(DateTime selectDate) async {
    try {
      String? token = Provider.of<AuthProvider>(context, listen: false).token;
      Map<String, dynamic> response = await getBloodGlucose(token!);
      setState(() {
        listOfGlucose = response['data']['record'];
        final DateFormat formatter = DateFormat('yyyy-MM-dd');
        final targetDate = selectDate;
        var filteredData = listOfGlucose.where((entry) {
          DateTime entryDate = DateTime.parse(entry['timestamp']);
          return formatter.format(entryDate) == formatter.format(targetDate);
        }).toList();

        filteredData.sort((a, b) => DateTime.parse(b['timestamp'])
            .compareTo(DateTime.parse(a['timestamp'])));

        var latestEntry = filteredData.isNotEmpty ? filteredData.first : null;

        bloodGlucoseEnable = latestEntry['bloodGlucose'];
      });
    } catch (e) {
      // print('Error fetching profile: $e');
    }
  }

  Future<void> fetchBmi(DateTime selectDate) async {
    try {
      String? token = Provider.of<AuthProvider>(context, listen: false).token;
      Map<String, dynamic> response = await getBmi(token!);
      setState(() {
        listOfBmi = response['data']['record'];
        final DateFormat formatter = DateFormat('yyyy-MM-dd');
        final targetDate = selectDate;
        var filteredData = listOfBmi.where((entry) {
          DateTime entryDate = DateTime.parse(entry['timestamp']);
          return formatter.format(entryDate) == formatter.format(targetDate);
        }).toList();

        filteredData.sort((a, b) => DateTime.parse(b['timestamp'])
            .compareTo(DateTime.parse(a['timestamp'])));

        var latestEntry = filteredData.isNotEmpty ? filteredData.first : null;

        bmiEnable = latestEntry['bmi'];
      });
    } catch (e) {
      // print('Error fetching profile: $e');
    }
  }

  Future<void> fetchWaistline(DateTime selectDate) async {
    try {
      String? token = Provider.of<AuthProvider>(context, listen: false).token;
      Map<String, dynamic> response = await getWaistline(token!);
      setState(() {
        listOfWaistline = response['data']['record'];
        final DateFormat formatter = DateFormat('yyyy-MM-dd');
        final targetDate = selectDate;

        var filteredData = listOfWaistline.where((entry) {
          DateTime entryDate = DateTime.parse(entry['timestamp']);
          return formatter.format(entryDate) == formatter.format(targetDate);
        }).toList();

        filteredData.sort((a, b) => DateTime.parse(b['timestamp'])
            .compareTo(DateTime.parse(a['timestamp'])));

        var latestEntry = filteredData.isNotEmpty ? filteredData.first : null;

        waistlineEnable = latestEntry['waistline'];
      });
    } catch (e) {
      // print('Error fetching profile: $e');
    }
  }

  List<Item> listOfPlan = [];

  Future<void> fetchPlan(DateTime selectDate) async {
    try {
      String? token = Provider.of<AuthProvider>(context, listen: false).token;
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      Map<String, dynamic> response =
          await getPlan(token!, formatter.format(selectDate).toString());

      listOfPlan.clear();
      items.clear();
      items.add('ทั้งหมด');
      for (var item in response['data']['list']) {
        listOfPlan.add(Item(
          name: item['name'],
          check: item['check'],
          type: item['type'],
        ));
        if (!items.contains(item['type'] == "food"
            ? "อาหาร"
            : item['type'] == "exercise"
                ? "ออกกำลังกาย"
                : item['type'] == "rest"
                    ? "พักผ่อน"
                    : item['type'] == "health"
                        ? "สุขภาพ"
                        : null)) {
          if (item['type'] == "food") {
            items.add("อาหาร");
          } else if (item['type'] == "exercise") {
            items.add("ออกกำลังกาย");
          } else if (item['type'] == "rest") {
            items.add("พักผ่อน");
          } else if (item['type'] == "health") {
            items.add("สุขภาพ");
          }
        }
      }
    } catch (e) {
      // print('Error fetching profile: $e');
    }
  }

  Future<void> fetchUpdatePlan(List<Map<String, dynamic>> listUpdate) async {
    try {
      String? token = Provider.of<AuthProvider>(context, listen: false).token;
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      await postUpdatePlan(
        token!,
        formatter.format(widget.selectedDate).toString(),
        listUpdate,
      );
      setState(() {});
    } catch (e) {
      // Handle errors appropriately
    }
  }

  late TextEditingController _controllerSystolicBloodPressure;
  late TextEditingController _controllerDiastolicBloodPressure;
  late TextEditingController _controllerPulseRate;

  late TextEditingController _controllerHeight;
  late TextEditingController _controllerWeight;
  late TextEditingController _controllerWaistline;

  late TextEditingController _controllerBloodGlucose;

  late TextEditingController _controllerCholesterol;
  late TextEditingController _controllerHdl;
  late TextEditingController _controllerLdl;
  late TextEditingController _controllerTriglyceride;

  @override
  void initState() {
    checkEnable(widget.selectedDate);
    fetchLatest();
    fetchBloodPressure(widget.selectedDate);
    fetchBmi(widget.selectedDate);
    fetchWaistline(widget.selectedDate);
    fetchBloodGlucose(widget.selectedDate);
    fetchBloodLipid(widget.selectedDate);
    fetchPlan(widget.selectedDate);
    controller = CustomSegmentedController();
    _controllerHeight = TextEditingController(
        text: height == 0 ? null : height.round().toString());
    _controllerWeight = TextEditingController(
        text: weight == 0 ? null : weight.round().toString());
    _controllerWaistline = TextEditingController(
        text: waistline == 0 ? null : waistline.round().toString());
    _controllerSystolicBloodPressure = TextEditingController(
        text: systolicBloodPressure == 0
            ? null
            : systolicBloodPressure.toString());
    _controllerDiastolicBloodPressure = TextEditingController(
        text: diastolicBloodPressure == 0
            ? null
            : diastolicBloodPressure.toString());
    _controllerPulseRate = TextEditingController(
        text: pulseRate == 0 ? null : pulseRate.toString());
    _controllerBloodGlucose = TextEditingController(
        text: bloodGlucose == 0 ? null : bloodGlucose.toString());
    _controllerCholesterol = TextEditingController(
        text: cholesterol == 0 ? null : cholesterol.round().toString());
    _controllerHdl =
        TextEditingController(text: hdl == 0 ? null : hdl.round().toString());
    _controllerLdl =
        TextEditingController(text: ldl == 0 ? null : ldl.round().toString());
    _controllerTriglyceride = TextEditingController(
        text: triglyceride == 0 ? null : triglyceride.round().toString());
    super.initState();
  }

  bool slideMai = true;

  bool checkBloodPressure = false;

  bool checkBloodLipids = false;

  bool checkEnable(DateTime selectDate) {
    bool exists = false;
    List<String> dateList = [];
    for (int i = 0; i < 4; i++) {
      DateTime date = DateTime.now().subtract(Duration(days: i));
      String formattedDate =
          formatForCheck.format(DateTime(date.year, date.month, date.day));
      dateList.add(formattedDate);
    }
    String formattedSelectDate = formatForCheck.format(selectDate);
    exists = dateList.contains(formattedSelectDate);

    return exists;
  }

  @override
  Widget build(BuildContext context) {
    String selectedDate = f.format(widget.selectedDate).toString();
    String today = f.format(DateTime.now()).toString();

//     DateTime selectedDateEnable = widget.selectedDate;

// // Today's date
//     DateTime todayEnable = DateTime.now();

// // Remove the time part to compare only dates
//     DateTime justToday =
//         DateTime(todayEnable.year, todayEnable.month, todayEnable.day);
//     DateTime justSelectedDate = DateTime(selectedDateEnable.year,
//         selectedDateEnable.month, selectedDateEnable.day);

//     int difference = justToday.difference(justSelectedDate).inDays;

//     bool isSelectedDateWithin4DaysBeforeToday =
//         difference >= 0 && difference <= 4;

//     if (isSelectedDateWithin4DaysBeforeToday) {
//       print("Selected date is within 4 days before today.");
//     } else {
//       print("Selected date is not within 4 days before today.");
//     }

    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(hexColor('#FAFCFB')),
        body: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 58),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CalendarPage()));
                              },
                              child: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: Color(hexColor('#484554')),
                                size: 24,
                              ),
                            ),
                            Text(
                              "บันทึก",
                              style: const TextStyle(
                                fontSize: 24,
                                fontFamily: 'IBMPlexSansThai',
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 24,
                            )
                          ]),
                      const SizedBox(
                        height: 19,
                      ),
                      CustomSlidingSegmentedControl<int>(
                        initialValue: 1,
                        controller: CustomSegmentedController(value: initial),
                        children: {
                          1: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'พฤติกรรม',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'IBMPlexSansThai',
                                  color: initial == 1
                                      ? Colors.black
                                      : Color(hexColor('#484554')),
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                          2: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'ค่าสุขภาพ',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'IBMPlexSansThai',
                                  color: initial == 2
                                      ? Colors.black
                                      : Color(hexColor('#484554')),
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        },
                        decoration: BoxDecoration(
                          color: Color(hexColor('#F2F2F2')),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        thumbDecoration: BoxDecoration(
                            color: Color(hexColor('#C9E1FD')),
                            borderRadius: BorderRadius.circular(30)),
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInToLinear,
                        onValueChanged: (v) {
                          if (v == 2 &&
                              _pageController.hasClients &&
                              initial != 2) {
                            setState(() {
                              initial = 2;
                              _pageController.nextPage(
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeIn);
                            });
                          } else if (v == 1 && initial != 1) {
                            setState(() {
                              initial = 1;
                              if ((_controllerSystolicBloodPressure.text ==
                                          "" ||
                                      _controllerDiastolicBloodPressure.text ==
                                          "" ||
                                      _controllerPulseRate.text == "") &&
                                  !(_controllerSystolicBloodPressure.text ==
                                          "" &&
                                      _controllerDiastolicBloodPressure.text ==
                                          "" &&
                                      _controllerPulseRate.text == "")) {
                                checkBloodPressure = true;
                              }

                              if ((_controllerCholesterol.text == "" ||
                                      _controllerHdl.text == "" ||
                                      _controllerLdl.text == "" ||
                                      _controllerTriglyceride.text == "") &&
                                  !(_controllerCholesterol.text == "" &&
                                      _controllerHdl.text == "" &&
                                      _controllerLdl.text == "" &&
                                      _controllerTriglyceride.text == "")) {
                                checkBloodLipids = true;
                              }
                              if (_controllerSystolicBloodPressure.text == '' &&
                                  _controllerDiastolicBloodPressure.text ==
                                      '' &&
                                  _controllerPulseRate.text == '' &&
                                  _controllerHeight.text == '' &&
                                  _controllerWeight.text == '' &&
                                  _controllerWaistline.text == '' &&
                                  _controllerBloodGlucose.text == '' &&
                                  _controllerCholesterol.text == '' &&
                                  _controllerHdl.text == '' &&
                                  _controllerLdl.text == '' &&
                                  _controllerTriglyceride.text == '') {
                                _pageController.previousPage(
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.linear);
                              } else {
                                if (checkBloodPressure == false &&
                                    checkBloodLipids == false) {
                                  fetchRecord();
                                  fetchLatest();
                                  _pageController.previousPage(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      curve: Curves.linear);
                                  _controllerSystolicBloodPressure.text = "";
                                  _controllerDiastolicBloodPressure.text = "";
                                  _controllerPulseRate.text = "";
                                  _controllerHeight.text = "";
                                  _controllerWeight.text = "";
                                  _controllerWaistline.text = "";
                                  _controllerBloodGlucose.text = "";
                                  _controllerCholesterol.text = "";
                                  _controllerHdl.text = "";
                                  _controllerLdl.text = "";
                                  _controllerTriglyceride.text = "";
                                  systolicBloodPressure = 0;
                                  diastolicBloodPressure = 0;
                                  pulseRate = 0;
                                  height = 0;
                                  weight = 0;
                                  waistline = 0;
                                  bloodGlucose = 0;
                                  cholesterol = 0;
                                  hdl = 0;
                                  ldl = 0;
                                  triglyceride = 0;
                                }
                              }
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                children: [
                  Scaffold(
                    backgroundColor: Color(hexColor('#FAFCFB')),
                    body: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    selectedDate == today
                                        ? 'วันนี้'
                                        : 'วันที่ $selectedDate',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'IBMPlexSansThai',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  listOfPlan.isEmpty
                                      ? const SizedBox()
                                      : DropdownButtonHideUnderline(
                                          child: DropdownButton2<String>(
                                            isExpanded: true,
                                            hint: const Row(
                                              children: [
                                                Text(
                                                  'ทั้งหมด',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily:
                                                        'IBMPlexSansThai',
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            items: items
                                                .map((String item) =>
                                                    DropdownMenuItem<String>(
                                                      value: item,
                                                      child: Text(
                                                        item,
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontFamily:
                                                              'IBMPlexSansThai',
                                                          color: Color(hexColor(
                                                              '#000000')),
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                      ),
                                                    ))
                                                .toList(),
                                            value: selectedfilter,
                                            onChanged: (value) {
                                              setState(() {
                                                selectedfilter = value!;
                                              });
                                            },
                                            buttonStyleData: ButtonStyleData(
                                              height: 35,
                                              width: selectedfilter == "ทั้งหมด"
                                                  ? 95
                                                  : selectedfilter == "อาหาร"
                                                      ? 85
                                                      : selectedfilter ==
                                                              "ออกกำลังกาย"
                                                          ? 140
                                                          : selectedfilter ==
                                                                  "สุขภาพ"
                                                              ? 95
                                                              : 90,
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 5),
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.white
                                                        .withOpacity(.3),
                                                    blurRadius: 4.0,
                                                    spreadRadius: .1,
                                                    offset: const Offset(
                                                      2.0,
                                                      4.0,
                                                    ),
                                                  ),
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(24),
                                                border: Border.all(
                                                  color: Colors.black26,
                                                ),
                                                color: Colors.white,
                                              ),
                                              //elevation: 2,
                                            ),
                                            iconStyleData: const IconStyleData(
                                                openMenuIcon: Icon(
                                                  Icons
                                                      .keyboard_arrow_down_rounded,
                                                ),
                                                icon: Icon(
                                                  Icons
                                                      .keyboard_arrow_right_rounded,
                                                ),
                                                iconSize: 20),
                                            dropdownStyleData:
                                                DropdownStyleData(
                                              direction: DropdownDirection.left,
                                              width: 140,
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(.3),
                                                    blurRadius: 4.0,
                                                    spreadRadius: .1,
                                                    offset: const Offset(
                                                      2.0,
                                                      4.0,
                                                    ),
                                                  ),
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(0),
                                                color: Colors.white,
                                              ),
                                            ),
                                            menuItemStyleData:
                                                const MenuItemStyleData(
                                              padding:
                                                  EdgeInsets.only(left: 15),
                                              height: 40,
                                            ),
                                          ),
                                        ),
                                ]),
                            const SizedBox(
                              height: 20,
                            ),
                            listOfPlan.isEmpty
                                ? SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        SizedBox(height: 44),
                                        Image.asset(
                                            'assets/images/sceening.png'),
                                        SizedBox(height: 55),
                                        Text(
                                          'วันนี้ไม่มีแผนสุขภาพ',
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontFamily: 'IBMPlexSansThai',
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: listOfPlan.length,
                                    itemBuilder: (context, index) {
                                      if (selectedfilter == "ทั้งหมด") {
                                        return taskManagement(listOfPlan, index,
                                            checkEnable(widget.selectedDate));
                                      } else {
                                        if (selectedfilter == "ออกกำลังกาย" &&
                                            listOfPlan[index].type ==
                                                "exercise") {
                                          return taskManagement(
                                              listOfPlan,
                                              index,
                                              checkEnable(widget.selectedDate));
                                        } else if (selectedfilter == "สุขภาพ" &&
                                            listOfPlan[index].type ==
                                                "health") {
                                          return taskManagement(
                                              listOfPlan,
                                              index,
                                              checkEnable(widget.selectedDate));
                                        } else if (selectedfilter == "อาหาร" &&
                                            listOfPlan[index].type == "food") {
                                          return taskManagement(
                                              listOfPlan,
                                              index,
                                              checkEnable(widget.selectedDate));
                                        } else if (selectedfilter ==
                                                "พักผ่อน" &&
                                            listOfPlan[index].type == "rest") {
                                          return taskManagement(
                                              listOfPlan,
                                              index,
                                              checkEnable(widget.selectedDate));
                                        } else {
                                          return const SizedBox(); // Return an empty SizedBox if the condition is not met
                                        }
                                      }
                                    },
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //ค่าสุขภาพ
                  Scaffold(
                    backgroundColor: Color(hexColor('#FAFCFB')),
                    body: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.pending_actions),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'บันทึกค่าสุขภาพ',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'IBMPlexSansThai',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                selectedDate == today
                                    ? Text(
                                        timeStamp,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'IBMPlexSansThai',
                                          color: Color(hexColor('#484554')),
                                          fontWeight: FontWeight.normal,
                                        ),
                                      )
                                    : const SizedBox()
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                      width: 1,
                                      color: checkBloodPressure &&
                                              (_controllerSystolicBloodPressure
                                                          .text ==
                                                      "" ||
                                                  _controllerDiastolicBloodPressure
                                                          .text ==
                                                      "" ||
                                                  _controllerPulseRate.text ==
                                                      "")
                                          ? Color(hexColor("#FB6262"))
                                          : Color(hexColor("#FFFFFF")))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'ความดันโลหิต',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'IBMPlexSansThai',
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          systolicBloodPressure >= 120 ||
                                                  diastolicBloodPressure >=
                                                      120 //แก้
                                              ? Material(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: InkWell(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    onTap: () {
                                                      _warningPopup(
                                                          "ความดันเลือดค่อนข้างสูง");
                                                    },
                                                    child: Image.asset(
                                                      'assets/images/icon_warning_record.png',
                                                      height: 23,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox(),
                                        ],
                                      ),
                                      // Text(
                                      //   timeStamp,
                                      //   style: TextStyle(
                                      //     fontSize: 16,
                                      //     fontFamily: 'IBMPlexSansThai',
                                      //     color: Color(hexColor('#484554')),
                                      //     fontWeight: FontWeight.normal,
                                      //   ),
                                      // )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'ช่วงหัวใจบีบตัว (ตัวบน)',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'IBMPlexSansThai',
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 34,
                                        width: 125,
                                        child: TextFormField(
                                          readOnly: selectedDate == today
                                              ? false
                                              : true,
                                          controller:
                                              _controllerSystolicBloodPressure,
                                          onChanged: (value) {
                                            setState(() {
                                              systolicBloodPressure =
                                                  (value == '')
                                                      ? 0
                                                      : int.parse(value);
                                              if (_controllerSystolicBloodPressure.text == "" &&
                                                  _controllerDiastolicBloodPressure
                                                          .text ==
                                                      "" &&
                                                  _controllerPulseRate.text ==
                                                      "") {
                                                checkBloodPressure = false;
                                              } else if (!(_controllerSystolicBloodPressure.text == "" &&
                                                  _controllerDiastolicBloodPressure
                                                          .text ==
                                                      "" &&
                                                  _controllerPulseRate.text ==
                                                      "")) {
                                                checkBloodPressure = false;
                                              }
                                            });
                                          },
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 15),
                                            fillColor: Colors.white,
                                            suffixIcon: Container(
                                              padding: EdgeInsets.only(
                                                  top: 8, left: 15, right: 10),
                                              child: Text(
                                                'mmHg',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily:
                                                        'IBMPlexSansThai',
                                                    color: Color(
                                                        hexColor('#484554')),
                                                    fontWeight:
                                                        FontWeight.normal),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            hintText: checkEnable(
                                                    widget.selectedDate)
                                                ? selectedDate == today
                                                    ? systolicBloodPressureHint
                                                        .toString()
                                                    : systolicBloodPressureEnable ==
                                                            0
                                                        ? ""
                                                        : systolicBloodPressureEnable
                                                            .toString()
                                                : systolicBloodPressureEnable ==
                                                        0
                                                    ? ""
                                                    : systolicBloodPressureEnable
                                                        .toString(),
                                            hintStyle: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'IBMPlexSansThai',
                                              color: Color(hexColor('#999999')),
                                              fontWeight: FontWeight.normal,
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                borderSide: BorderSide(
                                                  color: checkBloodPressure &&
                                                          _controllerSystolicBloodPressure
                                                                  .text ==
                                                              ""
                                                      ? Color(
                                                          hexColor('#FB6262'))
                                                      : Color(
                                                          hexColor('#DBDBDB')),
                                                )),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                borderSide: BorderSide(
                                                  color: checkBloodPressure &&
                                                          _controllerSystolicBloodPressure
                                                                  .text ==
                                                              ""
                                                      ? Color(
                                                          hexColor('#FB6262'))
                                                      : Color(
                                                          hexColor('#DBDBDB')),
                                                )),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                borderSide: BorderSide(
                                                  color: checkBloodPressure &&
                                                          _controllerSystolicBloodPressure
                                                                  .text ==
                                                              ""
                                                      ? Color(
                                                          hexColor('#FB6262'))
                                                      : Color(
                                                          hexColor('#DBDBDB')),
                                                )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'ช่วงหัวใจคลายตัว (ตัวล่าง)',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'IBMPlexSansThai',
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 34,
                                        width: 125,
                                        child: TextFormField(
                                          readOnly: selectedDate == today
                                              ? false
                                              : true,
                                          controller:
                                              _controllerDiastolicBloodPressure,
                                          onChanged: (value) {
                                            setState(() {
                                              diastolicBloodPressure =
                                                  (value == '')
                                                      ? 0
                                                      : int.parse(value);
                                              if (_controllerSystolicBloodPressure.text == "" &&
                                                  _controllerDiastolicBloodPressure
                                                          .text ==
                                                      "" &&
                                                  _controllerPulseRate.text ==
                                                      "") {
                                                checkBloodPressure = false;
                                              } else if (!(_controllerSystolicBloodPressure.text == "" &&
                                                  _controllerDiastolicBloodPressure
                                                          .text ==
                                                      "" &&
                                                  _controllerPulseRate.text ==
                                                      "")) {
                                                checkBloodPressure = false;
                                              }
                                            });
                                          },
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 15),
                                            fillColor: Colors.white,
                                            suffixIcon: Container(
                                              padding: EdgeInsets.only(
                                                  top: 8, left: 15, right: 10),
                                              child: Text(
                                                'mmHg',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily:
                                                        'IBMPlexSansThai',
                                                    color: Color(
                                                        hexColor('#484554')),
                                                    fontWeight:
                                                        FontWeight.normal),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            hintText: checkEnable(
                                                    widget.selectedDate)
                                                ? selectedDate == today
                                                    ? diastolicBloodPressureHint
                                                        .toString()
                                                    : diastolicBloodPressureEnable ==
                                                            0
                                                        ? ""
                                                        : diastolicBloodPressureEnable
                                                            .toString()
                                                : diastolicBloodPressureEnable ==
                                                        0
                                                    ? ""
                                                    : diastolicBloodPressureEnable
                                                        .toString(),
                                            hintStyle: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'IBMPlexSansThai',
                                              color: Color(hexColor('#999999')),
                                              fontWeight: FontWeight.normal,
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                borderSide: BorderSide(
                                                  color: checkBloodPressure &&
                                                          _controllerDiastolicBloodPressure
                                                                  .text ==
                                                              ""
                                                      ? Color(
                                                          hexColor('#FB6262'))
                                                      : Color(
                                                          hexColor('#DBDBDB')),
                                                )),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                borderSide: BorderSide(
                                                  color: checkBloodPressure &&
                                                          _controllerDiastolicBloodPressure
                                                                  .text ==
                                                              ""
                                                      ? Color(
                                                          hexColor('#FB6262'))
                                                      : Color(
                                                          hexColor('#DBDBDB')),
                                                )),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                borderSide: BorderSide(
                                                  color: checkBloodPressure &&
                                                          _controllerDiastolicBloodPressure
                                                                  .text ==
                                                              ""
                                                      ? Color(
                                                          hexColor('#FB6262'))
                                                      : Color(
                                                          hexColor('#DBDBDB')),
                                                )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'อัตราการเต้นของหัวใจ',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'IBMPlexSansThai',
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 34,
                                        width: 125,
                                        child: TextFormField(
                                          readOnly: selectedDate == today
                                              ? false
                                              : true,
                                          controller: _controllerPulseRate,
                                          onChanged: (value) {
                                            setState(() {
                                              pulseRate = (value == '')
                                                  ? 0
                                                  : int.parse(value);
                                              if (!(_controllerSystolicBloodPressure.text == "" &&
                                                  _controllerDiastolicBloodPressure
                                                          .text ==
                                                      "" &&
                                                  _controllerPulseRate.text ==
                                                      "")) {
                                                checkBloodPressure = false;
                                              } else if (!(_controllerSystolicBloodPressure.text == "" &&
                                                  _controllerDiastolicBloodPressure
                                                          .text ==
                                                      "" &&
                                                  _controllerPulseRate.text ==
                                                      "")) {
                                                checkBloodPressure = false;
                                              }
                                            });
                                          },
                                          keyboardType: const TextInputType
                                              .numberWithOptions(
                                              signed: false, decimal: true),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 15),
                                            fillColor: Colors.white,
                                            suffixIcon: Container(
                                              padding: EdgeInsets.only(
                                                  top: 8, left: 15, right: 10),
                                              child: Text(
                                                'ครั้ง/นาที',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily:
                                                        'IBMPlexSansThai',
                                                    color: Color(
                                                        hexColor('#484554')),
                                                    fontWeight:
                                                        FontWeight.normal),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            hintText:
                                                checkEnable(widget.selectedDate)
                                                    ? selectedDate == today
                                                        ? pulseRateHint
                                                            .toString()
                                                        : pulseRateEnable == 0
                                                            ? ""
                                                            : pulseRateEnable
                                                                .toString()
                                                    : pulseRateEnable == 0
                                                        ? ""
                                                        : pulseRateEnable
                                                            .toString(),
                                            hintStyle: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'IBMPlexSansThai',
                                              color: Color(hexColor('#999999')),
                                              fontWeight: FontWeight.normal,
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                borderSide: BorderSide(
                                                  color: checkBloodPressure &&
                                                          _controllerPulseRate
                                                                  .text ==
                                                              ""
                                                      ? Color(
                                                          hexColor('#FB6262'))
                                                      : Color(
                                                          hexColor('#DBDBDB')),
                                                )),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                borderSide: BorderSide(
                                                  color: checkBloodPressure &&
                                                          _controllerPulseRate
                                                                  .text ==
                                                              ""
                                                      ? Color(
                                                          hexColor('#FB6262'))
                                                      : Color(
                                                          hexColor('#DBDBDB')),
                                                )),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                borderSide: BorderSide(
                                                  color: checkBloodPressure &&
                                                          _controllerPulseRate
                                                                  .text ==
                                                              ""
                                                      ? Color(
                                                          hexColor('#FB6262'))
                                                      : Color(
                                                          hexColor('#DBDBDB')),
                                                )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'ค่าดัชนีมวลกาย',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'IBMPlexSansThai',
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      // Text(
                                      //   '14 ส.ค. 09:45',
                                      //   style: TextStyle(
                                      //     fontSize: 16,
                                      //     fontFamily: 'IBMPlexSansThai',
                                      //     color: Color(hexColor('#484554')),
                                      //     fontWeight: FontWeight.normal,
                                      //   ),
                                      // )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  selectedDate == today
                                      ? Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'ส่วนสูง',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily:
                                                        'IBMPlexSansThai',
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 34,
                                                  width: 125,
                                                  child: TextFormField(
                                                    readOnly:
                                                        selectedDate == today
                                                            ? false
                                                            : true,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    controller:
                                                        _controllerHeight,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        height = (value == '')
                                                            ? 0
                                                            : int.parse(value);
                                                      });
                                                    },
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              left: 15),
                                                      fillColor: Colors.white,
                                                      suffixIcon: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 8,
                                                                left: 15,
                                                                right: 10),
                                                        child: Text(
                                                          'ซม.',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  'IBMPlexSansThai',
                                                              color: Color(
                                                                  hexColor(
                                                                      '#484554')),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                      hintText:
                                                          heightHint.toString(),
                                                      hintStyle: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily:
                                                            'IBMPlexSansThai',
                                                        color: Color(hexColor(
                                                            '#999999')),
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30.0),
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Color(
                                                                    hexColor(
                                                                        '#DBDBDB')),
                                                              )),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30.0),
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Color(
                                                                    hexColor(
                                                                        '#DBDBDB')),
                                                              )),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30.0),
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Color(
                                                                    hexColor(
                                                                        '#DBDBDB')),
                                                              )),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'น้ำหนัก',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily:
                                                        'IBMPlexSansThai',
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 34,
                                                  width: 125,
                                                  child: TextFormField(
                                                    readOnly:
                                                        selectedDate == today
                                                            ? false
                                                            : true,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    controller:
                                                        _controllerWeight,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        weight = (value == '')
                                                            ? 0
                                                            : int.parse(value);
                                                      });
                                                    },
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              left: 15),
                                                      fillColor: Colors.white,
                                                      suffixIcon: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 8,
                                                                left: 15,
                                                                right: 10),
                                                        child: Text(
                                                          'กก.',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  'IBMPlexSansThai',
                                                              color: Color(
                                                                  hexColor(
                                                                      '#484554')),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                      hintText:
                                                          weightHint.toString(),
                                                      hintStyle: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily:
                                                            'IBMPlexSansThai',
                                                        color: Color(hexColor(
                                                            '#999999')),
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30.0),
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Color(
                                                                    hexColor(
                                                                        '#DBDBDB')),
                                                              )),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30.0),
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Color(
                                                                    hexColor(
                                                                        '#DBDBDB')),
                                                              )),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30.0),
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Color(
                                                                    hexColor(
                                                                        '#DBDBDB')),
                                                              )),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                          ],
                                        )
                                      : Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'BMI',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily:
                                                        'IBMPlexSansThai',
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 34,
                                                  width: 125,
                                                  child: TextFormField(
                                                    readOnly: true,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    controller:
                                                        _controllerWeight,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              left: 15),
                                                      fillColor: Colors.white,
                                                      suffixIcon: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 8,
                                                                left: 15,
                                                                right: 10),
                                                        child: Text(
                                                          'กก./ม.²',
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              fontFamily:
                                                                  'IBMPlexSansThai',
                                                              color: Color(
                                                                  hexColor(
                                                                      '#484554')),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                      hintText: bmiEnable == 0.0
                                                          ? ""
                                                          : bmiEnable
                                                              .toStringAsFixed(
                                                                  2),
                                                      hintStyle: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily:
                                                            'IBMPlexSansThai',
                                                        color: Color(hexColor(
                                                            '#999999')),
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30.0),
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Color(
                                                                    hexColor(
                                                                        '#DBDBDB')),
                                                              )),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30.0),
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Color(
                                                                    hexColor(
                                                                        '#DBDBDB')),
                                                              )),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30.0),
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Color(
                                                                    hexColor(
                                                                        '#DBDBDB')),
                                                              )),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                          ],
                                        ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'รอบเอว',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'IBMPlexSansThai',
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 34,
                                        width: 125,
                                        child: TextFormField(
                                          readOnly: selectedDate == today
                                              ? false
                                              : true,
                                          controller: _controllerWaistline,
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) {
                                            setState(() {
                                              waistline = (value == '')
                                                  ? 0
                                                  : int.parse(value);
                                            });
                                          },
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 15),
                                            fillColor: Colors.white,
                                            suffixIcon: Container(
                                              padding: EdgeInsets.only(
                                                  top: 8, left: 15, right: 10),
                                              child: Text(
                                                'นิ้ว',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily:
                                                        'IBMPlexSansThai',
                                                    color: Color(
                                                        hexColor('#484554')),
                                                    fontWeight:
                                                        FontWeight.normal),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            hintText:
                                                checkEnable(widget.selectedDate)
                                                    ? selectedDate == today
                                                        ? waistlineHint
                                                            .toString()
                                                        : waistlineEnable == 0
                                                            ? ""
                                                            : waistlineEnable
                                                                .toString()
                                                    : waistlineEnable == 0
                                                        ? ""
                                                        : waistlineEnable
                                                            .toString(),
                                            hintStyle: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'IBMPlexSansThai',
                                              color: Color(hexColor('#999999')),
                                              fontWeight: FontWeight.normal,
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                borderSide: BorderSide(
                                                  color: Color(
                                                      hexColor('#DBDBDB')),
                                                )),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                borderSide: BorderSide(
                                                  color: Color(
                                                      hexColor('#DBDBDB')),
                                                )),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                borderSide: BorderSide(
                                                  color: Color(
                                                      hexColor('#DBDBDB')),
                                                )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'น้ำตาลในเลือด',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'IBMPlexSansThai',
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          bloodGlucose >= 120 //แก้
                                              ? Material(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: InkWell(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    onTap: () {
                                                      _warningPopup(
                                                          "ค่าระดับน้ำตาลค่อนข้างสูง");
                                                    },
                                                    child: Image.asset(
                                                      'assets/images/icon_warning_record.png',
                                                      height: 23,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox(),
                                        ],
                                      ),
                                      // Text(
                                      //   '14 ส.ค. 09:45',
                                      //   style: TextStyle(
                                      //     fontSize: 16,
                                      //     fontFamily: 'IBMPlexSansThai',
                                      //     color: Color(hexColor('#484554')),
                                      //     fontWeight: FontWeight.normal,
                                      //   ),
                                      // )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'ระดับน้ำตาล',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'IBMPlexSansThai',
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 34,
                                        width: 125,
                                        child: TextFormField(
                                          readOnly: selectedDate == today
                                              ? false
                                              : true,
                                          controller: _controllerBloodGlucose,
                                          onChanged: (value) {
                                            setState(() {
                                              bloodGlucose = (value == '')
                                                  ? 0
                                                  : int.parse(value);
                                            });
                                          },
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 15),
                                            fillColor: Colors.white,
                                            suffixIcon: Container(
                                              padding: EdgeInsets.only(
                                                  top: 8, left: 15, right: 10),
                                              child: Text(
                                                'mg/dL',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily:
                                                        'IBMPlexSansThai',
                                                    color: Color(
                                                        hexColor('#484554')),
                                                    fontWeight:
                                                        FontWeight.normal),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            hintText:
                                                checkEnable(widget.selectedDate)
                                                    ? selectedDate == today
                                                        ? bloodGlucoseHint
                                                            .toString()
                                                        : bloodGlucoseEnable ==
                                                                0
                                                            ? ""
                                                            : bloodGlucoseEnable
                                                                .toString()
                                                    : bloodGlucoseEnable == 0
                                                        ? ""
                                                        : bloodGlucoseEnable
                                                            .toString(),
                                            hintStyle: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'IBMPlexSansThai',
                                              color: Color(hexColor('#999999')),
                                              fontWeight: FontWeight.normal,
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                borderSide: BorderSide(
                                                  color: Color(
                                                      hexColor('#DBDBDB')),
                                                )),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                borderSide: BorderSide(
                                                  color: Color(
                                                      hexColor('#DBDBDB')),
                                                )),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                borderSide: BorderSide(
                                                  color: Color(
                                                      hexColor('#DBDBDB')),
                                                )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                      width: 1,
                                      color: checkBloodLipids &&
                                              (_controllerCholesterol.text ==
                                                      "" ||
                                                  _controllerHdl.text == "" ||
                                                  _controllerLdl.text == "" ||
                                                  _controllerTriglyceride
                                                          .text ==
                                                      "")
                                          ? Color(hexColor("#FB6262"))
                                          : Color(hexColor("#FFFFFF")))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'ไขมันในเลือด',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'IBMPlexSansThai',
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          (cholesterol >= 50 ||
                                                  (hdl >= 60) ||
                                                  ldl >= 50)
                                              ? Material(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: InkWell(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    onTap: () {
                                                      _warningPopup(
                                                          "ค่าระดับน้ำตาลค่อนข้างสูง");
                                                    },
                                                    child: Image.asset(
                                                      'assets/images/icon_warning_record.png',
                                                      height: 23,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox(),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'คอเลสเตอรอล',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'IBMPlexSansThai',
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 34,
                                        width: 125,
                                        child: TextFormField(
                                          readOnly: selectedDate == today
                                              ? false
                                              : true,
                                          controller: _controllerCholesterol,
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) {
                                            setState(() {
                                              cholesterol = (value == '')
                                                  ? 0
                                                  : int.parse(value);
                                              if (_controllerCholesterol.text ==
                                                      "" &&
                                                  _controllerHdl.text == "" &&
                                                  _controllerLdl.text == "" &&
                                                  _controllerTriglyceride
                                                          .text ==
                                                      "") {
                                                checkBloodLipids = false;
                                              } else if (!(_controllerCholesterol
                                                          .text ==
                                                      "" &&
                                                  _controllerHdl.text == "" &&
                                                  _controllerLdl.text == "" &&
                                                  _controllerTriglyceride
                                                          .text ==
                                                      "")) {
                                                checkBloodLipids = false;
                                              }
                                            });
                                          },
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 15),
                                            fillColor: Colors.white,
                                            suffixIcon: Container(
                                              padding: EdgeInsets.only(
                                                  top: 8, left: 15, right: 10),
                                              child: Text(
                                                'mg/dL',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily:
                                                        'IBMPlexSansThai',
                                                    color: Color(
                                                        hexColor('#484554')),
                                                    fontWeight:
                                                        FontWeight.normal),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            hintText:
                                                checkEnable(widget.selectedDate)
                                                    ? selectedDate == today
                                                        ? cholesterolHint
                                                            .toString()
                                                        : cholesterolEnable == 0
                                                            ? ""
                                                            : cholesterolEnable
                                                                .toString()
                                                    : cholesterolEnable == 0
                                                        ? ""
                                                        : cholesterolEnable
                                                            .toString(),
                                            hintStyle: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'IBMPlexSansThai',
                                              color: Color(hexColor('#999999')),
                                              fontWeight: FontWeight.normal,
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                borderSide: BorderSide(
                                                  color: checkBloodLipids &&
                                                          _controllerCholesterol
                                                                  .text ==
                                                              ""
                                                      ? Color(
                                                          hexColor('#FB6262'))
                                                      : Color(
                                                          hexColor('#DBDBDB')),
                                                )),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                borderSide: BorderSide(
                                                  color: checkBloodLipids &&
                                                          _controllerCholesterol
                                                                  .text ==
                                                              ""
                                                      ? Color(
                                                          hexColor('#FB6262'))
                                                      : Color(
                                                          hexColor('#DBDBDB')),
                                                )),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                borderSide: BorderSide(
                                                  color: checkBloodLipids &&
                                                          _controllerCholesterol
                                                                  .text ==
                                                              ""
                                                      ? Color(
                                                          hexColor('#FB6262'))
                                                      : Color(
                                                          hexColor('#DBDBDB')),
                                                )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'ไขมันดี (HDL)',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'IBMPlexSansThai',
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 34,
                                        width: 125,
                                        child: TextFormField(
                                          readOnly: selectedDate == today
                                              ? false
                                              : true,
                                          controller: _controllerHdl,
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) {
                                            setState(() {
                                              hdl = (value == '')
                                                  ? 0
                                                  : int.parse(value);
                                              if (_controllerCholesterol.text ==
                                                      "" &&
                                                  _controllerHdl.text == "" &&
                                                  _controllerLdl.text == "" &&
                                                  _controllerTriglyceride
                                                          .text ==
                                                      "") {
                                                checkBloodLipids = false;
                                              } else if (!(_controllerCholesterol
                                                          .text ==
                                                      "" &&
                                                  _controllerHdl.text == "" &&
                                                  _controllerLdl.text == "" &&
                                                  _controllerTriglyceride
                                                          .text ==
                                                      "")) {
                                                checkBloodLipids = false;
                                              }
                                            });
                                          },
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 15),
                                            fillColor: Colors.white,
                                            suffixIcon: Container(
                                              padding: EdgeInsets.only(
                                                  top: 8, left: 15, right: 10),
                                              child: Text(
                                                'mg/dL',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily:
                                                        'IBMPlexSansThai',
                                                    color: Color(
                                                        hexColor('#484554')),
                                                    fontWeight:
                                                        FontWeight.normal),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            hintText: checkEnable(
                                                    widget.selectedDate)
                                                ? selectedDate == today
                                                    ? hdlHint.toString()
                                                    : hdlEnable == 0
                                                        ? ""
                                                        : hdlEnable.toString()
                                                : hdlEnable == 0
                                                    ? ""
                                                    : hdlEnable.toString(),
                                            hintStyle: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'IBMPlexSansThai',
                                              color: Color(hexColor('#999999')),
                                              fontWeight: FontWeight.normal,
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                borderSide: BorderSide(
                                                  color: checkBloodLipids &&
                                                          _controllerHdl.text ==
                                                              ""
                                                      ? Color(
                                                          hexColor('#FB6262'))
                                                      : Color(
                                                          hexColor('#DBDBDB')),
                                                )),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                borderSide: BorderSide(
                                                  color: checkBloodLipids &&
                                                          _controllerHdl.text ==
                                                              ""
                                                      ? Color(
                                                          hexColor('#FB6262'))
                                                      : Color(
                                                          hexColor('#DBDBDB')),
                                                )),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                borderSide: BorderSide(
                                                  color: checkBloodLipids &&
                                                          _controllerHdl.text ==
                                                              ""
                                                      ? Color(
                                                          hexColor('#FB6262'))
                                                      : Color(
                                                          hexColor('#DBDBDB')),
                                                )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'ไขมันอันตราย (LDL)',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'IBMPlexSansThai',
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 34,
                                        width: 125,
                                        child: TextFormField(
                                          readOnly: selectedDate == today
                                              ? false
                                              : true,
                                          controller: _controllerLdl,
                                          onChanged: (value) {
                                            setState(() {
                                              ldl = (value == '')
                                                  ? 0
                                                  : int.parse(value);
                                              if (_controllerCholesterol.text ==
                                                      "" &&
                                                  _controllerHdl.text == "" &&
                                                  _controllerLdl.text == "" &&
                                                  _controllerTriglyceride
                                                          .text ==
                                                      "") {
                                                checkBloodLipids = false;
                                              } else if (!(_controllerCholesterol
                                                          .text ==
                                                      "" &&
                                                  _controllerHdl.text == "" &&
                                                  _controllerLdl.text == "" &&
                                                  _controllerTriglyceride
                                                          .text ==
                                                      "")) {
                                                checkBloodLipids = false;
                                              }
                                            });
                                          },
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 15),
                                            fillColor: Colors.white,
                                            suffixIcon: Container(
                                              padding: EdgeInsets.only(
                                                  top: 8, left: 15, right: 10),
                                              child: Text(
                                                'mg/dL',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily:
                                                        'IBMPlexSansThai',
                                                    color: Color(
                                                        hexColor('#484554')),
                                                    fontWeight:
                                                        FontWeight.normal),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            hintText: checkEnable(
                                                    widget.selectedDate)
                                                ? selectedDate == today
                                                    ? ldlHint.toString()
                                                    : ldlEnable == 0
                                                        ? ""
                                                        : ldlEnable.toString()
                                                : ldlEnable == 0
                                                    ? ""
                                                    : ldlEnable.toString(),
                                            hintStyle: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'IBMPlexSansThai',
                                              color: Color(hexColor('#999999')),
                                              fontWeight: FontWeight.normal,
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                borderSide: BorderSide(
                                                  color: checkBloodLipids &&
                                                          _controllerLdl.text ==
                                                              ""
                                                      ? Color(
                                                          hexColor('#FB6262'))
                                                      : Color(
                                                          hexColor('#DBDBDB')),
                                                )),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                borderSide: BorderSide(
                                                  color: checkBloodLipids &&
                                                          _controllerLdl.text ==
                                                              ""
                                                      ? Color(
                                                          hexColor('#FB6262'))
                                                      : Color(
                                                          hexColor('#DBDBDB')),
                                                )),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                borderSide: BorderSide(
                                                  color: checkBloodLipids &&
                                                          _controllerLdl.text ==
                                                              ""
                                                      ? Color(
                                                          hexColor('#FB6262'))
                                                      : Color(
                                                          hexColor('#DBDBDB')),
                                                )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'ไตรกลีเซอไรด์',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'IBMPlexSansThai',
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 34,
                                        width: 125,
                                        child: TextFormField(
                                          readOnly: selectedDate == today
                                              ? false
                                              : true,
                                          controller: _controllerTriglyceride,
                                          onChanged: (value) {
                                            setState(() {
                                              triglyceride = (value == '')
                                                  ? 0
                                                  : int.parse(value);
                                              if (_controllerCholesterol.text ==
                                                      "" &&
                                                  _controllerHdl.text == "" &&
                                                  _controllerLdl.text == "" &&
                                                  _controllerTriglyceride
                                                          .text ==
                                                      "") {
                                                checkBloodLipids = false;
                                              } else if (!(_controllerCholesterol
                                                          .text ==
                                                      "" &&
                                                  _controllerHdl.text == "" &&
                                                  _controllerLdl.text == "" &&
                                                  _controllerTriglyceride
                                                          .text ==
                                                      "")) {
                                                checkBloodLipids = false;
                                              }
                                            });
                                          },
                                          textAlign: TextAlign.left,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 15),
                                            fillColor: Colors.white,
                                            suffixIcon: Container(
                                              padding: EdgeInsets.only(
                                                  top: 8, left: 15, right: 10),
                                              child: Text(
                                                'mg/dL',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily:
                                                        'IBMPlexSansThai',
                                                    color: Color(
                                                        hexColor('#484554')),
                                                    fontWeight:
                                                        FontWeight.normal),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            hintText:
                                                checkEnable(widget.selectedDate)
                                                    ? selectedDate == today
                                                        ? triglycerideHint
                                                            .toString()
                                                        : triglycerideEnable ==
                                                                0
                                                            ? ""
                                                            : triglycerideEnable
                                                                .toString()
                                                    : triglycerideEnable == 0
                                                        ? ""
                                                        : triglycerideEnable
                                                            .toString(),
                                            hintStyle: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'IBMPlexSansThai',
                                              color: Color(hexColor('#999999')),
                                              fontWeight: FontWeight.normal,
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                borderSide: BorderSide(
                                                  color: checkBloodLipids &&
                                                          _controllerTriglyceride
                                                                  .text ==
                                                              ""
                                                      ? Color(
                                                          hexColor('#FB6262'))
                                                      : Color(
                                                          hexColor('#DBDBDB')),
                                                )),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                borderSide: BorderSide(
                                                  color: checkBloodLipids &&
                                                          _controllerTriglyceride
                                                                  .text ==
                                                              ""
                                                      ? Color(
                                                          hexColor('#FB6262'))
                                                      : Color(
                                                          hexColor('#DBDBDB')),
                                                )),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                borderSide: BorderSide(
                                                  color: checkBloodLipids &&
                                                          _controllerTriglyceride
                                                                  .text ==
                                                              ""
                                                      ? Color(
                                                          hexColor('#FB6262'))
                                                      : Color(
                                                          hexColor('#DBDBDB')),
                                                )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 100,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
