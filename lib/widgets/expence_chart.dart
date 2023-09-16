import 'package:d_chart/commons/data_model.dart';
import 'package:d_chart/ordinal/bar.dart';
import 'package:expence_tracker/models/expence_data.dart';
import 'package:flutter/material.dart';
import 'package:d_chart/d_chart.dart';

class ExpenceChart extends StatefulWidget {
  const ExpenceChart(this.data, {Key? key}) : super(key: key);
  final List<double>? Function() data;
  @override
  State<ExpenceChart> createState() => _ExpenceChartState();
}

class _ExpenceChartState extends State<ExpenceChart> {
  List<OrdinalData> ordinalList() {
    List<OrdinalData> ordinalList = [];
    for (int i = 0; i < widget.data()!.length; i++) {
      ordinalList.add(OrdinalData(
          domain: Category.values[i].toString().substring(9),
          measure: widget.data()!.toList()[i]));
    }

    return ordinalList;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: DChartBarO(
          groupList: [
            OrdinalGroup(
              id: '1',
              data: ordinalList(),
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ],
        ),
      ),
    );
  }
}
