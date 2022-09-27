import 'package:flutter/material.dart';
import 'package:untitled/database/DbExecuter.dart';
import 'package:untitled/models/ExpenseModel.dart';
import 'package:untitled/screens/AddBill.dart';

class AddProducts extends StatefulWidget {
  const AddProducts({super.key});

  @override
  State<StatefulWidget> createState() => _AddProducts();
}

class _AddProducts extends State<AddProducts> {

  final _dbExecutor = DbExecuter();
  var expenseCat = "",
      expenseName = "",
      expenseFrequency = "",
      expenseAmount = "";
  var products = <ExpenseModel>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddBill()));
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: products.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
                child: ListTile(
                    leading:
                        const Icon(Icons.add_task),
                    title: Text(products[index].expenseName),
                    trailing: Text(products[index].expenseAmount)));
          }),
    );
  }

  void addItems(String expenseCat, String expenseName, String expenseFrequency,
      String expenseAmount) {
    _dbExecutor.insertProduct(ExpenseModel.insert(
        expenseCat, expenseName, expenseAmount));
  }
}
