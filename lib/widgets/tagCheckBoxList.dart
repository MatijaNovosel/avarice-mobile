import 'package:finapp/controllers/formSubmitController.dart';
import 'package:flutter/material.dart';

typedef TagCheckboxListSelectedCallback = void Function(List<int> selectedTags);
typedef IsValidCallback = void Function(bool isValid);

class TagCheckboxListWidget extends StatefulWidget {
  final TagCheckboxListSelectedCallback onTagCheckboxListChanged;
  final IsValidCallback isValid;
  final FormSubmitController controller;

  const TagCheckboxListWidget({
    required this.onTagCheckboxListChanged,
    required this.isValid,
    required this.controller,
  });

  @override
  _TagCheckboxListWidget createState() => _TagCheckboxListWidget(controller);
}

class _TagCheckboxListWidget extends State<TagCheckboxListWidget> {
  List<int> _selectedTags = [];
  List<bool> _checkboxValues = List.filled(8, false);
  bool _invalid = true;
  bool _touched = false;

  _TagCheckboxListWidget(FormSubmitController _controller) {
    _controller.submit = submit;
  }

  void submit() {
    setState(() {
      _touched = true;
      _invalid = _selectedTags.length == 0;
      widget.isValid(!_invalid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 1,
                color: _invalid && _touched ? Colors.red : Colors.grey[350] as Color,
              ),
            ),
            constraints: BoxConstraints(
              maxHeight: 300,
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 8,
              itemBuilder: (context, i) {
                return CheckboxListTile(
                  value: _checkboxValues[i],
                  onChanged: (bool? val) {
                    setState(() {
                      _checkboxValues[i] = !_checkboxValues[i];
                      if (val == true) {
                        _selectedTags.add(1);
                      } else {
                        _selectedTags.remove(1);
                      }
                      widget.onTagCheckboxListChanged(_selectedTags);
                      if (_touched) {
                        _invalid = _selectedTags.length == 0;
                        widget.isValid(!_invalid);
                      } else {
                        _invalid = false;
                      }
                      _touched = true;
                    });
                  },
                  title: Text(
                    "Tag",
                  ),
                  secondary: Icon(
                    Icons.favorite,
                    color: Colors.grey[350],
                  ),
                  activeColor: Colors.orange,
                );
              },
            ),
          ),
          _invalid && _touched
              ? Text(
                  "You must select at least one tag!",
                  style: TextStyle(color: Colors.red),
                )
              : Container(),
        ],
      ),
    );
  }
}
