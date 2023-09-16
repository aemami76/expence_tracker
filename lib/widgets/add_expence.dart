import 'package:expence_tracker/models/expence_data.dart';
import 'package:flutter/material.dart';

class AddExpence extends StatefulWidget {
  const AddExpence(this.onAdding, {Key? key}) : super(key: key);
  final void Function(ExpenceData) onAdding;

  @override
  State<AddExpence> createState() => _AddExpenceState();
}

class _AddExpenceState extends State<AddExpence> {
  TextEditingController _controllerT = TextEditingController();
  TextEditingController _controllerA = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedC = Category.food;

  void _showDater() async {
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.utc(DateTime.now().year - 1),
        lastDate: DateTime.now());
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _onSave() {
    final enteredAmont = double.tryParse(_controllerA.text);

    if (_controllerA.text.trim().isEmpty ||
        _controllerT.text.trim().isEmpty ||
        (enteredAmont == null ? false : enteredAmont! <= 0) ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Error"),
          content: Text("Please Enter a Valid Variables."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Sure"),
            ),
          ],
        ),
      );
      return;
    }
    widget.onAdding(ExpenceData(
        title: _controllerT.text,
        amount: enteredAmont!,
        dateTime: _selectedDate!,
        category: _selectedC));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _controllerT.dispose();
    _controllerA.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //TODO
    var _keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraint) {
      var H = constraint.maxHeight;
      var W = constraint.maxWidth;

      return SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 8 + _keyboardSpace),
              child: Expanded(
                  child: H > W
                      ? Column(
                          children: [
                            TextField(
                              controller: _controllerT,
                              maxLength: 50,
                              decoration: InputDecoration(label: Text('title')),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _controllerA,
                                    maxLength: 10,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      prefixText: "\$ ",
                                      labelText: "amount",
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(_selectedDate == null
                                          ? "Select Date"
                                          : "${_selectedDate.toString().substring(0, 10)}"),
                                      IconButton(
                                        icon: Icon(Icons.calendar_month),
                                        onPressed: _showDater,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                DropdownButton(
                                    value: _selectedC,
                                    items: Category.values
                                        .map(
                                          (e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(
                                              e.name.toUpperCase(),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (val) {
                                      setState(() {
                                        if (val == null) {
                                          return;
                                        }
                                        _selectedC = val;
                                      });
                                    }),
                                Spacer(),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Cancel')),
                                ElevatedButton(
                                    onPressed: _onSave, child: Text('Save'))
                              ],
                            )
                          ],
                        )
                      : Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      controller: _controllerT,
                                      maxLength: 50,
                                      decoration:
                                          InputDecoration(label: Text('title')),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      controller: _controllerA,
                                      maxLength: 10,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        prefixText: "\$ ",
                                        labelText: "amount",
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                DropdownButton(
                                    value: _selectedC,
                                    items: Category.values
                                        .map(
                                          (e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(
                                              e.name.toUpperCase(),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (val) {
                                      setState(() {
                                        if (val == null) {
                                          return;
                                        }
                                        _selectedC = val;
                                      });
                                    }),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(_selectedDate == null
                                          ? "Select Date"
                                          : "${_selectedDate.toString().substring(0, 10)}"),
                                      IconButton(
                                        icon: Icon(Icons.calendar_month),
                                        onPressed: _showDater,
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Cancel')),
                                ElevatedButton(
                                    onPressed: _onSave, child: Text('Save'))
                              ],
                            )
                          ],
                        )),
            ),
          ),
        ),
      );
    });
  }
}
