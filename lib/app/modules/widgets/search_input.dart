import 'package:flutter/material.dart';
import 'package:scan_app/app/modules/widgets/custom_text_field_widget.dart';

class SearchInput extends StatelessWidget {
  final void Function(String?) onSearch;

  SearchInput({required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return CustomTextFieldWidget(
      labelText: "Search event name",
      autovalidateMode: AutovalidateMode.disabled,
      onChanged: (text) => onSearch(text), // Call onSearch when text changes
    );
  }
}
