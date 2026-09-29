import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String title;
  final List<String> items;
  final String? value;
  final ValueChanged<String?>? onChanged;

  const CustomDropdown({
    super.key,
    required this.title,
    required this.items,
    this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: InputDecoration(
        labelText: title,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
