import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_mobile_otp/app/app.dart';
import 'package:new_mobile_otp/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}
