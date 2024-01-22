import 'package:expence_tracker/widgets/add_expence.dart';
import 'package:expence_tracker/widgets/expence_chart.dart';
import 'package:expence_tracker/widgets/expence_list.dart';
import 'package:flutter/material.dart';

import 'models/expence_data.dart';

class ExpenceScreen extends StatefulWidget {
  const ExpenceScreen(this.themeChane, {super.key});
  final void Function(Color val) themeChane;
  @override
  State<ExpenceScreen> createState() => _ExpenceScreenState();
}

class _ExpenceScreenState extends State<ExpenceScreen> {
  final List<ExpenceData> _registeredExpence = [
    ExpenceData(
        title: 'Potato',
        amount: 12.35,
        dateTime: DateTime.now(),
        category: Category.food),
    ExpenceData(
        title: 'Basket',
        amount: 65,
        dateTime: DateTime.now(),
        category: Category.travel),
    ExpenceData(
        title: 'Gamepad',
        amount: 32.99,
        dateTime: DateTime.now(),
        category: Category.hobby),
  ];

  List<double>? _chartData() {
    final int chartNum = Category.values.length;
    List<double> amountPercent = [];
    for (int x = 0; x < chartNum; x++) {
      amountPercent.add(0);
    }
    for (int i = 0; i < _registeredExpence.length; i++) {
      for (int j = 0; j < chartNum; j++) {
        if (_registeredExpence[i].category == Category.values[j]) {
          amountPercent[j] = amountPercent[j] + _registeredExpence[i].amount;
        }
      }
    }
    return amountPercent;
  }

  void _openAdding(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return AddExpence(_addexpence);
        });
  }

  void _addexpence(ExpenceData expenceData) {
    setState(() {
      _registeredExpence.add(expenceData);
    });
  }

  void _removeexpence(ExpenceData expenceData) {
    final expenseIndex = _registeredExpence.indexOf(expenceData);
    setState(() {
      _registeredExpence.remove(expenceData);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("Expense Deleted."),
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
          label: "undo",
          onPressed: () {
            setState(() {
              _registeredExpence.insert(expenseIndex, expenceData);
            });
          }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    Widget mainContent = const Center(
      child: Text("No Expense. Please add one."),
    );
    if (_registeredExpence.isEmpty) {
      setState(() {
        mainContent = const Center(
          child: Text("No Expense. Please add one."),
        );
      });
    } else {
      setState(() {
        mainContent = ExpenceList(
          expenceData: _registeredExpence,
          remove: _removeexpence,
        );
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        centerTitle: true,
        leading: DropdownButton(
            alignment: AlignmentDirectional.center,
            isExpanded: true,
            iconSize: 20,
            hint: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  Icon(Icons.color_lens_sharp,
                      color: Theme.of(context).colorScheme.onPrimary),
                ],
              ),
            ),
            items: const [
              DropdownMenuItem(
                value: Colors.redAccent,
                child: Icon(
                  Icons.color_lens_sharp,
                  color: Colors.redAccent,
                ),
              ),
              DropdownMenuItem(
                value: Colors.blue,
                child: Icon(
                  Icons.color_lens_sharp,
                  color: Colors.blue,
                ),
              ),
              DropdownMenuItem(
                value: Colors.purple,
                child: Icon(
                  Icons.color_lens_sharp,
                  color: Colors.purple,
                ),
              ),
              DropdownMenuItem(
                value: Colors.black,
                child: Icon(
                  Icons.color_lens_sharp,
                  color: Colors.black,
                ),
              ),
            ],
            onChanged: (value) {
              widget.themeChane(value!);
            }),
        actions: [
          IconButton(
            onPressed: () {
              _openAdding(context);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: h >= w
          ? Column(
              children: [
                _chartData() == null
                    ? const Placeholder()
                    : ExpenceChart(_chartData),
                mainContent,
              ],
            )
          : Row(
              children: [
                ExpenceChart(_chartData),
                mainContent,
              ],
            ),
    );
  }
}
