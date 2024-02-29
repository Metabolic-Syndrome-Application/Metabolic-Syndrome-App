import 'package:flutter/material.dart';
import 'package:flutter_application_1/authProvider.dart';
import 'package:flutter_application_1/response/api.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../extension/Color.dart';

class SixMonthChart extends StatelessWidget {
  const SixMonthChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SixMonthChartWidget();
  }
}

class SixMonthChartWidget extends StatefulWidget {
  const SixMonthChartWidget({super.key});

  @override
  State<SixMonthChartWidget> createState() => _SixMonthChartWidgetState();
}

class _SixMonthChartWidgetState extends State<SixMonthChartWidget> {
  late TrackballBehavior trackballBehavior;
  late TrackballBehavior trackballBehaviorWaistline;

  List<dynamic> bmiHealth = [];
  List<BmiData> bmiDataList = [];
  List<dynamic> waistlineHealth = [];
  List<WaistlineData> waistlineDataList = [];
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  String gender = '';

  Future<void> fetchProfile() async {
    String? token = Provider.of<AuthProvider>(context, listen: false).token;
    try {
      Map<String, dynamic> response = await getProfile(token!);
      setState(() {
        gender = response['data']['user']['gender'];
        print(gender);
      });
    } catch (e) {
      // print('Error fetching profile: $e');
    }
  }

  Future<void> fetchBmi() async {
    try {
      String? token = Provider.of<AuthProvider>(context, listen: false).token;
      Map<String, dynamic> response = await getBmi(token!);
      setState(() {
        bmiHealth = response['data']['record'];
        DateTime endDate = DateTime.now(); // Today's date as the end date
        DateTime startDate = endDate.subtract(Duration(days: 240));

        var filteredData = bmiHealth.where((record) {
          DateTime timestamp = DateTime.parse(record["timestamp"]);
          return timestamp.isAfter(startDate.subtract(Duration(days: 1))) &&
              timestamp.isBefore(endDate.add(Duration(days: 1)));
        }).toList();
        bmiDataList = filteredData.map((record) {
          DateTime timestamp = DateTime.parse(record["timestamp"]);
          double bmi = record["bmi"];
          return BmiData(timestamp, bmi);
        }).toList();
      });
    } catch (e) {
      // print('Error fetching plan: $e');
    }
  }

  Future<void> fetchWaistline() async {
    try {
      String? token = Provider.of<AuthProvider>(context, listen: false).token;
      Map<String, dynamic> response = await getWaistline(token!);
      setState(() {
        waistlineHealth = response['data']['record'];
        DateTime endDate = DateTime.now(); // Today's date as the end date
        DateTime startDate = endDate.subtract(Duration(days: 240));

        var filteredData = waistlineHealth.where((record) {
          DateTime timestamp = DateTime.parse(record["timestamp"]);
          return timestamp.isAfter(startDate.subtract(Duration(days: 1))) &&
              timestamp.isBefore(endDate.add(Duration(days: 1)));
        }).toList();
        waistlineDataList = filteredData.map((record) {
          DateTime timestamp = DateTime.parse(record["timestamp"]);
          int waistline = record["waistline"];
          return WaistlineData(timestamp, waistline);
        }).toList();
      });
    } catch (e) {
      // print('Error fetching plan: $e');
    }
  }

