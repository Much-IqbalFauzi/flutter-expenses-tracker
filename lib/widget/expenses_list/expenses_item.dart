import 'package:expenzes_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpensesItem extends StatelessWidget {
  const ExpensesItem({super.key, required this.expense});

  final Expense expense;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  '\$ ${expense.amount.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcon[expense.category]),
                    const SizedBox(width: 12),
                    Text(
                      expense.formatedDate,
                      style: Theme.of(context).textTheme.titleSmall,
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
