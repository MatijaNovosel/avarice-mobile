import 'package:finapp/helpers/helpers.dart';
import 'package:finapp/models/history.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryTotalChart extends StatefulWidget {
  final List<HistoryModel> history;

  const HistoryTotalChart({
    Key key,
    this.history,
  }) : super(key: key);

  @override
  _HistoryTotalChartState createState() => _HistoryTotalChartState();
}

class _HistoryTotalChartState extends State<HistoryTotalChart> {
  List<Color> gradientColors = [
    Colors.red,
    Colors.amber,
  ];

  get history => widget.history;

  get minY => widget.history
      .map(
        (x) => x.amount,
      )
      .reduce(
        (curr, next) => curr < next ? curr : next,
      );

  get maxY => widget.history
      .map(
        (x) => x.amount,
      )
      .reduce(
        (curr, next) => curr > next ? curr : next,
      );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 2,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: LineChart(
                mainData(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData mainData() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.orange,
          getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
            return touchedBarSpots.map((barSpot) {
              final flSpot = barSpot;
              return LineTooltipItem(
                "${formatDateToCroatian(history[flSpot.x.toInt()].createdAt)}\n",
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
        leftTitles: SideTitles(
          getTitles: (value) {
            return NumberFormat.compactCurrency(
              decimalDigits: 2,
              symbol: '',
            ).format(value);
          },
          rotateAngle: -10,
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          margin: 15,
          reservedSize: 25,
          interval: 100,
        ),
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
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
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
