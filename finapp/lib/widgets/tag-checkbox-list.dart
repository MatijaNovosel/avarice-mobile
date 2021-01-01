import 'package:finapp/constants/tag-enum.dart';
import 'package:finapp/helpers/helpers.dart';
import 'package:flutter/material.dart';

typedef TagCheckboxListSelectedCallback = void Function(List<int> selectedTags);

class TagCheckboxListWidget extends StatefulWidget {
  const TagCheckboxListWidget({this.onTagCheckboxListChanged});
  final TagCheckboxListSelectedCallback onTagCheckboxListChanged;

  @override
  _TagCheckboxListWidget createState() => _TagCheckboxListWidget();
}

class _TagCheckboxListWidget extends State<TagCheckboxListWidget> {
  List<int> _selectedTags = [];
  List<bool> _checkboxValues = List.filled(TagEnum.keys.length, false);

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
                color: Colors.grey[350],
              ),
            ),
            constraints: BoxConstraints(
              maxHeight: 300,
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: TagEnum.keys.length,
              itemBuilder: (context, i) {
                return CheckboxListTile(
                  value: _checkboxValues[i],
                  onChanged: (bool val) {
                    setState(() {
                      _checkboxValues[i] = !_checkboxValues[i];
                      if (val) {
                        _selectedTags.add(TagEnum.keys.elementAt(i));
                      } else {
                        _selectedTags.remove(TagEnum.keys.elementAt(i));
                      }
                      widget.onTagCheckboxListChanged(_selectedTags);
                    });
                  },
                  title: Text(
                    parseTag(TagEnum.keys.elementAt(i)),
                  ),
                  secondary: Icon(
                    parseTagIcon(TagEnum.keys.elementAt(i)),
                    color: Colors.grey[350],
                  ),
                  activeColor: Colors.orange,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
