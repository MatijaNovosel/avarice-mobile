import 'package:finapp/models/history.dart';
import 'package:finapp/services/historyService.dart';
import 'package:finapp/widgets/charts/totalHistoryChart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ChartData extends StatefulWidget {
  @override
  _ChartDataState createState() => _ChartDataState();
}

class _ChartDataState extends State<ChartData> {
  final Future<List<HistoryModel>> _history = getTotalHistory();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([
          _history,
        ]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              {
                return Center(
                  child: SpinKitFoldingCube(
                    color: Colors.grey[500],
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
                    ],
                  );
                }
              }
          }
        });
  }
}