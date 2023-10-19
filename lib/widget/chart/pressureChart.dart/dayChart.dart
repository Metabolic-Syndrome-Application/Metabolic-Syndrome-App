import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../extension/Color.dart';

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

  @override
  void initState() {
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
                  primaryXAxis: CategoryAxis(
                      labelStyle: const TextStyle(
                    fontSize: 10,
                    fontFamily: 'IBMPlexSansThai',
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  )),
                  // primaryYAxis: NumericAxis(plotBands: <PlotBand>[
                  //   PlotBand(
                  //       start: 0, end: 10, color: Color(hexColor('#FFE9C9'))),
                  //   PlotBand(
                  //       start: 30, end: 180, color: Color(hexColor('#FFBCBC'))),
                  // ]),
                  trackballBehavior: trackballBehavior,
                  series: <LineSeries<PressureData, double>>[
                    LineSeries<PressureData, double>(
                        dataLabelSettings: const DataLabelSettings(),
                        name: 'ความดันตัวบน',
                        xAxisName: 'เวลา',
                        yAxisName: 'mmHg',
                        color: Color(hexColor('#FB6262')),
                        dataSource: <PressureData>[
                          PressureData(1, 0, 20, 30, 40),
                          PressureData(2, 20, 20, 20, 20),
                          PressureData(3, 20, 10, 30, 20),
                          PressureData(4, 10, 20, 30, 10),
                          PressureData(5, 0, 20, 30, 40),
                          PressureData(6, 20, 20, 20, 20),
                          PressureData(7, 20, 10, 30, 20),
                          PressureData(8, 10, 20, 30, 10),
                        ],
                        xValueMapper: (PressureData data, _) => data.day,
                        yValueMapper: (PressureData data, _) =>
                            data.systolicPressure),
                    LineSeries<PressureData, double>(
                        name: 'ความดันตัวล่าง',
                        xAxisName: 'เวลา',
                        yAxisName: 'mmHg',
                        color: Color(hexColor('#2F4EF1')),
                        dataSource: <PressureData>[
                          PressureData(1, 0, 20, 30, 40),
                          PressureData(2, 20, 20, 20, 20),
                          PressureData(3, 20, 10, 30, 20),
                          PressureData(4, 10, 20, 30, 10),
                          PressureData(5, 0, 20, 30, 40),
                          PressureData(6, 20, 20, 20, 20),
                          PressureData(7, 20, 10, 30, 20),
                          PressureData(8, 10, 20, 30, 10),
                        ],
                        xValueMapper: (PressureData data, _) => data.day,
                        yValueMapper: (PressureData data, _) =>
                            data.diastolicPressure),
                    LineSeries<PressureData, double>(
                        name: 'ชีพจร',
                        xAxisName: 'เวลา',
                        yAxisName: 'ครั้ง/นาที',
                        color: Color(hexColor('#42884B')),
                        dataSource: <PressureData>[
                          PressureData(1, 0, 20, 30, 40),
                          PressureData(2, 20, 20, 20, 20),
                          PressureData(3, 20, 10, 30, 20),
                          PressureData(4, 10, 20, 30, 10),
                          PressureData(5, 0, 20, 30, 40),
                          PressureData(6, 20, 20, 20, 20),
                          PressureData(7, 20, 10, 30, 20),
                          PressureData(8, 10, 20, 30, 10),
                        ],
                        xValueMapper: (PressureData data, _) => data.day,
                        yValueMapper: (PressureData data, _) => data.pulseRate),
                    LineSeries<PressureData, double>(
                        name: 'Pulse Pressure',
                        xAxisName: 'เวลา',
                        yAxisName: 'mmHg',
                        color: Color(hexColor('#FFC556')),
                        dataSource: <PressureData>[
                          PressureData(1, 0, 20, 30, 40),
                          PressureData(2, 20, 20, 20, 20),
                          PressureData(3, 20, 10, 30, 20),
                          PressureData(4, 10, 20, 30, 10),
                          PressureData(5, 0, 20, 30, 40),
                          PressureData(6, 20, 20, 20, 20),
                          PressureData(7, 20, 10, 30, 20),
                          PressureData(8, 10, 20, 30, 10),
                        ],
                        xValueMapper: (PressureData data, _) => data.day,
                        yValueMapper: (PressureData data, _) =>
                            data.pulsePressure),
                  ]))
        ],
      ),
    );
  }
}

class PressureData {
  PressureData(this.day, this.systolicPressure, this.diastolicPressure,
      this.pulseRate, this.pulsePressure);
  final double day;
  final double systolicPressure;
  final double diastolicPressure;
  final double pulseRate;
  final double pulsePressure;
}
