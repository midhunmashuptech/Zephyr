import 'package:flutter/material.dart';

class DrawerComponent extends StatelessWidget {
  final String item;
  final IconData icon;
  final void Function()? onTap;
  const DrawerComponent(
      {super.key, required this.item, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        item,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      leading: Icon(icon),
      onTap: onTap,
    );
  }
}
