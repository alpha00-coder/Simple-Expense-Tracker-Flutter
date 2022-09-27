import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:untitled/database/DbExecuter.dart';
import 'package:untitled/models/ExpenseModel.dart';

class ViewExpenses extends StatefulWidget {
  const ViewExpenses({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ViewProducts();
  }
}

class _ViewProducts extends State<ViewExpenses> {
  final _dbExecutor = DbExecuter();
  final TextEditingController _expNameController = TextEditingController();
  final TextEditingController _expAmountController = TextEditingController();

  var expenseCat = "",
      expenseName = "",
      expenseFrequency = "",
      expenseAmount = "";

  Future<List<ExpenseModel>> retrieveExpenses() {
    return _dbExecutor.retrieveExpenses();
  }

  List<ExpenseModel>? listItems = [];
  late Future<List<ExpenseModel>> productsList;

  @override
  void initState() {
    productsList = _dbExecutor.retrieveExpenses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<List<ExpenseModel>>(
          future: retrieveExpenses(),
          builder: (context, snapshot) {
            listItems = snapshot.data;
            if (listItems == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              var length = listItems!.length;
              if (length == 0) {
                return const SafeArea(
                  child: Center(
                    child: Text("No Data Found.....!"),
                  ),
                );
              } else {
                ///** else has some data  **///
                return ListView.builder(
                    itemCount: listItems?.length,
                    itemBuilder: (BuildContext context, index) => ListTile(
                          title: Text(listItems![index].expenseName),
                          subtitle:  Text(listItems![index].expenseDateCreated),
                          leading: CircleAvatar(
                            backgroundColor: Colors.black,
                            child: Text(listItems![index].expenseAmount,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                )),
                          ),
                          trailing: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _dbExecutor.deleteUser(
                                            listItems![index].expenseId);
                                        listItems!.removeAt(index);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                              'Successfully deleted a Product!'),
                                        ));
                                      });
                                    },
                                    icon: Image.asset('assets/delete.png',
                                        width: 20, height: 20)),
                                const SizedBox(width: 5),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _displayUpdateItemsDialog(
                                            listItems![index], context);
                                      });
                                      Fluttertoast.showToast(
                                          msg: listItems![index].toString());
                                    },
                                    icon: Image.asset('assets/edit.png',
                                        width: 20, height: 20)),
                              ],
                            ),
                          ),
                        ));
              }
            }
          }),
    );
  }

  Future<void> _displayUpdateItemsDialog(
      ExpenseModel product, BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Update an item?'),
            content: SingleChildScrollView(
                child: ListBody(
              children: [
                TextField(
                  onChanged: (value) {
                    expenseName = value;
                  },
                  controller: _expNameController,
                  decoration: const InputDecoration(hintText: "Expense Name"),
                ),
                TextField(
                  onChanged: (value) {
                    expenseAmount = value;
                  },
                  controller: _expAmountController,
                  decoration: const InputDecoration(hintText: "Expense Amount"),
                ),
              ],
            )),
            actions: <Widget>[
              TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  setState(() {
                    _updateData(product);
                    Fluttertoast.showToast(msg: product.toString());
                    Navigator.pop(context);
                  });
                },
              ),
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }

  void _updateData(ExpenseModel expense) async {
    await _dbExecutor.update(ExpenseModel.updateWithId(
        expense.expenseId, expenseName, expenseAmount));
  }
}
