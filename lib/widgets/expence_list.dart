import 'package:expence_tracker/models/expence_data.dart';
import 'package:flutter/material.dart';

class ExpenceList extends StatelessWidget {
  const ExpenceList({required this.expenceData, required this.remove, Key? key})
      : super(key: key);
  final void Function(ExpenceData) remove;

  final List<ExpenceData> expenceData;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: expenceData.length,
        itemBuilder: (ctx, index) => Dismissible(
          onDismissed: (d) {
            remove(expenceData[index]);
          },
          background: Container(
            color: Theme.of(context).colorScheme.error,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Move to Trash.",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.onError),
                  ),
                  Icon(
                    Icons.delete_forever_outlined,
                    color: Theme.of(context).colorScheme.onError,
                  ),
                ],
              ),
            ),
          ),
          key: ValueKey(expenceData[index]),
          child: ListTile(
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  categoryIcon[expenceData[index].category]!,
                  Text(expenceData[index].category.name)
                ],
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(expenceData[index].title),
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("\$ ${expenceData[index].amount}"),
                Text("${expenceData[index].dateTime}".substring(0, 10))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
