import 'package:flutter/material.dart';

import '../contraints.dart';

class CutomTextformFiledWidget extends StatelessWidget {
  String hinttext;
  TextInputType keyboardtype;
  TextEditingController controller;
  CutomTextformFiledWidget(
      {required this.controller,
      required this.hinttext,
      required this.keyboardtype});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(splashColor: Colors.transparent),
      child: TextFormField(
        controller: controller,
        cursorColor: AppColors().buttonColor,
        keyboardType: keyboardtype,
        style: TextStyle(
            fontSize: 14.0 / MediaQuery.textScaleFactorOf(context),
            color: Colors.black),
        decoration: InputDecoration(
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors().borderSideColor,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.grey.shade50,
          hintText: hinttext,
          hintStyle: const TextStyle(),
          errorStyle: TextStyle(
              fontSize: 14.0 / MediaQuery.textScaleFactorOf(context),
              color: Colors.red.shade900),
          contentPadding:
              const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
          enabled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors().borderSideColor,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors().borderSideColor,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColors().borderSideColor,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColors().borderSideColor,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColors().borderSideColor,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter your phone number';
          } else if (value.length > 10 || value.length < 10) {
            return 'Please enter valid phone number';
          }
          return null;
        },
      ),
    );
  }
}
