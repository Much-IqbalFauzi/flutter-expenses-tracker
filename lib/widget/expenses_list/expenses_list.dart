import 'package:expenzes_tracker/models/expense.dart';
import 'package:expenzes_tracker/widget/expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.listExpenses, required this.onRemove});

  final List<Expense> listExpenses;

  final void Function(Expense expense) onRemove;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listExpenses.length,
      itemBuilder: (ctx, idx) => Dismissible(
        background: Container(
          color: Colors.green.shade300,
          margin: EdgeInsets.symmetric(
              vertical: Theme.of(context).cardTheme.margin!.vertical),
        ),
        key: ValueKey(listExpenses[idx]),
        onDismissed: (direction) {
          if (direction == DismissDirection.startToEnd) {
            onRemove(listExpenses[idx]);
          }
        },
        direction: DismissDirection.startToEnd,
        child: ExpensesItem(expense: listExpenses[idx]),
      ),
    );
  }
}
