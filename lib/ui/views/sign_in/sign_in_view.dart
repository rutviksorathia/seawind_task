import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/route_manager.dart';
import 'package:new_mobile_otp/ui/views/otp/otp_view.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? verificationId;
  bool _isLoading = false;

  void _verifyPhoneNumber() async {
    setState(() {
      _isLoading = true;
    });

    await _auth.verifyPhoneNumber(
      phoneNumber: "+91${_phoneController.text}",
      verificationCompleted: (PhoneAuthCredential credential) {
        // Automatically verify and sign in the user
      },
      verificationFailed: (FirebaseAuthException e) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Verification failed. ${e.message}")),
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          _isLoading = false;
          verificationId = verificationId;
        });

        Get.to(() => OtpVerificationScreen(
              verificationId: verificationId,
              mobileNumber: _phoneController.text,
            ));
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            left: 0,
            right: 0,
            top: 0,
            child: Image.asset(
              "assets/images/bg_image.png",
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sign In",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.phone,
                    ),
                    counterText: "",
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "Continue with mobile number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    prefixText: "+91 ",
                  ),
                ),
                SizedBox(height: 40),
                Center(
                  child: _isLoading
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(color: Colors.pink),
                        )
                      : GestureDetector(
                          onTap:
                              _isLoading || _phoneController.text.length != 10
                                  ? null
                                  : _verifyPhoneNumber,
                          child: Container(
                            width: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              color: _phoneController.text.length != 10
                                  ? Colors.grey
                                  : Colors.pink,
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
                                      "Sign In",
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
                                      color: _phoneController.text.length != 10
                                          ? Colors.grey
                                          : Colors.pink.shade800,
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
                SizedBox(
                  height: MediaQuery.of(context).padding.bottom + 40,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
