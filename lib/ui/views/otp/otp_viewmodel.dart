import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:new_mobile_otp/ui/views/country_select/country_select_view.dart';
import 'package:stacked/stacked.dart';

class OtpVerificationScreenModel extends BaseViewModel {
  final String verificationId;
  final String mobileNumber;

  OtpVerificationScreenModel(
      {required this.verificationId, required this.mobileNumber});

  var otpController = List.generate(6, (index) => TextEditingController());

  String get otp => otpController.map((e) => e.text).join();

  int otpRemainingTimeInSeconds = 0;
  bool get isResendEnabled => otpRemainingTimeInSeconds == 0;

  Future<void> startOTPTimer() async {
    otpRemainingTimeInSeconds = 30;
    notifyListeners();

    var finishTime = DateTime.now().add(const Duration(seconds: 31));
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (finishTime.isBefore(DateTime.now())) {
          timer.cancel();
        } else {
          otpRemainingTimeInSeconds--;
          notifyListeners();
        }
      },
    );
  }

  Future<void> handleResendOtpButtonTap(BuildContext context) async {
    try {
      setBusyForObject(handleResendOtpButtonTap, true);

      startOTPTimer();
      verifyPhoneNumber(context);
      notifyListeners();
    } finally {
      setBusyForObject(handleResendOtpButtonTap, false);
    }
  }

  Future<void> handleVerifyOtpButtonTap(BuildContext context) async {
    try {
      setBusyForObject(handleVerifyOtpButtonTap, true);

      verifyOtp(context);
    } finally {
      setBusyForObject(handleVerifyOtpButtonTap, false);
    }
  }

  bool isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void verifyOtp(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      await _auth.signInWithCredential(credential);

      isLoading = false;
      notifyListeners();

      // Navigate to the next screen
      Get.offAll(() => CountrySelectView());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Verification successful!")),
      );
    } catch (e) {
      isLoading = false;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid OTP. Please try again.")),
      );
    }
  }

  void verifyPhoneNumber(BuildContext context) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: "+91$mobileNumber",
      verificationCompleted: (PhoneAuthCredential credential) {
        // Automatically verify and sign in the user
      },
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Verification failed. ${e.message}")),
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
