import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneTextfield extends StatelessWidget {
  const PhoneTextfield({super.key});

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      decoration: InputDecoration(
        hintText: 'Enter your mobile number',
        border: OutlineInputBorder(),
      ),
      initialCountryCode: 'IN',
    );
  }
}
