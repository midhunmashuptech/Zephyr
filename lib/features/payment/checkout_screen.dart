import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zephyr/common/widgets/custom_button.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/payment/widgets/payment_method_card.dart';
import 'package:zephyr/features/payment/widgets/redeem_coupon_card.dart';
import 'package:zephyr/features/payment/widgets/selected_coupon_card.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String? offer;
  String? selectedMethod;

  List<List<String>> paymentMethods = [
    ["1", "assets/payment_icons/gpay.png"],
    ["2", "assets/payment_icons/paytm.png"],
    ["3", "assets/payment_icons/phonepe.png"],
    ["4", "assets/payment_icons/razorpay.png"],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // SizedBox(width: 10),
                  BackButton(),
                  SizedBox(width: 10),
                  Text(
                    'Checkout',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              // Course Detail
              ClipRRect(
                clipBehavior: Clip.hardEdge,
                borderRadius: BorderRadius.circular(10),
                child: Row(
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.width * 0.2,
                        child: Image.asset("assets/images/course_bg1.jpg")),
                    SizedBox(width: 10),
                    Expanded(
                      child: SizedBox(
                          height: MediaQuery.of(context).size.width * 0.2 - 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "The Best Teachers The Best Teachers The Best Teachers",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "by Athulya Ajayakumar",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Course Fee:"),
                                  Text(
                                    "599/-",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              )
                            ],
                          )),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Divider(
                    color: AppColors.lightGrey,
                  )),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Subtotal"),
                        Text("+ 599"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Coupon"),
                        Text("- 149"),
                      ],
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Divider(
                          color: AppColors.lightGrey,
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total payable",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "450",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryBlue),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (offer == null)
                Column(
                  children: [
                    SizedBox(height: 20),
                    GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (_) {
                                return SizedBox(
                                    height: 100,
                                    child: Lottie.asset(
                                        "assets/lottie/voucher.json"));
                              });
                          setState(() {
                            offer = "Flat 149/1 OFF";
                          });
                          Future.delayed(Duration(seconds: 3)).then((value) {
                            Navigator.pop(context);
                          });
                        },
                        child: RedeemCouponCard()),
                  ],
                )
              else
                Column(
                  children: [
                    SizedBox(height: 20),
                    SelectedCouponCard(
                        offer: offer ?? "",
                        onDelete: () => setState(() {
                              offer = null;
                            })),
                  ],
                ),
              SizedBox(height: 20),
              Text(
                "Payment Method",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: PaymentMethodCard(
                        value: paymentMethods[0][0],
                        selectedMethod: selectedMethod,
                        image: paymentMethods[0][1],
                        onChanged: (String? value) {
                          setState(() {
                            selectedMethod = value ?? "";
                          });
                        },
                      )),
                      SizedBox(width: 10),
                      Expanded(
                          child: PaymentMethodCard(
                        value: paymentMethods[1][0],
                        selectedMethod: selectedMethod,
                        image: paymentMethods[1][1],
                        onChanged: (String? value) {
                          setState(() {
                            selectedMethod = value ?? "";
                          });
                        },
                      ))
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                          child: PaymentMethodCard(
                        value: paymentMethods[2][0],
                        selectedMethod: selectedMethod,
                        image: paymentMethods[2][1],
                        onChanged: (String? value) {
                          setState(() {
                            selectedMethod = value ?? "";
                          });
                        },
                      )),
                      SizedBox(width: 10),
                      Expanded(
                        child: PaymentMethodCard(
                          value: paymentMethods[3][0],
                          selectedMethod: selectedMethod,
                          image: paymentMethods[3][1],
                          onChanged: (String? value) {
                            setState(() {
                              selectedMethod = value ?? "";
                            });
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
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
                              value: "5",
                              activeColor: AppColors.primaryGreen,
                              groupValue: selectedMethod,
                              onChanged: (selected) {
                                setState(() {
                                  selectedMethod = selected ?? "";
                                });
                              }),
                          Row(
                            children: [
                              Icon(
                                Icons.credit_card_rounded,
                                color: AppColors.ratingGrey,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "Debit/Credit Card",
                                style: TextStyle(
                                    color: AppColors.ratingGrey,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              CustomButton(
                text: "Make Payment",
                color: AppColors.primaryBlue,
                textcolor: AppColors.white,
                onPressed: () {},
              ),

              SizedBox(height: 10),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          'Your personal data will be used to process your order, support your experience throughout this application, and for other purposes described in our ',
                    ),
                    TextSpan(
                      text: 'privacy policy',
                      style: TextStyle(
                        color: Color(0xFF6C63FF),
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                      // recognizer: TapGestureRecognizer()
                      //   ..onTap = _launchPrivacyPolicy,
                    ),
                  ],
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      )),
    );
  }
}
