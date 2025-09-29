import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/common/widgets/custom_button.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/payment/provider/payment_provider.dart';
import 'package:zephyr/features/payment/screens/apply_coupon.dart';
import 'package:zephyr/features/payment/screens/payment_successful.dart';
import 'package:zephyr/features/payment/widgets/payment_method_card.dart';
import 'package:zephyr/features/payment/widgets/redeem_coupon_card.dart';
import 'package:zephyr/features/payment/widgets/selected_coupon_card.dart';

class CheckoutScreen extends StatefulWidget {
  final String courseId;
  const CheckoutScreen({super.key, required this.courseId});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String? offer;
  String? selectedMethod;
  PaymentProvider paymentProvider = PaymentProvider();

  List<List<String>> paymentMethods = [
    ["Razorpay", "assets/payment_icons/razorpay.png"],
    ["In-App Purchase", "assets/payment_icons/inapp.png"]
  ];

  @override
  void initState() {
    super.initState();
    loadCourseData();
  }

  Future<void> loadCourseData() async {
    final loadProvider = context.read<PaymentProvider>();
    await loadProvider.getCourseDetails(
        courseId: widget.courseId, context: context);
  }

  @override
  Widget build(BuildContext context) {
    paymentProvider = context.watch<PaymentProvider>();
    return Scaffold(
      body: SafeArea(
          child: paymentProvider.isLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
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
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w600),
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
                          child: IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Stack(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                                  0.35 >
                                              200
                                          ? 200
                                          : MediaQuery.of(context).size.width *
                                              0.35,
                                      height: double.infinity,
                                      child: CachedNetworkImage(
                                        imageUrl: paymentProvider
                                                .courseData.thumbnail ??
                                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTK8hrpymVlFVUacFKLqwlFhCNnu2hVBhAeXQ&usqp=CAU",
                                        fit: BoxFit.cover,
                                      ),
                                      // Image.asset(
                                      //   "assets/images/course_bg1.jpg",
                                      //   fit: BoxFit.cover,
                                      // ),
                                    ),
                                    Positioned(
                                      top: 7,
                                      right: 7,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                          color: paymentProvider.courseData ==
                                                  "online"
                                              ? AppColors.primaryGreen
                                                  .withOpacity(0.9)
                                              : AppColors.primaryBlue
                                                  .withOpacity(0.9),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black
                                                  .withOpacity(0.08),
                                              blurRadius: 4,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Text(
                                          (paymentProvider.courseData.type ??
                                                      "")
                                                  .isNotEmpty
                                              ? "${(paymentProvider.courseData.type ?? "")[0].toUpperCase()}${(paymentProvider.courseData.type ?? "").substring(1)} Class"
                                              : "",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: SizedBox(
                                      // height: MediaQuery.of(context).size.width * 0.2 - 5,
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            paymentProvider.courseData.title ??
                                                "Couse title",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Wrap(
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            spacing: 10,
                                            runSpacing: 6,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(Icons.calendar_today,
                                                      size: 16,
                                                      color: AppColors
                                                          .primaryBlue),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    'Starts: ${(paymentProvider.courseData.startDate ?? "").isEmpty || paymentProvider.courseData.startDate == "null" ? "NA" : formatDate(paymentProvider.courseData.startDate ?? "", "dd/MM/yyyy")}',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: AppColors.grey,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Icon(Icons.arrow_forward,
                                                  size: 16,
                                                  color: AppColors.primaryBlue),
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(Icons.event,
                                                      size: 16,
                                                      color: AppColors
                                                          .primaryBlue),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    "Ends: ${(paymentProvider.courseData.endDate ?? "").isEmpty || paymentProvider.courseData.endDate == "null" ? "NA" : formatDate(paymentProvider.courseData.endDate ?? "N/A", "dd/MM/yyy")}",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: AppColors.grey,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Course Fee:"),
                                          Text(
                                            "${(paymentProvider.courseData.price ?? 0)}/-",
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Subtotal"),
                                  Text(
                                    "+${(paymentProvider.courseData.price ?? 0)}",
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Discount"),
                                  Text(
                                    "- ${paymentProvider.courseData.discountValue}",
                                  ),
                                ],
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: Divider(
                                    color: AppColors.lightGrey,
                                  )),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total payable",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "₹${paymentProvider.totalPayable}/-",
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
                                onTap: () async {
                                  // Wait for ApplyCoupon page to pop and return a value
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ApplyCoupon()),
                                  );

                                  // Check if a coupon was returned
                                  if (result != null) {
                                    setState(() {
                                      offer = result; // Update offer
                                    });

                                    // Show success dialog
                                    showDialog(
                                      context: context,
                                      builder: (_) {
                                        return Dialog(
                                          backgroundColor: Colors.transparent,
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Lottie.asset(
                                                  "assets/lottie/voucher.json",
                                                  repeat: false),
                                              Text(
                                                "Coupon\nApplied Succesfully!",
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColors.white),
                                                textAlign: TextAlign.center,
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    );

                                    // Optional: Auto dismiss logic
                                    await Future.delayed(Duration(seconds: 3));
                                    Navigator.pop(
                                        context); // This will pop the dialog if not dismissed already
                                  }
                                },
                                child: RedeemCouponCard(),
                              ),
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
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 10),
                        Column(
                          children: [
                            PaymentMethodCard(
                              value: paymentMethods[0][0],
                              selectedMethod: selectedMethod,
                              image: paymentMethods[0][1],
                              onChanged: (String? value) {
                                setState(() {
                                  selectedMethod = value ?? "";
                                });
                              },
                              onTap: () {
                                setState(() {
                                  selectedMethod = paymentMethods[0][0];
                                });
                              },
                              subtitle: 'Card, UPI, Net Banking & Wallets',
                            ),
                            SizedBox(height: 10),
                            PaymentMethodCard(
                              value: paymentMethods[1][0],
                              selectedMethod: selectedMethod,
                              image: paymentMethods[1][1],
                              onChanged: (String? value) {
                                setState(() {
                                  selectedMethod = value ?? "";
                                });
                              },
                              onTap: () {
                                setState(() {
                                  selectedMethod = paymentMethods[1][0];
                                });
                              },
                              subtitle: 'Google Pay/ Play Store',
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        paymentProvider.isRazorpayKeyLoading
                        ? Center(child: CircularProgressIndicator())
                        : CustomButton(
                          text: "Make Payment",
                          color: AppColors.primaryBlue,
                          textcolor: AppColors.white,
                          onPressed: selectedMethod == null
                              ? null
                              : () async {
                                  await paymentProvider
                                      .getRazorpayKey(context)
                                      .then((_) => Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PaymentSuccessful())));
                                },
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
