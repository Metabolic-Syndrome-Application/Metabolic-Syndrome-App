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
    return DayChartWidget();
  }
}

class DayChartWidget extends StatefulWidget {
  const DayChartWidget({super.key});

  @override
  State<DayChartWidget> createState() => _DayChartWidgetState();
}

class _DayChartWidgetState extends State<DayChartWidget> {
  late TrackballBehavior trackballBehavior;
  late TrackballBehavior trackballBehaviorWaistline;

  List<dynamic> glucoseHealth = [];
  List<GlucoseData> glucoseDataList = [];

  DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  Future<void> fetchGlucose() async {
    try {
      String? token = Provider.of<AuthProvider>(context, listen: false).token;
      Map<String, dynamic> response = await getBloodGlucose(token!);
      setState(() {
        glucoseHealth = response['data']['record'];
        DateTime isNow = DateTime.now();
        var filteredData = glucoseHealth
            .where((record) =>
                record["timestamp"].startsWith(dateFormat.format(isNow)))
            .toList();
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
        format: 'เวลา point.x น.\npoint.y mg/dL',
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
                      xValueMapper: (GlucoseData data, _) => data.timestamp,
                      yValueMapper: (GlucoseData data, _) => data.glucose,
                    ),
                  ])),
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
