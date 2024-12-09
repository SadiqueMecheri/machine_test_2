import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../CommonViewModel.dart';
import '../appsize.dart';
import '../contraints.dart';
import '../session/shared_preferences.dart';
import '../widgets/custom_textformfiled.dart';
import 'home_page.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  // bool enable = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CommonViewModel>();
    Size size = AppSizes.getSize(context);

    // CommonViewmodel? vm;
    // bool isloading = false;
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              height: 200,
              // color: Colors.amber,
              width: size.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/login.png"),
                      fit: BoxFit.fill)),
              child: Center(
                child: Image.asset(
                  "assets/images/logo.png",
                  height: 100,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Login Or Register To Book\nYour Appointments ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Email",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CutomTextformFiledWidget(
                      controller: _emailcontroller,
                      hinttext: "Enter your email",
                      keyboardtype: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      "Password",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CutomTextformFiledWidget(
                      controller: _passwordcontroller,
                      hinttext: "Enter password",
                      keyboardtype: TextInputType.streetAddress,
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    if (viewModel.isLoading)
                      const Center(child: CircularProgressIndicator())
                    else
                      InkWell(
                        onTap: () async {
                          //  if (_formKey.currentState!.validate()) {
                          final username = _emailcontroller.text.trim();
                          final password = _passwordcontroller.text.trim();
                          if (username.isEmpty || password.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please fill in all fields"),
                              ),
                            );
                            return;
                          }

                          await viewModel.login(username, password);

                          if (viewModel.loginResponse?.status == true) {
                            Store.setLoggedIn("yes");
                            Store.setFcmtoken(
                                viewModel.loginResponse!.token.toString());
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          } else if (viewModel.message.isNotEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(viewModel.message),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                          //  }
                        },
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          height: 55,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors().buttonColor),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child:
                                  //  isloading == true
                                  //     ? Center(
                                  //         child: Row(
                                  //         mainAxisAlignment: MainAxisAlignment.center,
                                  //         children: [
                                  //           const Text(
                                  //             "Loading",
                                  //             style: TextStyle(
                                  //                 fontSize: 14,
                                  //                 fontWeight: FontWeight.normal,
                                  //                 color: Colors.white),
                                  //           ),
                                  //           Image.asset(
                                  //             "assets/images/loading.gif",
                                  //             height: 50,
                                  //             width: 50,
                                  //           ),
                                  //         ],
                                  //       ))
                                  //     :
                                  Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text:
                      'By creating or logging into an account you are agreeing with our ', // Base text
                  style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.normal),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Teams and Conditions  ', // Styled part
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 11,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.normal),
                    ),
                    TextSpan(
                      text: 'and ', // Another styled part
                      style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade600,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.normal),
                    ),
                    TextSpan(
                      text: 'Privacy Policy.', // Styled part
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 11,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
