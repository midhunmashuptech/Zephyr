import 'package:flutter/material.dart';
import 'package:zephyr/constants/app_constants.dart';

class DropdownWidget extends StatelessWidget {
  final String label;
  final List<String> items;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const DropdownWidget({
    super.key,
    required this.label,
    required this.items,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: controller.text.isNotEmpty ? controller.text : null,
      decoration: InputDecoration(
        hintText: label,
        border: const UnderlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 70, 70, 70))), // default underline
        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black87, width: 0.7)),
        enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0))),
      ),
      items: items
          .map((item) => DropdownMenuItem(
                value: item,
                child: Text(item),
              ))
          .toList(),
      onChanged: (value) {
        controller.text = value ?? '';
      },
      validator: validator ??
          (value) => value == null || value.isEmpty ? '$label is required' : null,
      menuMaxHeight: 300,
      borderRadius: BorderRadius.circular(5),
    );
  }
}
