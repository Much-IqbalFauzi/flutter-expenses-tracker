import 'dart:io';

import 'package:expenzes_tracker/models/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpensesAdd extends StatefulWidget {
  const ExpensesAdd({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<StatefulWidget> createState() {
    return _ExpensesAdd();
  }
}

class _ExpensesAdd extends State<ExpensesAdd> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategoty = Category.travel;

  void _showDatePicker() async {
    final now = DateTime.now();
    // 1 year ago
    final firsDate = DateTime(now.year - 1, now.month, now.day);
    final choosenDate = await showDatePicker(
        context: context, initialDate: now, firstDate: firsDate, lastDate: now);
    print(choosenDate);

    setState(() {
      _selectedDate = choosenDate;
    });
  }

  void _showMyDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: const Text('Invalid Input'),
              content: const Text('Please make sure you entered valid value!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Okay"),
                )
              ],
            );
          });
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text('Please make sure you entered valid value!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Okay"),
            )
          ],
        ),
      );
    }
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final isAmountError = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        isAmountError ||
        _selectedDate == null) {
      _showMyDialog();
      return;
    }

    widget.onAddExpense(
      Expense(
          title: _titleController.text,
          amount: enteredAmount,
          date: _selectedDate!,
          category: _selectedCategoty),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        return Padding(
          padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace + 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _titleController,
                          maxLength: 50,
                          keyboardType: TextInputType.text,
                          style: Theme.of(context).textTheme.titleSmall,
                          decoration: InputDecoration(
                            focusColor: Colors.white,
                            label: Text(
                              'Title',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: TextField(
                          style: Theme.of(context).textTheme.titleSmall,
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              label: Text(
                                'Amount',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              prefixText: '\$ '),
                        ),
                      ),
                    ],
                  )
                else
                  TextField(
                    controller: _titleController,
                    maxLength: 50,
                    keyboardType: TextInputType.text,
                    style: Theme.of(context).textTheme.titleSmall,
                    decoration: InputDecoration(
                      focusColor: Colors.white,
                      label: Text(
                        'Title',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ),
                if (width >= 600)
                  Row(
                    children: [
                      DropdownButton(
                        value: _selectedCategoty,
                        items: Category.values
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(e.name.toString().toUpperCase()),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedCategoty = value;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _selectedDate != null
                                  ? formatter.format(_selectedDate!)
                                  : 'Select Date!',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            IconButton(
                              onPressed: _showDatePicker,
                              icon: const Icon(Icons.calendar_month),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          style: Theme.of(context).textTheme.titleSmall,
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              label: Text(
                                'Amount',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              prefixText: '\$ '),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _selectedDate != null
                                  ? formatter.format(_selectedDate!)
                                  : 'Select Date!',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            IconButton(
                              onPressed: _showDatePicker,
                              icon: const Icon(Icons.calendar_month),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 16),
                if (width >= 600)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Cancel",
                            style: Theme.of(context).textTheme.titleSmall,
                          )),
                      ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: Text(
                            "Save Expense",
                            style: Theme.of(context).textTheme.titleSmall,
                          ))
                    ],
                  )
                else
                  Row(
                    children: [
                      DropdownButton(
                        value: _selectedCategoty,
                        items: Category.values
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(e.name.toString().toUpperCase()),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedCategoty = value;
                          });
                        },
                      ),
                      const Spacer(),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Cancel",
                            style: Theme.of(context).textTheme.titleSmall,
                          )),
                      ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: Text(
                            "Save Expense",
                            style: Theme.of(context).textTheme.titleSmall,
                          ))
                    ],
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}
