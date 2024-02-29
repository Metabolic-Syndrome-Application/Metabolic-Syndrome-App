import 'package:flutter/material.dart';
import 'package:flutter_application_1/authProvider.dart';
import 'package:flutter_application_1/response/api.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../extension/Color.dart';

void main() {
  runApp(MonthChart());
}

class MonthChart extends StatelessWidget {
  const MonthChart({super.key});

  @override
  Widget build(BuildContext context) {
    return MonthChartWidget();
  }
}

class MonthChartWidget extends StatefulWidget {
  const MonthChartWidget({super.key});

  @override
  State<MonthChartWidget> createState() => _MonthChartWidgetState();
}

class _MonthChartWidgetState extends State<MonthChartWidget> {
  late TrackballBehavior trackballBehavior;
  List<dynamic> bloodLipid = [];
  List<LipidData> lipidDataList = [];
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  Future<void> fetchBloodLipid() async {
    try {
      String? token = Provider.of<AuthProvider>(context, listen: false).token;
      Map<String, dynamic> response = await getBloodLipid(token!);
      setState(() {
        bloodLipid = response['data']['record'];
        DateTime endDate = DateTime.now(); // Today's date as the end date
        DateTime startDate = endDate.subtract(const Duration(days: 30));

        var filteredData = bloodLipid.where((record) {
          DateTime timestamp = DateTime.parse(record["timestamp"]);
          return timestamp
                  .isAfter(startDate.subtract(const Duration(days: 1))) &&
              timestamp.isBefore(endDate.add(const Duration(days: 1)));
        }).toList();
        lipidDataList = filteredData.map((record) {
          DateTime timestamp = DateTime.parse(record["timestamp"]);
          int ldl = record["ldl"];
          int hdl = record["hdl"];
          int triglyceride = record["triglyceride"];
          return LipidData(timestamp, ldl, hdl, triglyceride);
        }).toList();
      });
    } catch (e) {
      // print('Error fetching plan: $e');
    }
  }

  @override
  void initState() {
    fetchBloodLipid();
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
            'วันนี้',
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
                  trackballBehavior: trackballBehavior,
                  series: <LineSeries<LipidData, DateTime>>[
                    LineSeries<LipidData, DateTime>(
                      dataSource: lipidDataList,
                      emptyPointSettings: EmptyPointSettings(
                        mode: EmptyPointMode
                            .gap, // This will create a gap for null values
                      ),
                      dataLabelSettings:
                          const DataLabelSettings(showZeroValue: true),
                      name: 'ไขมันดี',
                      xAxisName: 'เวลา',
                      yAxisName: 'mg/dL',
                      color: Color(hexColor('#FB6262')),
                      xValueMapper: (LipidData data, _) => data.timestamp,
                      yValueMapper: (LipidData data, _) => data.ldl,
                    ),
                    LineSeries<LipidData, DateTime>(
                      dataSource: lipidDataList,
                      emptyPointSettings: EmptyPointSettings(
                        mode: EmptyPointMode
                            .gap, // This will create a gap for null values
                      ),
                      dataLabelSettings:
                          const DataLabelSettings(showZeroValue: true),
                      name: 'ไขมันอันตราย',
                      xAxisName: 'เวลา',
                      yAxisName: 'mg/dL',
                      color: Color(hexColor('#0502f1')),
                      xValueMapper: (LipidData data, _) => data.timestamp,
                      yValueMapper: (LipidData data, _) => data.hdl,
                    ),
                    LineSeries<LipidData, DateTime>(
                      dataSource: lipidDataList,
                      emptyPointSettings: EmptyPointSettings(
                        mode: EmptyPointMode
                            .gap, // This will create a gap for null values
                      ),
                      dataLabelSettings:
                          const DataLabelSettings(showZeroValue: true),
                      name: 'ไตรกลีเซอไรด์',
                      xAxisName: 'เวลา',
                      yAxisName: 'mg/dL',
                      color: Color(hexColor('#42884B')),
                      xValueMapper: (LipidData data, _) => data.timestamp,
                      yValueMapper: (LipidData data, _) => data.triglyceride,
                    ),
                  ]))
        ],
      ),
    );
  }
}

class LipidData {
  final DateTime timestamp;
  final int ldl;
  final int hdl;
  final int triglyceride;

  LipidData(this.timestamp, this.ldl, this.hdl, this.triglyceride);
}
