import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Utils.dart';
import '../database/DbExecuter.dart';
import '../models/ExpenseModel.dart';

class MainScreenDashboard extends StatefulWidget {
  const MainScreenDashboard({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MainScreenDashboard();
  }
}

class _MainScreenDashboard extends State<MainScreenDashboard> {
  final TextEditingController _expenseNameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _expDatePickerController =
      TextEditingController();

  var expDatePicker = "";
  final _dbExecutor = DbExecuter();
  var expName = "";
  var expAmount = "";

  void addItems(String expenseName, String expenseAmount, expDatePicker) {
    _dbExecutor.insertProduct(
        ExpenseModel.insert(expenseName, expDatePicker, expenseAmount));
  }

  @override
  void initState() {
    _expenseNameController.text = currentDate();
    super.initState();
  }

  String currentDate() {
    var now = DateTime.now();
    var formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 3.0,
        mainAxisSpacing: 4.0,
        children: List.generate(Utils.list.length, (index) {
          return Center(
            child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.all(15),
                          child: Container(
                            padding: const EdgeInsets.all(35),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
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
                                                borderSide:
                                                    BorderSide(width: 1)),
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
                                                borderSide:
                                                    BorderSide(width: 1)),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        TextField(
                                            onChanged: (value) {
                                              expDatePicker = value;
                                            },
                                            controller:
                                                _expDatePickerController,
                                            decoration: const InputDecoration(
                                                icon:
                                                    Icon(Icons.calendar_today),
                                                //icon of text field
                                                labelText:
                                                    "Enter Date" //label text of field
                                                ),
                                            readOnly: true,
                                            onTap: () async {
                                              DateTime? pickedDate =
                                                  await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime(1950),
                                                      //DateTime.now() - not to allow to choose before today.
                                                      lastDate: DateTime(2100));

                                              if (pickedDate != null) {
                                                print(
                                                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                                String formattedDate =
                                                    DateFormat('yyyy-MM-dd')
                                                        .format(pickedDate);
                                                print(
                                                    formattedDate); //formatted date output using intl package =>  2021-03-16
                                                setState(() {
                                                  _expDatePickerController
                                                          .text =
                                                      formattedDate; //set output date to TextField value.
                                                });
                                              } else {}
                                            }),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              addItems(expName, expAmount,
                                                  expDatePicker);
                                              Navigator.pop(context);
                                            });
                                          },
                                          child: const Text("Add Bill",
                                              style: TextStyle(fontSize: 18)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                          ),
                        );
                      });
                },
                child: CardItems(key: null, index: index)),
          );
        }),
      ),
    );
  }
}

class CardItems extends StatelessWidget {
  const CardItems({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: Icon(Utils.list[index].icon, size: 50)),
            SizedBox(
              width: 100,
              height: 2,
              child: Container(
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(Utils.list[index].title),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
