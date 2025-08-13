import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/mdi.dart';
import 'package:zephyr/constants/app_constants.dart';

class CouponCard extends StatefulWidget {
  final String couponText;
  final String couponCode;
  final String radioValue;
  final String? radioGroupValue;
  final Function() onTap;
  final ValueChanged<String?> onChanged;

  const CouponCard(
      {required this.couponText,
      required this.couponCode,
      required this.radioValue,
      required this.radioGroupValue,
      required this.onTap,
      required this.onChanged,
      super.key});

  @override
  State<CouponCard> createState() => _CouponCardState();
}

class _CouponCardState extends State<CouponCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(blurRadius: 5, color: AppColors.grey, spreadRadius: 2)
          ],
          borderRadius: BorderRadius.circular(15),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          clipBehavior: Clip.hardEdge,
          child: Container(
            color: AppColors.white,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: AppColors.primaryBlue,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Iconify(
                                      Mdi.coupon,
                                      color: AppColors.white,
                                    ),
                                  )),
                              SizedBox(width: 15),
                              Expanded(
                                child: Text(
                                  widget.couponText,
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Radio(
                            activeColor: AppColors.primaryBlue,
                            value: widget.radioValue,
                            groupValue: widget.radioGroupValue,
                            onChanged: widget.onChanged)
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  color: AppColors.primaryGreen,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Coupon Code",
                          style: TextStyle(color: AppColors.white),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  widget.couponCode,
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