  @override
  void initState() {
    fetchBmi();
    fetchWaistline();
    fetchProfile();
    trackballBehavior = TrackballBehavior(
      tooltipDisplayMode: TrackballDisplayMode.floatAllPoints,
      enable: true,
      markerSettings: const TrackballMarkerSettings(
          markerVisibility: TrackballVisibilityMode.visible),
      activationMode: ActivationMode.singleTap,
      lineDashArray: const <double>[5, 5],
      tooltipSettings: const InteractiveTooltip(
        canShowMarker: false,
        color: Color.fromARGB(214, 94, 94, 94),
        enable: true,
        format: 'วันที่ point.x\npoint.y กก./ม.²',
        textStyle: TextStyle(
          fontSize: 12,
          fontFamily: 'IBMPlexSansThai',
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    trackballBehaviorWaistline = TrackballBehavior(
      tooltipDisplayMode: TrackballDisplayMode.floatAllPoints,
      enable: true,
      markerSettings: const TrackballMarkerSettings(
          markerVisibility: TrackballVisibilityMode.visible),
      activationMode: ActivationMode.singleTap,
      lineDashArray: const <double>[5, 5],
      tooltipSettings: const InteractiveTooltip(
        canShowMarker: false,
        color: Color.fromARGB(214, 94, 94, 94),
        enable: true,
        format: 'วันที่ point.x\npoint.y นิ้ว',
        textStyle: TextStyle(
          fontSize: 12,
          fontFamily: 'IBMPlexSansThai',
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'กราฟ BMI',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'IBMPlexSansThai',
              color: Color(hexColor('#7B7B7B')),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            '6 เดือน',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'IBMPlexSansThai',
              color: Color(hexColor('#7B7B7B')),
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
              height: 300,
              child: SfCartesianChart(
                  borderColor: Colors.red,
                  primaryXAxis: DateTimeAxis(
                      dateFormat: DateFormat('d MMM', 'th'),
                      labelStyle: const TextStyle(
                        fontSize: 10,
                        fontFamily: 'IBMPlexSansThai',
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      )),
                  primaryYAxis: NumericAxis(
                      // minimum: 0,
                      // maximum: 40,
                      plotBands: <PlotBand>[
                        PlotBand(
                            opacity: 0.5,
                            start: 18.6,
                            end: 22.99999999,
                            color: Color(hexColor('#a5d1b0'))),
                        PlotBand(
                            opacity: 0.5,
                            start: 23,
                            end: 24.99999,
                            color: Color(hexColor('#fedc86'))),
                        PlotBand(
                            opacity: 0.5,
                            start: 25,
                            end: 29.9,
                            color: Color(hexColor('#FFBCBC'))),
                        PlotBand(
                            opacity: 0.5,
                            start: 30,
                            color: Color(hexColor('#A6CFFF'))),
                      ]),
                  trackballBehavior: trackballBehavior,
                  series: <LineSeries<BmiData, DateTime>>[
                    LineSeries<BmiData, DateTime>(
                      dataSource: bmiDataList,
                      emptyPointSettings: EmptyPointSettings(
                        mode: EmptyPointMode
                            .gap, // This will create a gap for null values
                      ),
                      markerSettings: const MarkerSettings(
                          isVisible: true, shape: DataMarkerType.circle),
                      dataLabelSettings:
                          const DataLabelSettings(showZeroValue: true),
                      name: 'ค่าดัชนีมวลกาย',
                      xAxisName: 'เวลา',
                      yAxisName: 'กก./ม.²',
                      color: Color(hexColor('#2F4EF1')),
                      xValueMapper: (BmiData data, _) => data.timestamp,
                      yValueMapper: (BmiData data, _) => data.bmi,
                    ),
                  ])),
          const SizedBox(
            height: 20,
          ),
          Text(
            'กราฟรอบเอว',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'IBMPlexSansThai',
              color: Color(hexColor('#7B7B7B')),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            '6 เดือน',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'IBMPlexSansThai',
              color: Color(hexColor('#7B7B7B')),
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
              height: 300,
              child: SfCartesianChart(
                  borderColor: Colors.red,
                  primaryXAxis: DateTimeAxis(
                      dateFormat: DateFormat('d MMM', 'th'),
                      labelStyle: const TextStyle(
                        fontSize: 10,
                        fontFamily: 'IBMPlexSansThai',
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      )),
                  primaryYAxis: NumericAxis(
                      // minimum: 0,
                      // maximum: 40,
                      plotBands: <PlotBand>[
                        PlotBand(
                            opacity: 0.5,
                            end: gender == 'หญิง'
                                ? 32
                                : gender == 'ชาย'
                                    ? 36
                                    : 0,
                            color: Color(hexColor('#a5d1b0'))),
                        PlotBand(
                            opacity: 0.5,
                            start: gender == 'หญิง'
                                ? 32
                                : gender == 'ชาย'
                                    ? 36
                                    : 0,
                            color: Color(hexColor('#FFBCBC'))),
                      ]),
                  trackballBehavior: trackballBehaviorWaistline,
                  series: <LineSeries<WaistlineData, DateTime>>[
                    LineSeries<WaistlineData, DateTime>(
                      dataSource: waistlineDataList,
                      emptyPointSettings: EmptyPointSettings(
                        mode: EmptyPointMode.gap,
                      ),
                      markerSettings: const MarkerSettings(
                          isVisible: true, shape: DataMarkerType.triangle),
                      dataLabelSettings:
                          const DataLabelSettings(showZeroValue: true),
                      name: 'ค่าดัชนีมวลกาย',
                      xAxisName: 'เวลา',
                      yAxisName: 'นิ้ว',
                      color: Color(hexColor('#2F4EF1')),
                      xValueMapper: (WaistlineData data, _) => data.timestamp,
                      yValueMapper: (WaistlineData data, _) => data.waistline,
                    ),
                  ]))
        ],
      ),
    );
  }
}

class BmiData {
  final DateTime timestamp;
  final double bmi;

  BmiData(
    this.timestamp,
    this.bmi,
  );
}

class WaistlineData {
  final DateTime timestamp;
  final int waistline;

  WaistlineData(
    this.timestamp,
    this.waistline,
  );
}
