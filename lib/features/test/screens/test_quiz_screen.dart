import 'package:flutter/material.dart';
import 'package:zephyr/common/widgets/custom_button.dart';
import 'package:zephyr/constants/app_constants.dart';

class TestQuizScreen extends StatefulWidget {
  const TestQuizScreen({super.key});

  @override
  State<TestQuizScreen> createState() => _TestQuizScreenState();
}

class _TestQuizScreenState extends State<TestQuizScreen> {
  String? _selectedOption;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.grey,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                "Questions",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 238, 234, 234),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        "Which gas is primarily responsible for the greenhouse effect on Earth?",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          "The greenhouse effect is the process by which certain gases in Earth’s atmosphere trap heat, keeping the planet warm enough to support life. Among these gases, carbon dioxide (CO₂) is one of the most significant contributors, along with methane and water vapor.",
                          style: TextStyle(fontWeight: FontWeight.w400))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Radio<String>(
                        value: "Oxygen (O₂)",
                        groupValue: _selectedOption,
                        onChanged: (value) {
                          setState(() {
                            _selectedOption = value;
                          });
                        },
                      ),
                      Text("Oxygen (O₂)"),
                    ],
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: "Carbon dioxide (CO₂)",
                        groupValue: _selectedOption,
                        onChanged: (value) {
                          setState(() {
                            _selectedOption = value;
                          });
                        },
                      ),
                      Text("Carbon dioxide (CO₂)"),
                    ],
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: "Nitrogen (N₂)",
                        groupValue: _selectedOption,
                        onChanged: (value) {
                          setState(() {
                            _selectedOption = value;
                          });
                        },
                      ),
                      Text("Nitrogen (N₂)"),
                    ],
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: "Argon (Ar)",
                        groupValue: _selectedOption,
                        onChanged: (value) {
                          setState(() {
                            _selectedOption = value;
                          });
                        },
                      ),
                      Text("Argon (Ar)"),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 15,),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryOrange,
                              textStyle: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400)),
                          child: Text(
                            "Previous",
                            style: TextStyle(color: AppColors.white),
                          )),
                      ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryOrange,
                              textStyle: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400)),
                          child: Text(
                            "Next",
                            style: TextStyle(color: AppColors.white),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    text: "Submit Quiz",
                    color: AppColors.primaryBlue,
                    onPressed: () {},
                    textcolor: AppColors.white,
                  ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
