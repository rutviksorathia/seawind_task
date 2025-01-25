import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:new_mobile_otp/ui/views/sign_in/sign_in_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: SignInScreen(),
    );
  }
}
