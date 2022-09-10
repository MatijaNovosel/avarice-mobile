import 'package:finapp/models/history.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HistoryTotalChart extends StatefulWidget {
  final List<HistoryModel> history;

  const HistoryTotalChart({
    Key? key,
    required this.history,
  }) : super(key: key);

  @override
  _HistoryTotalChartState createState() => _HistoryTotalChartState();
}

class _HistoryTotalChartState extends State<HistoryTotalChart> {
  List<Color> gradientColors = [
    Colors.purple,
    Colors.red,
  ];

  get history => widget.history;

  get maxY => widget.history
      .map(
        (x) => x.amount,
      )
      .reduce(
        (curr, next) => curr > next ? curr : next,
      );

  get minY => widget.history
      .map(
        (x) => x.amount,
      )
      .reduce(
        (curr, next) => curr < next ? curr : next,
      );

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 24,
            bottom: 12,
            right: 4,
            left: 4,
          ),
          child: LineChart(
            mainData(),
          ),
        ),
      ),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.purple,
          fitInsideHorizontally: true,
          getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
            return touchedBarSpots.map((barSpot) {
              final flSpot = barSpot;
              return LineTooltipItem(
                "${history[flSpot.x.toInt()].createdAt}\n",
                const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: flSpot.y.toStringAsFixed(2),
                    style: TextStyle(
                      color: Colors.grey[100],
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              );
            }).toList();
          },
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: false,
        drawVerticalLine: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: false,
        ),
        leftTitles: SideTitles(showTitles: false),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      lineBarsData: [
        LineChartBarData(
          spots: [
            for (int i = 0; i < history.length; i++)
              FlSpot(
                i.toDouble(),
                history[i].amount,
              ),
          ],
          isCurved: true,
          colors: gradientColors,
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: gradientColors
                .map(
                  (color) => color.withOpacity(0.3),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
