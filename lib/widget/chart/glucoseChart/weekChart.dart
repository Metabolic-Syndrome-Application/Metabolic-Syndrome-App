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
  late TrackballBehavior trackballBehaviorWaistline;

  List<dynamic> glucoseHealth = [];
  List<GlucoseData> glucoseDataList = [];

  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  String gender = '';

  Future<void> fetchGlucose() async {
    try {
      String? token = Provider.of<AuthProvider>(context, listen: false).token;
      Map<String, dynamic> response = await getBloodGlucose(token!);
      setState(() {
        glucoseHealth = response['data']['record'];
        DateTime endDate = DateTime.now(); // Today's date as the end date
        DateTime startDate = endDate.subtract(const Duration(days: 7));
        var filteredData = glucoseHealth.where((record) {
          DateTime timestamp = DateTime.parse(record["timestamp"]);
          return timestamp.isAfter(startDate.subtract(Duration(days: 1))) &&
              timestamp.isBefore(endDate.add(Duration(days: 1)));
        }).toList();
        glucoseDataList = filteredData.map((record) {
          DateTime timestamp = DateTime.parse(record["timestamp"]);
          int glucose = record["bloodGlucose"];
          return GlucoseData(timestamp, glucose);
        }).toList();
      });
    } catch (e) {
      // print('Error fetching plan: $e');
    }
  }

  @override
  void initState() {
    fetchGlucose();
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
        format: 'วันที่ point.x\npoint.y mg/dL',
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
            'วันนี้',
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
                            start: 70,
                            end: 100,
                            color: Color(hexColor('#a5d1b0'))),
                        PlotBand(
                            opacity: 0.5,
                            start: 100,
                            end: 125,
                            color: Color(hexColor('#fedc86'))),
                        PlotBand(
                            opacity: 0.5,
                            start: 125,
                            color: Color(hexColor('#FFBCBC'))),
                      ]),
                  trackballBehavior: trackballBehavior,
                  series: <LineSeries<GlucoseData, DateTime>>[
                    LineSeries<GlucoseData, DateTime>(
                      dataSource: glucoseDataList,
                      emptyPointSettings: EmptyPointSettings(
                        mode: EmptyPointMode.gap,
                      ),
                      dataLabelSettings:
                          const DataLabelSettings(showZeroValue: true),
                      name: 'ค่าดัชนีมวลกาย',
                      xAxisName: 'เวลา',
                      yAxisName: 'นิ้ว',
                      color: Color(hexColor('#2F4EF1')),
                      xValueMapper: (GlucoseData data, _) => data.timestamp,
                      yValueMapper: (GlucoseData data, _) => data.glucose,
                    ),
                  ]))
        ],
      ),
    );
  }
}

class GlucoseData {
  final DateTime timestamp;
  final int glucose;

  GlucoseData(
    this.timestamp,
    this.glucose,
  );
}
