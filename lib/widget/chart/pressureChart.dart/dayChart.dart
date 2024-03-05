import 'package:flutter/material.dart';
import 'package:flutter_application_1/authProvider.dart';
import 'package:flutter_application_1/extension/Color.dart';
import 'package:flutter_application_1/response/api.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DayChart extends StatelessWidget {
  const DayChart({super.key});

  @override
  Widget build(BuildContext context) {
    return const DayChartWidget();
  }
}

class DayChartWidget extends StatefulWidget {
  const DayChartWidget({super.key});

  @override
  State<DayChartWidget> createState() => _DayChartWidgetState();
}

class _DayChartWidgetState extends State<DayChartWidget> {
  late TrackballBehavior trackballBehavior;
  List<dynamic> bloodPressure = [];
  List<PressureData> pressureDataList = [];
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  Future<void> fetchBloodPressure() async {
    try {
      String? token = Provider.of<AuthProvider>(context, listen: false).token;
      Map<String, dynamic> response = await getBloodPressure(token!);
      setState(() {
        bloodPressure = response['data']['record'];

        DateTime isNow = DateTime.now();
        var filteredData = bloodPressure
            .where((record) =>
                record["timestamp"].startsWith(dateFormat.format(isNow)))
            .toList();
        print("here $filteredData");
        pressureDataList = filteredData.map((record) {
          DateTime timestamp = DateTime.parse(record["timestamp"]);
          int systolicPressure = record["systolicBloodPressure"];
          int diastolicPressure = record["diastolicBloodPressure"];
          int pulseRate = record["pulseRate"];
          print(timestamp);
          return PressureData(
              timestamp, systolicPressure, diastolicPressure, pulseRate);
        }).toList();
        print("check ${pressureDataList.length}");
      });
    } catch (e) {
      // print('Error fetching plan: $e');
    }
  }

  @override
  void initState() {
    fetchBloodPressure();
    trackballBehavior = TrackballBehavior(
      tooltipDisplayMode: TrackballDisplayMode.floatAllPoints,
      enable: true,
      markerSettings: const TrackballMarkerSettings(
          markerVisibility: TrackballVisibilityMode.visible),
      activationMode: ActivationMode.singleTap,
      lineDashArray: const <double>[5, 5],
      tooltipSettings: const InteractiveTooltip(
        color: Color.fromARGB(156, 94, 94, 94),
        enable: true,
        format: 'series.name : point.y',
        textStyle: TextStyle(
          fontSize: 12,
          fontFamily: 'IBMPlexSansThai',
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    setState(() {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'วันนี้',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'IBMPlexSansThai',
              color: Colors.black,
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
                      dateFormat: DateFormat.Hm(),
                      labelStyle: const TextStyle(
                        fontSize: 10,
                        fontFamily: 'IBMPlexSansThai',
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      )),
                  primaryYAxis: NumericAxis(plotBands: <PlotBand>[
                    PlotBand(
                        opacity: 0.5,
                        start: 0,
                        end: 120,
                        color: Color(hexColor('#a5d1b0'))),
                    PlotBand(
                        opacity: 0.5,
                        start: 120,
                        end: 140,
                        color: Color(hexColor('#fedc86'))),
                    PlotBand(
                        opacity: 0.5,
                        start: 140,
                        color: Color(hexColor('#FFBCBC'))),
                  ]),
                  trackballBehavior: trackballBehavior,
                  series: <LineSeries<PressureData, DateTime>>[
                    LineSeries<PressureData, DateTime>(
                      dataSource: pressureDataList,
                      // emptyPointSettings: const EmptyPointSettings(
                      //   mode: EmptyPointMode
                      //       .gap, // This will create a gap for null values
                      // ),
                      markerSettings: const MarkerSettings(
                          isVisible: true, shape: DataMarkerType.diamond),
                      dataLabelSettings:
                          const DataLabelSettings(showZeroValue: true),
                      name: 'ความดันตัวบน',
                      xAxisName: 'เวลา',
                      yAxisName: 'mmHg',
                      color: Color(hexColor('#FB6262')),
                      xValueMapper: (PressureData data, _) => data.timestamp,
                      yValueMapper: (PressureData data, _) =>
                          data.systolicPressure,
                    ),
                    LineSeries<PressureData, DateTime>(
                      dataSource: pressureDataList,
                      // emptyPointSettings: const EmptyPointSettings(
                      //   mode: EmptyPointMode
                      //       .gap, // This will create a gap for null values
                      // ),
                      markerSettings: const MarkerSettings(
                          isVisible: true, shape: DataMarkerType.triangle),
                      dataLabelSettings:
                          const DataLabelSettings(showZeroValue: true),
                      name: 'ความดันตัวบน',
                      xAxisName: 'เวลา',
                      yAxisName: 'mmHg',
                      color: Color(hexColor('#0502f1')),
                      xValueMapper: (PressureData data, _) => data.timestamp,
                      yValueMapper: (PressureData data, _) =>
                          data.diastolicPressure,
                    ),
                    LineSeries<PressureData, DateTime>(
                      dataSource: pressureDataList,
                      // emptyPointSettings: const EmptyPointSettings(
                      //   mode: EmptyPointMode
                      //       .gap, // This will create a gap for null values
                      // ),
                      markerSettings: const MarkerSettings(
                          isVisible: true, shape: DataMarkerType.circle),
                      dataLabelSettings:
                          const DataLabelSettings(showZeroValue: true),
                      name: 'ความดันตัวบน',
                      xAxisName: 'เวลา',
                      yAxisName: 'mmHg',
                      color: Color(hexColor('#42884B')),
                      xValueMapper: (PressureData data, _) => data.timestamp,
                      yValueMapper: (PressureData data, _) => data.pulseRate,
                    ),
                  ]))
        ],
      ),
    );
  }
}

class PressureData {
  final DateTime timestamp;
  final int systolicPressure;
  final int diastolicPressure;
  final int pulseRate;

  PressureData(this.timestamp, this.systolicPressure, this.diastolicPressure,
      this.pulseRate);
}
