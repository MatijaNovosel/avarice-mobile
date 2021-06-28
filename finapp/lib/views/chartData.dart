import 'package:finapp/models/history.dart';
import 'package:finapp/services/historyService.dart';
import 'package:finapp/widgets/charts/tagPercentagesPieChart.dart';
import 'package:finapp/widgets/charts/totalHistoryChart.dart';
import 'package:finapp/widgets/spendingByTagList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ChartData extends StatefulWidget {
  @override
  _ChartDataState createState() => _ChartDataState();
}

class _ChartDataState extends State<ChartData> {
  final Future<List<HistoryModel>> _history = getTotalHistory();
  final Future<List<TagPercentageModel>> _tagPercentages = getTagPercentages();
  final Future<List<SpendingByTagModel>> _spendingByTag = getSpendingByTag();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([_history, _tagPercentages, _spendingByTag]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              {
                return Center(
                  child: SpinKitFoldingCube(
                    color: Colors.orange,
                    size: 50.0,
                  ),
                );
              }
            default:
              {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  List<HistoryModel> history = snapshot.data[0];
                  List<TagPercentageModel> tagPercentages = snapshot.data[1];
                  List<SpendingByTagModel> spendingByTag = snapshot.data[2];

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Text(
                          "Total amount",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey[500],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: HistoryTotalChart(history: history),
                      ),
                      Text(
                        "Spending percentages",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey[500],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: TagPercentagesPieChart(
                          tagPercentages: tagPercentages,
                        ),
                      ),
                      Text(
                        "Spending by tag",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey[500],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: SpendingByTagList(
                            spendingByTag: spendingByTag,
                          ),
                        ),
                      )
                    ],
                  );
                }
              }
          }
        });
  }
}
