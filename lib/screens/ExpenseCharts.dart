import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:untitled/Utils.dart';
import 'package:untitled/database/DbExecuter.dart';

import '../models/ExpenseModel.dart';

class ExpenseCharts extends StatefulWidget {
  ExpenseCharts(this.animate);

  final bool animate;

  @override
  State<StatefulWidget> createState() {
    return _ExpenseCharts();
  }
}

class _ExpenseCharts extends State<ExpenseCharts> {
  final _dbExecutor = DbExecuter();
  List<ExpenseModel>? list = [];

  @override
  void initState() {
    super.initState();
  }

  Future<List<ExpenseModel>> retrieveExpenses() {
    return _dbExecutor.retrieveExpenses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<ExpenseModel>>(
            future: retrieveExpenses(),
            builder: (context, snapshot) {
              list = snapshot.data;
              if (list == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                var length = list!.length;
                if (length == 0) {
                  return const SafeArea(
                    child: Center(
                      child: Text("No Data Found.....!"),
                    ),
                  );
                } else {
                  ///** else has some data  **///
                  return Container(
                    padding: const EdgeInsets.all(25),
                    child: Column(children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          child: const Text("BY DATE")),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0),
                                topLeft: Radius.circular(10.0),
                                bottomLeft: Radius.circular(10.0)),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: charts.BarChart(
                            returnListExpense(list!),
                            animate:true,
                            barRendererDecorator:
                                charts.BarLabelDecorator<String>(),
                            domainAxis: const charts.OrdinalAxisSpec(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      Container(
                          alignment: Alignment.centerLeft,
                          child: const Text("BY CATEGORY")),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0),
                                topLeft: Radius.circular(10.0),
                                bottomLeft: Radius.circular(10.0)),
                          ),
                          child: charts.PieChart(returnListExpense(list!),
                              animate: true,
                              defaultRenderer: charts.ArcRendererConfig(
                                arcWidth: 60,
                                arcRendererDecorators: [
                                  charts.ArcLabelDecorator()
                                ],
                              )),
                        ),
                      ),
                    ]),
                  );
                }
              }
            }));
  }

  List<charts.Series<ExpenseModel, String>> returnListExpense(
      List<ExpenseModel> listExpenses) {
    return [
      charts.Series(
        id: 'Expenses',
        data: listExpenses,
        domainFn: (ExpenseModel expense, _) =>
            Utils.getYearDate(expense.expenseDateCreated).toString(),
        measureFn: (ExpenseModel expense, _) =>
            int.parse(expense.expenseAmount),
      )
    ];
  }
}
