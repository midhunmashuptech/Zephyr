import 'package:flutter/material.dart';
import 'package:zephyr/constants/app_constants.dart';

class PaymentMethodCard extends StatefulWidget {
  final String value;
  final String? selectedMethod;
  final String image;
  final ValueChanged<String?> onChanged;
  const PaymentMethodCard(
      {super.key,
      required this.image,
      required this.selectedMethod,
      required this.value,
      required this.onChanged});

  @override
  State<PaymentMethodCard> createState() => _PaymentMethodCardState();
}

class _PaymentMethodCardState extends State<PaymentMethodCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: AppColors.grey),
          color: AppColors.grey.withAlpha(30)),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Radio(
                activeColor: AppColors.primaryGreen,
                value: widget.value,
                groupValue: widget.selectedMethod,
                onChanged: widget.onChanged),
            SizedBox(height: 30, child: Image.asset(widget.image)),
            SizedBox(
              width: 10,
            )
          ],
        ),
      ),
    );
  }
}
