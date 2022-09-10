import 'dart:async';

import 'package:finapp/helpers/helpers.dart';
import 'package:finapp/models/transaction.dart';
import 'package:finapp/services/transactionService.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InfiniteScroll extends StatefulWidget {
  @override
  _InfiniteScrollState createState() => new _InfiniteScrollState();
}

class _InfiniteScrollState extends State<InfiniteScroll> {
  List<Transaction> _data = [];
  late Future<List<Transaction>> _future;
  int _currentPage = 0, _limit = 15;
  ScrollController _controller = ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);

  @override
  void initState() {
    _controller.addListener(() {
      var isEnd = _controller.offset == _controller.position.maxScrollExtent;
      if (isEnd)
        setState(() {
          _future = loadData();
        });
    });

    _future = loadData();
    super.initState();
  }

  Future<List<Transaction>> loadData() async {
    var transactions = await getTransactions(_currentPage, _limit);

    _data.addAll(transactions);
    _currentPage += _limit;

    return _data;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: FutureBuilder(
        future: _future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<Transaction> transactions = snapshot.data;
            return Container(
              margin: EdgeInsets.all(8),
              child: Card(
                child: ListView.separated(
                  controller: _controller,
                  separatorBuilder: (context, i) {
                    return Divider(
                      height: 0.1,
                    );
                  },
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateTime.parse(transactions[index].createdAt).day.toString(),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            DateFormat('MMM')
                                .format(
                                  DateTime.parse(transactions[index].createdAt),
                                )
                                .toUpperCase(),
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: Text(
                              '${transactions[index].description}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[400],
                              ),
                            ),
                          ),
                          Text(
                            (transactions[index].expense ? "-" : "+") + '${formatHrk(transactions[index].amount)}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: transactions[index].expense == false ? Colors.green[300] : null,
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
          return LinearProgressIndicator();
        },
      ),
    );
  }
}
