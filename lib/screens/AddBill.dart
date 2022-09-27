import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../database/DbExecuter.dart';
import '../models/ExpenseModel.dart';

class AddBill extends StatefulWidget {
  const AddBill({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AddBill();
  }
}

class _AddBill extends State<AddBill> {
  final TextEditingController _expenseNameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  final _dbExecutor = DbExecuter();
  var expName = "";
  var expAmount = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("Add Bill"),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(35),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Card(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const Text("Expense Name"),
                    TextField(
                      onChanged: (value) {
                        expName = value;
                      },
                      controller: _expenseNameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1)),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text("Amount"),
                    TextField(
                      onChanged: (value) {
                        expAmount = value;
                      },
                      controller: _amountController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1)),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          addItems(expName, expDatePicker, expAmount);
                          Navigator.pop(context);
                        });
                      },
                      child: const Text("Add Bill",
                          style: TextStyle(fontSize: 18)),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ));
  }

  void addItems(
      String expenseName, String expDatePicker, String expenseAmount) {
    // var now = DateTime.now();
    // var formatter = DateFormat('yyyy-MM-dd');
    // String formattedDate = formatter.format(now);
    _dbExecutor.insertProduct(
        ExpenseModel.insert(expenseName, expDatePicker, expenseAmount));
  }
}
