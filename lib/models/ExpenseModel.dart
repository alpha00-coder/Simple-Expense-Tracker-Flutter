class ExpenseModel {
  var expenseId;
  var expenseDateCreated;
  var expenseName;
  var expenseAmount;

  ExpenseModel();

  // var currentDate=DateFormat("yyy-MM-dd hh:mm:ss").format(DateTime.now());
  ExpenseModel.insert(
      this.expenseName, this.expenseDateCreated, this.expenseAmount);

  ExpenseModel.updateWithId(
      this.expenseId, this.expenseName, this.expenseAmount);

  @override
  String toString() {
    return 'ExpenseModel{expenseId: $expenseId, expenseDateCreated: $expenseDateCreated, expenseName: $expenseName, expenseAmount: $expenseAmount}';
  }

  ExpenseModel.fromMap(Map<String, dynamic> map)
      : expenseId = map["expenseId"],
        expenseDateCreated = map["expenseDateCreated"],
        expenseName = map["expenseName"],
        expenseAmount = map["expenseAmount"];

  Map<String, Object?> toMap() {
    return {
      'expenseId': expenseId,
      'expenseDateCreated': expenseDateCreated,
      'expenseName': expenseName,
      'expenseAmount': expenseAmount,
    };
  }
}
