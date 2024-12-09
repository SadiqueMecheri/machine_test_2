import 'package:machine_test_2/screens/VideoProvider.dart';

import 'CommonViewModel.dart';
import 'contraints.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'auth_repository.dart';
import 'screens/CategoryProvider.dart';
import 'screens/Category_Provider_Home.dart';
import 'screens/HomeProvider.dart';
import 'screens/otp_screen.dart';
import 'screens/splash.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
    statusBarIconBrightness: Brightness.light, // dark text for status bar icons
  ));
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => CommonViewModel(AuthRepository()),
      ),
      ChangeNotifierProvider(create: (_) => VideoProvider()),
      ChangeNotifierProvider(create: (_) => CategoryProvider()),
      ChangeNotifierProvider(create: (_) => HomeProvider()),
      ChangeNotifierProvider(
          create: (_) => CategoryProvider_Home()..fetchData()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Machine_Test_2',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Poppins",
          colorScheme: ColorScheme.light(primary: AppColors().buttonColor),
        ),
        home: OtpScreen());
  }
}
