import 'package:finapp/models/history.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'indicator.dart';

class TagPercentagesPieChart extends StatefulWidget {
  final List<TagPercentageModel> tagPercentages;

  const TagPercentagesPieChart({
    Key key,
    this.tagPercentages,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => TagPercentagesPieChartState();
}

class TagPercentagesPieChartState extends State<TagPercentagesPieChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.8,
      child: Row(
        children: <Widget>[
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                    setState(() {
                      final desiredTouch = pieTouchResponse.touchInput is! PointerExitEvent && pieTouchResponse.touchInput is! PointerUpEvent;
                      if (desiredTouch && pieTouchResponse.touchedSection != null) {
                        touchedIndex = pieTouchResponse.touchedSection.touchedSectionIndex;
                      } else {
                        touchedIndex = -1;
                      }
                    });
                  }),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 35,
                  sections: showingSections(),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              left: 12,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.tagPercentages.map<Widget>((x) {
                  return Column(
                    children: [
                      Indicator(
                        color: x.color,
                        text: x.description,
                        isSquare: true,
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(
            width: 28,
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(widget.tagPercentages.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;

      return PieChartSectionData(
        color: widget.tagPercentages[i].color,
        value: num.parse(
          (widget.tagPercentages[i].percentage * 100).toStringAsFixed(2),
        ),
        title: (widget.tagPercentages[i].percentage * 100).toStringAsFixed(2) + "%",
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
        ),
      );
    });
  }
}
