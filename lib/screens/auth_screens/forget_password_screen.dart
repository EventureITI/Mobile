import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:eventure/screens/auth_screens/login_screen.dart';
import 'package:eventure/utils/text_colors.dart';
import 'package:eventure/utils/validators.dart';
import 'package:eventure/widgets/custom_input_field.dart';
import 'package:eventure/widgets/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  bool _isLoading = false;

  Future<void> forgetPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        await _auth.sendPasswordResetEmail(email: _emailController.text.trim());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
                color: btnColor,
                title: "Email Sent!",
                message: "Please, check your email inbox",
                contentType: ContentType.success),
          ),
        );
        Get.to(()=> LoginScreen());
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
                title: "Uncompleted process",
                message:
                    "Something went wrong, try again",
                contentType: ContentType.failure),
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(24),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: bgColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                CustomText(
                  text: "Reset Password",
                  color: titleColor,
                  size: 32,
                  ftWeight: FontWeight.w600,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      CustomInputfield(
                        hint: "example@mail.com",
                        label: "Email",
                        scure: false,
                        inpType: TextInputType.emailAddress,
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email is required";
                          } else if (!emailRegExp.hasMatch(value)) {
                            return "Please, Enter a valid Email";
                          } else {
                            return null;
                          }
                        },
                      ),
                      
                      SizedBox(height: 24),
                      
                       _isLoading ? CircularProgressIndicator(color: btnColor,)
                        :
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 48,
                        child:
                         ElevatedButton(
                          onPressed: (){
                            forgetPassword();
                            
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: btnColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          child: CustomText(
                            text: "Confirm",
                            color: Colors.white,
                            ftWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextButton(
                      onPressed: () {
                        Get.off(() => LoginScreen());
                      },
                      child: CustomText(
                        text: "Back to Sign In",
                        color: btnTextClr,
                        size: 16,
                      ),
                    )
                  ],
                ),
              ],
            )),
      ),
    ));
  }
}