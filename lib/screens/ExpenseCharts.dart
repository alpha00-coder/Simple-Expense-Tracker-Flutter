import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
              if (snapshot.hasData) {
                List<ExpenseModel> list = snapshot.data!;
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
                            arcRendererDecorators: [charts.ArcLabelDecorator()],
                          )),
                    ),
                  ]),
                );
              } else {
                return Container();
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
