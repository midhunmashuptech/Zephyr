
import 'package:flutter/material.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/login/screens/login.dart';

class CustomDropdownCard extends StatefulWidget {
  final String title;
  final List<String> items;
  final Function(String) onSelected;

  const CustomDropdownCard({
    super.key,
    required this.title,
    required this.items,
    required this.onSelected,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomDropdownCardState createState() => _CustomDropdownCardState();
}

class _CustomDropdownCardState extends State<CustomDropdownCard> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.dropdownblue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: ExpansionTile(
          title: Text(
            selectedValue ?? widget.title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          children: widget.items.map((item) {
            return ListTile(
              title: Text(item, style: const TextStyle(fontSize: 16)),
              onTap: () {
                setState(() {
                  selectedValue = item;
                });
                widget.onSelected(item);
                Navigator.push(context, MaterialPageRoute(builder: (context) => Login())); 
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
