import 'package:expenzes_tracker/widget/chart/chart.dart';
import 'package:expenzes_tracker/widget/expenses_add.dart';
import 'package:expenzes_tracker/widget/expenses_list/expenses_list.dart';
import 'package:expenzes_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'One',
        amount: 21.00,
        category: Category.food,
        date: DateTime.now()),
    Expense(
        title: 'Two',
        amount: 15.00,
        category: Category.food,
        date: DateTime.now()),
    Expense(
        title: 'Three',
        amount: 31.00,
        category: Category.food,
        date: DateTime.now()),
  ];

  void _showModalAddExpenses() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) => ExpensesAdd(onAddExpense: _addExpense));
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIdx = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Success delete expense!",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIdx, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final newWidth = MediaQuery.of(context).size.width;

    Widget mainContent = Center(
      child: Text(
        'There is no expenses found!',
        style: Theme.of(context).textTheme.titleSmall,
      ),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
          listExpenses: _registeredExpenses, onRemove: _removeExpense);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Expense Tracker!",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        actions: [
          IconButton(
            onPressed: _showModalAddExpenses,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: newWidth < 600
          ? Column(
              children: [
                Text(
                  'The Chart',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Chart(expenses: _registeredExpenses),
                Expanded(child: mainContent),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Chart(expenses: _registeredExpenses),
                ),
                Expanded(child: mainContent),
              ],
            ),
    );
  }
}
