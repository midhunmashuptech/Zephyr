import 'package:flutter/material.dart';

class RegistrationSyllabus extends StatefulWidget {
  const RegistrationSyllabus({super.key});

  @override
  State<RegistrationSyllabus> createState() => _RegistrationSyllabusState();
}

class _RegistrationSyllabusState extends State<RegistrationSyllabus> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Text("Registration syllabus page"),
            Text("Registration syllabus page"),
            Text("Registration syllabus page"),
          ],
        ),
      )),
    );
  }
}
