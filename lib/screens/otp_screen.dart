import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../CommonViewModel.dart';
import '../contraints.dart';
import '../session/shared_preferences.dart';
import 'home_page.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController mobilecontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  //loaction dropdoen
  String? countryselectedValue;

  final List<String> locationlist = [
    "+91",
    "+90",
    "+81",
    "+21",
  ];
  @override
  void initState() {
    super.initState();
    // Set default selected value
    countryselectedValue = locationlist.first; // Initialize with first value
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CommonViewModel>();
    return Scaffold(
      backgroundColor: AppColors().backgroundColor,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Enter Your\nMobile Number",
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Lorem ipsum dolor sit amet consectetur. Porta at id hac\nvitae. Et tortor at vehicula euismod mi viverra.",
                  style:
                      TextStyle(color: AppColors().borderColor, fontSize: 10),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Container(
                      // height: 50,
                      width: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: AppColors().borderColor)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 1.5, bottom: 1.5, left: 10, right: 10),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          underline: const Text(""),
                          // hint: Text(
                          //   "",
                          //   style: TextStyle(
                          //       fontSize:
                          //           14.0 / MediaQuery.textScaleFactorOf(context),
                          //       color: Colors.black),
                          // ), // Placeholder text
                          value:
                              countryselectedValue, // Currently selected value
                          dropdownColor: Colors.black87,
                          borderRadius: BorderRadius.circular(10),
                          // icon: Image.asset(
                          //   "assets/icons/arrow-down.png",
                          //   height: 25,
                          // ), // Dropdown icon
                          items: locationlist.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: TextStyle(
                                    fontSize: 14.0 /
                                        MediaQuery.textScaleFactorOf(context),
                                    color: countryselectedValue == item
                                        ? AppColors().borderColor
                                        : Colors.white),
                              ),
                            );
                          }).toList(), // Convert items to DropdownMenuItem
                          onChanged: (String? newValue) {
                            setState(() {
                              countryselectedValue =
                                  newValue; // Update selected value
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Flexible(
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(splashColor: Colors.transparent),
                        child: TextFormField(
                          controller: mobilecontroller,
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.phone,
                          style: TextStyle(
                              fontSize:
                                  14.0 / MediaQuery.textScaleFactorOf(context),
                              color: Colors.white),
                          decoration: InputDecoration(
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors().borderColor,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: AppColors().backgroundColor,
                            hintText: 'Enter your mobile number',
                            hintStyle:
                                TextStyle(color: AppColors().borderColor),
                            errorStyle: TextStyle(
                                fontSize: 14.0 /
                                    MediaQuery.textScaleFactorOf(context),
                                color: Colors.red.shade900),
                            contentPadding: const EdgeInsets.only(
                                left: 20, right: 20, top: 15, bottom: 15),
                            enabled: true,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors().borderColor,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors().borderColor,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors().borderColor,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors().borderColor,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors().borderColor,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter mobile number';
                            } else if (value.length > 10 || value.length < 10) {
                              return 'Please enter valid phone number';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 300,
                ),
                if (viewModel.isLoading)
                  const Center(child: CircularProgressIndicator())
                else
                  Center(
                    child: InkWell(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          String mobilenumber =
                              countryselectedValue.toString() +
                                  mobilecontroller.text;
                          log("mobile number ==== " + mobilenumber.toString());

                          await viewModel.login(countryselectedValue.toString(),
                              mobilecontroller.text);

                          if (viewModel.loginResponse?.status == true) {
                            // log("respppp sssss---" +
                            //     viewModel.loginResponse!.status.toString());

                            Store.setLoggedIn("yes");
                            Store.setFcmtoken(viewModel
                                .loginResponse!.token!.accessToken
                                .toString());
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          } else if (viewModel.message.isNotEmpty) {
                            // log("respppp cpmeddd---" +
                            //     viewModel.loginResponse!.status.toString());

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(viewModel.message),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: AppColors().bottunColor,
                            border: Border.all(color: AppColors().borderColor)),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Continue",
                                style: TextStyle(
                                    color: AppColors().borderColor,
                                    fontSize: 14),
                              ),
                              Image.asset("assets/images/arrow.png")
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
