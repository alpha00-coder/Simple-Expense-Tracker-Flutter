import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:untitled/Utils.dart';
import 'package:untitled/database/DbExecuter.dart';

import '../models/ExpenseModel.dart';

class ExpenseCharts extends StatefulWidget {
  ExpenseCharts(this.animate);

  bool animate = false;

  @override
  State<StatefulWidget> createState() {
    return _ExpenseCharts();
  }
}

class _ExpenseCharts extends State<ExpenseCharts> {
  final _dbExecutor = DbExecuter();

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
              List<ExpenseModel> list = snapshot.data!;
              if (list.isNotEmpty) {
                return const Center(child: CircularProgressIndicator());
              } else {
                var length = list.length;
                if (length == 0) {
                  return const SafeArea(
                    child: Center(
                      child: Text("No Data Found.....!"),
                    ),
                  );
                } else {
                  ///** else has some data  **///
                  return Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(children: [
                      Expanded(
                        child: charts.BarChart(
                          returnListExpense(list),
                          animate: widget.animate,
                          barRendererDecorator:
                              charts.BarLabelDecorator<String>(),
                          domainAxis: const charts.OrdinalAxisSpec(),
                        ),
                      ),
                      const SizedBox(height: 25),
                      Expanded(
                        child: charts.PieChart(returnListExpense(list),
                            animate: widget.animate,
                            defaultRenderer: charts.ArcRendererConfig(
                              arcWidth: 60,
                              arcRendererDecorators: [
                                charts.ArcLabelDecorator()
                              ],
                            )),
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
