import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartBar extends StatelessWidget {
  const LineChartBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: 200,
          child: LineChart(mainData())),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      rangeAnnotations: RangeAnnotations(
        verticalRangeAnnotations: [
          VerticalRangeAnnotation(
            x1: 2,
            x2: 5,
            color: Colors.blue.withOpacity(0.2),
          ),
          VerticalRangeAnnotation(
            x1: 8,
            x2: 9,
            color: Colors.blue.withOpacity(0.2),
          ),
          VerticalRangeAnnotation(
            x1: 11,
            x2: 16,
            color: Colors.grey.withOpacity(0.2),
          ),
        ],
        // horizontalRangeAnnotations: [
        //   HorizontalRangeAnnotation(
        //     y1: 1,
        //     y2: 3,
        //     color: Colors.green.withOpacity(0.3),
        //   ),
        // ],
      ),
      // uncomment to see ExtraLines with RangeAnnotations

      gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          drawHorizontalLine: false,
          verticalInterval: 1,
          getDrawingVerticalLine: (value) {
            return const FlLine(
              color: Colors.blueGrey,
              strokeWidth: 0.4,
              dashArray: [2, 4],
            );
          }),
      titlesData: const FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 4,
          ),
        ),
        leftTitles: AxisTitles(
          drawBelowEverything: true,
          sideTitles: SideTitles(),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      lineTouchData: LineTouchData(
        getTouchLineEnd: (data, index) => double.infinity,
        getTouchedSpotIndicator:
            (LineChartBarData barData, List<int> spotIndexes) {
          return spotIndexes.map((spotIndex) {
            return TouchedSpotIndicatorData(
              const FlLine(color: Colors.orange, strokeWidth: 3),
              FlDotData(
                getDotPainter: (spot, percent, barData, index) =>
                    FlDotCirclePainter(
                  radius: 8,
                  color: Colors.orange,
                ),
              ),
            );
          }).toList();
        },
        touchTooltipData: const LineTouchTooltipData(
          maxContentWidth: 500,
          tooltipBgColor: Colors.blue,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(
          color: Colors.black,
        ),
      ),
      minX: 0,
      maxX: 25,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            // FlSpot(0, 5),
            // FlSpot(2, 1),
            // FlSpot(4.9, 5),
            // FlSpot(6.8, 5),
            // FlSpot(7.5, 3.5),
            // FlSpot.nullSpot,
            // FlSpot(7.5, 2),
            // FlSpot(8, 1),
            // FlSpot(10, 2),
            // FlSpot(11, 2.5),
            // FlSpot(16, 2.5),
          ],
          dashArray: [10, 6],
          isCurved: false,
          color: Colors.transparent,
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
        ),
      ],
    );
  }
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
