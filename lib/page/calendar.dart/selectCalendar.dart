import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/extension/Color.dart';
import 'package:flutter_application_1/page/calendar.dart/calendar.dart';
import 'package:intl/intl.dart';

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
  int initial = 1;
  late final CustomSegmentedController<int> controller;
  String? selectedPlanType = 'ทั้งหมด';
  int pageChanged = 1;
  DateFormat f = DateFormat('dd/MM/yyyy');

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

  @override
  Widget build(BuildContext context) {
    String selectedDate = f.format(widget.selectedDate).toString();
    String today = f.format(DateTime.now()).toString();
    bool isToday;
    final List<String> planType = ['ทั้งหมด', 'อาหาร', 'ออกกำลังกาย', 'อื่นๆ'];

    if (today == selectedDate) {
      isToday = true;
    } else {
      isToday = false;
    }

    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
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
                        initialValue: initial,
                        //controller: controller,
                        children: {
                          1: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: const Text(
                                'พฤติกรรม',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'IBMPlexSansThai',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                          2: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'ค่าสุขภาพ',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'IBMPlexSansThai',
                                  color: Colors.black,
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
                          if (v == 2 && _pageController.hasClients) {
                            _pageController.nextPage(
                                duration: Duration(milliseconds: 200),
                                curve: Curves.easeIn);
                          } else {
                            _pageController.previousPage(
                                duration: Duration(milliseconds: 200),
                                curve: Curves.linear);
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
                physics: new NeverScrollableScrollPhysics(),
                // pageSnapping: true,
                controller: _pageController,
                children: [
                  //พฤติกรรม
                  !widget.hasPlan
                      ? Scaffold(
                          backgroundColor: Color(hexColor('#FAFCFB')),
                          body: SingleChildScrollView(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 27,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 20),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              isToday
                                                  ? 'วันนี้'
                                                  : 'วันที่ $selectedDate',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: 'IBMPlexSansThai',
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            DropdownButtonHideUnderline(
                                              child: DropdownButton2<String>(
                                                isExpanded: true,
                                                hint: const Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 4,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        'เลือกเพศของคุณ',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontFamily:
                                                              'IBMPlexSansThai',
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                items: planType
                                                    .map((String planType) =>
                                                        DropdownMenuItem<
                                                            String>(
                                                          value: planType,
                                                          child: Text(
                                                            planType,
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'IBMPlexSansThai',
                                                              color: Color(
                                                                  hexColor(
                                                                      '#3D3D3D')),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            ),
                                                          ),
                                                        ))
                                                    .toList(),
                                                value: selectedPlanType,
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    selectedPlanType = value;
                                                  });
                                                },
                                                buttonStyleData:
                                                    ButtonStyleData(
                                                  height: 47,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 15),
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
                                                        BorderRadius.circular(
                                                            24),
                                                    border: Border.all(
                                                      color: Colors.black26,
                                                    ),
                                                    color: Colors.white,
                                                  ),
                                                  elevation: 2,
                                                ),
                                                iconStyleData:
                                                    const IconStyleData(
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
                                                        BorderRadius.circular(
                                                            0),
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                menuItemStyleData:
                                                    const MenuItemStyleData(
                                                  height: 40,
                                                  padding: EdgeInsets.only(
                                                      left: 14, right: 14),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                                alignment: Alignment.topCenter,
                                                child: Checkbox(
                                                  checkColor: Colors.white,
                                                  fillColor:
                                                      MaterialStateProperty
                                                          .resolveWith(
                                                              getColor),
                                                  value: isChecked2,
                                                  onChanged: (bool? value) {
                                                    setState(() {
                                                      isChecked2 = !isChecked2;
                                                    });
                                                    if (isChecked2 &&
                                                        isChecked1) {}
                                                  },
                                                )),
                                            Expanded(
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    color: Color(
                                                        hexColor('#F2F2F2')),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Text(
                                                  'detailshhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily:
                                                        'IBMPlexSansThai',
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                                alignment: Alignment.topCenter,
                                                child: Checkbox(
                                                  checkColor: Colors.white,
                                                  fillColor:
                                                      MaterialStateProperty
                                                          .resolveWith(
                                                              getColor),
                                                  value: isChecked2,
                                                  onChanged: (bool? value) {
                                                    setState(() {
                                                      isChecked2 = !isChecked2;
                                                    });
                                                    if (isChecked2 &&
                                                        isChecked1) {}
                                                  },
                                                )),
                                            Expanded(
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    color: Color(
                                                        hexColor('#F2F2F2')),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Text(
                                                  'detailshhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily:
                                                        'IBMPlexSansThai',
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Image.asset(
                                            'assets/images/foodPicture.png')
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 20),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                                'assets/images/exercise_note_icon.png'),
                                            SizedBox(width: 10),
                                            Text(
                                              'ออกกำลังกาย',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: 'IBMPlexSansThai',
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                                alignment: Alignment.topCenter,
                                                child: Checkbox(
                                                  checkColor: Colors.white,
                                                  fillColor:
                                                      MaterialStateProperty
                                                          .resolveWith(
                                                              getColor),
                                                  value: isChecked2,
                                                  onChanged: (bool? value) {
                                                    setState(() {
                                                      isChecked2 = !isChecked2;
                                                    });
                                                    if (isChecked2 &&
                                                        isChecked1) {}
                                                  },
                                                )),
                                            Expanded(
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    color: Color(
                                                        hexColor('#F2F2F2')),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Text(
                                                  'detailshhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily:
                                                        'IBMPlexSansThai',
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                                alignment: Alignment.topCenter,
                                                child: Checkbox(
                                                  checkColor: Colors.white,
                                                  fillColor:
                                                      MaterialStateProperty
                                                          .resolveWith(
                                                              getColor),
                                                  value: isChecked2,
                                                  onChanged: (bool? value) {
                                                    setState(() {
                                                      isChecked2 = !isChecked2;
                                                    });
                                                    if (isChecked2 &&
                                                        isChecked1) {}
                                                  },
                                                )),
                                            Expanded(
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    color: Color(
                                                        hexColor('#F2F2F2')),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Text(
                                                  'detailshhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily:
                                                        'IBMPlexSansThai',
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Image.asset(
                                            'assets/images/exercisePicture.png')
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
                        )
                      : Scaffold(
                          body: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 44,
                                ),
                                Image.asset('assets/images/sceening.png'),
                                SizedBox(
                                  height: 55,
                                ),
                                Text(
                                  'วันนี้ไม่มีเเผนสุขภาพ',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'IBMPlexSansThai',
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                                )
                              ],
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
                                )
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
                                  borderRadius: BorderRadius.circular(30)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                      Text(
                                        '14 ส.ค. 09:45',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'IBMPlexSansThai',
                                          color: Color(hexColor('#484554')),
                                          fontWeight: FontWeight.normal,
                                        ),
                                      )
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
                                          keyboardType: TextInputType.number,
                                          //  textDirection: TextDirection.rtl,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 20),
                                            fillColor: Colors.white,
                                            suffixIcon: Container(
                                              padding: EdgeInsets.only(
                                                  top: 4, left: 15, right: 20),
                                              child: Text(
                                                'mmHg',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily:
                                                        'IBMPlexSansThai',
                                                    color: Color(
                                                        hexColor('#484554')),
                                                    fontWeight:
                                                        FontWeight.normal),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(24)),
                                                borderSide: BorderSide(
                                                  color: Color(
                                                      hexColor('#E9E9E9')),
                                                  width: 1,
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
                                          keyboardType: TextInputType.number,
                                          //  textDirection: TextDirection.rtl,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 20),
                                            fillColor: Colors.white,
                                            suffixIcon: Container(
                                              padding: EdgeInsets.only(
                                                  top: 4, left: 15, right: 20),
                                              child: Text(
                                                'mmHg',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily:
                                                        'IBMPlexSansThai',
                                                    color: Color(
                                                        hexColor('#484554')),
                                                    fontWeight:
                                                        FontWeight.normal),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(24)),
                                                borderSide: BorderSide(
                                                  color: Color(
                                                      hexColor('#E9E9E9')),
                                                  width: 1,
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
                                          keyboardType: TextInputType.number,
                                          //       textDirection: TextDirection.rtl,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 20),
                                            fillColor: Colors.white,
                                            suffixIcon: Container(
                                              padding: EdgeInsets.only(
                                                  top: 4, left: 15, right: 20),
                                              child: Text(
                                                'ครั้ง/นาที',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily:
                                                        'IBMPlexSansThai',
                                                    color: Color(
                                                        hexColor('#484554')),
                                                    fontWeight:
                                                        FontWeight.normal),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(24)),
                                                borderSide: BorderSide(
                                                  color: Color(
                                                      hexColor('#E9E9E9')),
                                                  width: 1,
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
                                      Text(
                                        'ค่าดัชนีมวลกาย',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'IBMPlexSansThai',
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '14 ส.ค. 09:45',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'IBMPlexSansThai',
                                          color: Color(hexColor('#484554')),
                                          fontWeight: FontWeight.normal,
                                        ),
                                      )
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
                                        'ส่วนสูง',
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
                                          keyboardType: TextInputType.number,
                                          //       textDirection: TextDirection.rtl,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 20),
                                            fillColor: Colors.white,
                                            suffixIcon: Container(
                                              padding: EdgeInsets.only(
                                                  top: 4, left: 15, right: 20),
                                              child: Text(
                                                '167' + ' ซม.',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily:
                                                        'IBMPlexSansThai',
                                                    color: Color(
                                                        hexColor('#484554')),
                                                    fontWeight:
                                                        FontWeight.normal),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(24)),
                                                borderSide: BorderSide(
                                                  color: Color(
                                                      hexColor('#E9E9E9')),
                                                  width: 1,
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
                                        'น้ำหนัก',
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
                                          keyboardType: TextInputType.number,
                                          //                    textDirection: TextDirection.rtl,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 20),
                                            fillColor: Colors.white,
                                            suffixIcon: Container(
                                              padding: EdgeInsets.only(
                                                  top: 4, left: 15, right: 20),
                                              child: Text(
                                                'กก.',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily:
                                                        'IBMPlexSansThai',
                                                    color: Color(
                                                        hexColor('#484554')),
                                                    fontWeight:
                                                        FontWeight.normal),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(24)),
                                                borderSide: BorderSide(
                                                  color: Color(
                                                      hexColor('#E9E9E9')),
                                                  width: 1,
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
                                          keyboardType: TextInputType.number,
                                          //          textDirection: TextDirection.rtl,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 20),
                                            fillColor: Colors.white,
                                            suffixIcon: Container(
                                              padding: EdgeInsets.only(
                                                  top: 4, left: 15, right: 20),
                                              child: Text(
                                                'นิ้ว',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily:
                                                        'IBMPlexSansThai',
                                                    color: Color(
                                                        hexColor('#484554')),
                                                    fontWeight:
                                                        FontWeight.normal),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(24)),
                                                borderSide: BorderSide(
                                                  color: Color(
                                                      hexColor('#E9E9E9')),
                                                  width: 1,
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
                                      Text(
                                        'น้ำตาลในเลือด',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'IBMPlexSansThai',
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '14 ส.ค. 09:45',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'IBMPlexSansThai',
                                          color: Color(hexColor('#484554')),
                                          fontWeight: FontWeight.normal,
                                        ),
                                      )
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
                                          keyboardType: TextInputType.number,
                                          //       textDirection: TextDirection.rtl,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 20),
                                            fillColor: Colors.white,
                                            suffixIcon: Container(
                                              padding: EdgeInsets.only(
                                                  top: 4, left: 15, right: 20),
                                              child: Text(
                                                'mg/dL',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily:
                                                        'IBMPlexSansThai',
                                                    color: Color(
                                                        hexColor('#484554')),
                                                    fontWeight:
                                                        FontWeight.normal),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(24)),
                                                borderSide: BorderSide(
                                                  color: Color(
                                                      hexColor('#E9E9E9')),
                                                  width: 1,
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


// class SelectCalendar extends StatefulWidget {
//   
// }
