import 'package:eventure/screens/auth_screens/signup_screen.dart';
import 'package:eventure/screens/home_screens/home_screen.dart';
import 'package:eventure/utils/text_colors.dart';
import 'package:eventure/widgets/custom_input_field.dart';
import 'package:eventure/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;

  void togglePwVisiblity() {
    setState(() {
      _obscureText = !_obscureText;
      // print(_obscureText);
    });
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
              mainAxisAlignment: MainAxisAlignment.spaceAround, // TODO: UX died
              children: <Widget>[
                CustomText(
                  text: "Login",
                  color: titleColor,
                  size: 32,
                  ftWeight: FontWeight.w600,
                ),
                Column(
                  children: <Widget>[
                    CustomInputfield(
                      hint: "example@mail.com",
                      label: "Email",
                      scure: false,
                      inpType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 24),
                    Column(
                      children: <Widget>[
                        CustomInputfield(
                          hint: "Enter your password",
                          label: "Password",
                          scure: _obscureText,
                          suffixIcn: IconButton(
                            icon: Icon(_obscureText
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              togglePwVisiblity();
                            },
                            color: iconColor,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          alignment: AlignmentDirectional.centerEnd,
                          child: TextButton(
                            onPressed: () {},
                            child: CustomText(text: "Forgot password?"),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 24),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const HomeScreen(),
                              ));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: btnColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        child: CustomText(
                          text: "Sign In",
                          color: Colors.white,
                          ftWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CustomText(
                      text: "Don't have an account?",
                      color: Colors.white,
                      size: 14,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => SignupScreen(),
                          ),
                        );
                      },
                      child: CustomText(
                        text: "Sign Up",
                        color: btnTextClr,
                        size: 14,
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
