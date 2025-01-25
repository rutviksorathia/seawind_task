// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/route_manager.dart';
// import 'package:new_mobile_otp/ui/views/country_select/country_select_view.dart';

// class OtpVerificationScreen extends StatefulWidget {
//   final String verificationId;

//   const OtpVerificationScreen({super.key, required this.verificationId});

//   @override
//   _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
// }

// class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
//   final TextEditingController _otpController = TextEditingController();
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   bool _isLoading = false;

//   void _verifyOtp() async {
//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       PhoneAuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: widget.verificationId,
//         smsCode: _otpController.text,
//       );

//       await _auth.signInWithCredential(credential);
//       setState(() {
//         _isLoading = false;
//       });

//       // Navigate to the next screen
//       Get.offAll(() => CountrySelectView());
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Verification successful!")),
//       );
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Invalid OTP. Please try again.")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "Verify OTP",
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20),
//             TextField(
//               controller: _otpController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 labelText: "Enter OTP",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _isLoading ? null : _verifyOtp,
//               child: _isLoading
//                   ? CircularProgressIndicator(color: Colors.white)
//                   : Text("Verify"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import 'package:get/route_manager.dart';
import 'package:new_mobile_otp/ui/views/otp/otp_viewmodel.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:stacked/stacked.dart';

class OtpVerificationScreen extends StatelessWidget {
  final String verificationId;
  final String mobileNumber;

  const OtpVerificationScreen(
      {super.key, required this.verificationId, required this.mobileNumber});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OtpVerificationScreenModel>.reactive(
      viewModelBuilder: () => OtpVerificationScreenModel(
        verificationId: verificationId,
        mobileNumber: mobileNumber,
      ),
      onViewModelReady: (model) {
        model.startOTPTimer();
      },
      builder: (context, model, child) {
        return Scaffold(
          body: Column(
            children: [
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: Get.back,
                      child: Icon(Icons.arrow_back),
                    ),
                    Column(
                      children: [
                        OTPVerificationView(
                          mobileNumber: mobileNumber,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class OTPVerificationView extends ViewModelWidget<OtpVerificationScreenModel> {
  const OTPVerificationView({super.key, required this.mobileNumber});
  final String mobileNumber;

  @override
  Widget build(BuildContext context, model) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Verification',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'We\'ve send yot the verification code on +91$mobileNumber',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 36),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              6,
              (index) => Container(
                height: 50.0,
                width: 50.0,
                decoration: ShapeDecoration(
                  shape: SmoothRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    smoothness: 1,
                  ),
                  color: Colors.grey.shade100,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: TextEditorForPhoneVerify(
                    controller: model.otpController[index],
                    onChanged: (value) {
                      if (value.length == 1 && index == 5) {
                        FocusScope.of(context).unfocus();
                      }
                      if (value.length == 1 && index < 5) {
                        FocusScope.of(context).nextFocus();
                      } else if (value.isEmpty && index > 0) {
                        FocusScope.of(context).previousFocus();
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Center(
            child: model.isLoading
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(color: Colors.pink),
                  )
                : GestureDetector(
                    onTap: model.isLoading
                        ? null
                        : () => model.handleVerifyOtpButtonTap(context),
                    child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                        color: Colors.pink,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20,
                              width: 50,
                            ),
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Text(
                                "Continue",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                                color: Colors.pink.shade800,
                              ),
                              child: Icon(
                                Icons.chevron_right,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => model.handleResendOtpButtonTap(context),
                child: Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.only(bottom: 4, top: 4, left: 10),
                  child: Text(
                    model.otpRemainingTimeInSeconds == 0
                        ? "Resend OTP"
                        : 'Re - send code in ',
                  ),
                ),
              ),
              if (!model.isResendEnabled)
                SizedBox(
                  width: 40,
                  child: Center(
                    child: Text(
                      '(${model.otpRemainingTimeInSeconds.toString()})',
                      style: TextStyle(
                        color: Colors.pink,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 36),
        ],
      ),
    );
  }
}

class TextEditorForPhoneVerify extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged;

  const TextEditorForPhoneVerify(
      {required this.controller, this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      controller: controller,
      onChanged: onChanged,
      maxLength: 1,
      cursorColor: Colors.white,
      cursorWidth: 2,
      cursorHeight: 26,
      decoration: const InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: '',
          counterText: '',
          border: OutlineInputBorder(borderSide: BorderSide(width: 1))),
    );
  }
}
