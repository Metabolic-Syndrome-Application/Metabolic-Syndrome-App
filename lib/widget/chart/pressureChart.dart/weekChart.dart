import 'package:flutter/material.dart';
import 'package:flutter_application_1/authProvider.dart';
import 'package:flutter_application_1/response/api.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../extension/Color.dart';

void main() {
  runApp(WeekChart());
}

class WeekChart extends StatelessWidget {
  const WeekChart({super.key});

  @override
  Widget build(BuildContext context) {
    return WeekChartWidget();
  }
}

class WeekChartWidget extends StatefulWidget {
  const WeekChartWidget({super.key});

  @override
  State<WeekChartWidget> createState() => _WeekChartWidgetState();
}

class _WeekChartWidgetState extends State<WeekChartWidget> {
  late TrackballBehavior trackballBehavior;
  List<dynamic> bloodPressure = [];
  List<PressureData> pressureDataList = [];

  Future<void> fetchRandomQuiz() async {
    try {
      String? token = Provider.of<AuthProvider>(context, listen: false).token;
      Map<String, dynamic> response = await getBloodPressure(token!);
      setState(() {
        bloodPressure = response['data']['record'];
        DateTime endDate = DateTime.now(); // Today's date as the end date
        DateTime startDate = endDate.subtract(Duration(
            days: 7)); // Subtracting 7 days to get the start date (1 week ago)

        var filteredData = bloodPressure.where((record) {
          DateTime timestamp = DateTime.parse(record["timestamp"]);
          return timestamp.isAfter(startDate.subtract(Duration(days: 1))) &&
              timestamp.isBefore(endDate.add(Duration(days: 1)));
        }).toList();

        pressureDataList = filteredData.map((record) {
          DateTime timestamp = DateTime.parse(record["timestamp"]);
          int systolicPressure = record["systolicBloodPressure"];
          int diastolicPressure = record["diastolicBloodPressure"];
          int pulseRate = record["pulseRate"];
          return PressureData(
              timestamp, systolicPressure, diastolicPressure, pulseRate);
        }).toList();
      });
    } catch (e) {
      // Handle errors appropriately
    }
  }

  @override
  void initState() {
    fetchRandomQuiz();
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
            '1 อาทิตย์',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'IBMPlexSansThai',
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
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
                      emptyPointSettings: EmptyPointSettings(
                        mode: EmptyPointMode
                            .gap, // This will create a gap for null values
                      ),
                      // markerSettings: MarkerSettings(
                      //     isVisible: true, shape: DataMarkerType.diamond),
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
                      emptyPointSettings: EmptyPointSettings(
                        mode: EmptyPointMode
                            .gap, // This will create a gap for null values
                      ),
                      // markerSettings: MarkerSettings(
                      //     isVisible: true, shape: DataMarkerType.triangle),
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
                      emptyPointSettings: EmptyPointSettings(
                        mode: EmptyPointMode
                            .gap, // This will create a gap for null values
                      ),
                      // markerSettings: MarkerSettings(
                      //     isVisible: true, shape: DataMarkerType.circle),
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
