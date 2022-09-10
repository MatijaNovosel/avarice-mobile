import 'package:finapp/helpers/helpers.dart';
import 'package:finapp/models/history/spendingByTagModel/spendingByTagModel.dart';
import 'package:finapp/services/historyService.dart';
import 'package:flutter/material.dart';

class _SpendingByTagListState extends State<SpendingByTagList> {
  @override
  void initState() {
    getSpendingByTag();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      child: Card(
        child: ListView.separated(
          separatorBuilder: (context, i) {
            return Divider(
              height: 0.1,
            );
          },
          itemCount: widget.spendingByTag.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text(
                      '${widget.spendingByTag[index].description}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                  Text(
                    "${formatHrk(widget.spendingByTag[index].amount)}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class SpendingByTagList extends StatefulWidget {
  final List<SpendingByTagModel> spendingByTag;

  const SpendingByTagList({
    Key? key,
    required this.spendingByTag,
  }) : super(key: key);

  @override
  _SpendingByTagListState createState() => _SpendingByTagListState();
}
