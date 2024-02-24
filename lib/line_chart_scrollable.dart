import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class PlotData {
  List<double> result;
  double maxY;
  double minY;
  PlotData({
    required this.result,
    required this.maxY,
    required this.minY,
    required int minX,
  });
}

class LinePlot extends StatefulWidget {
  final PlotData plotData;
  const LinePlot({
    required this.plotData,
    Key? key,
  }) : super(key: key);

  @override
  _LinePlotState createState() => _LinePlotState();
}

class _LinePlotState extends State<LinePlot> {
  late double minX;
  late double maxX;
  @override
  void initState() {
    super.initState();
    minX = 0;
    maxX = widget.plotData.result.length.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: (signal) {
        if (signal is PointerScrollEvent) {
          setState(() {
            if (signal.scrollDelta.dy.isNegative) {
              minX += maxX * 0.05;
              maxX -= maxX * 0.05;
            } else {
              minX -= maxX * 0.05;
              maxX += maxX * 0.05;
            }
          });
        }
      },
      child: GestureDetector(
        onDoubleTap: () {
          setState(() {
            minX = 0;
            maxX = widget.plotData.result.length.toDouble();
          });
        },
        onHorizontalDragUpdate: (dragUpdDet) {
          setState(() {
            print(dragUpdDet.primaryDelta);
            double primDelta = dragUpdDet.primaryDelta ?? 0.0;
            if (primDelta != 0) {
              if (primDelta.isNegative) {
                minX += maxX * 0.005;
                maxX += maxX * 0.005;
              } else {
                minX -= maxX * 0.005;
                maxX -= maxX * 0.005;
              }
            }
          });
        },
        child: LineChart(
          LineChartData(
            minX: minX,
            maxX: maxX,
            maxY: widget.plotData.maxY + widget.plotData.maxY * 0.1,
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 30,
                  getTitlesWidget: bottomTitleWidgets,
                  interval: 1,
                ),
              ),
            ),
            gridData: const FlGridData(
              drawHorizontalLine: false,
            ),
            clipData: const FlClipData.all(),
            lineBarsData: [
              LineChartBarData(
                barWidth: 1,
                dotData: const FlDotData(
                  show: false,
                ),
                spots: widget.plotData.result
                    .asMap()
                    .entries
                    .map((entry) => FlSpot(entry.key.toDouble(), entry.value))
                    .toList(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 10,
      color: Colors.black54,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(meta.formattedValue, style: style),
    );
  }
}
