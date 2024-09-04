import 'package:eventure/screens/auth_screens/login_screen.dart';
import 'package:eventure/screens/home_screens/home_screen.dart';
import 'package:eventure/utils/text_colors.dart';
import 'package:eventure/widgets/custom_input_field.dart';
import 'package:eventure/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _obscureText = true;
  bool _obscureTextConf = true;

  void togglePwVisiblity() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void toggleConfPwVisiblity() {
    setState(() {
      _obscureTextConf = !_obscureTextConf;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(24),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: bgColor,
            child: Column(
              children: <Widget>[
                Flexible(
                    flex: 3,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CustomText(
                            text: "New Account",
                            color: titleColor,
                            size: 32,
                            ftWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                    )),
                Flexible(
                    flex: 10,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              //TODO: smaller width
                              Container(
                                width: MediaQuery.of(context).size.width / 2.4,
                                height: MediaQuery.of(context).size.height / 9,
                                child: CustomInputfield(
                                  label: "First Name",
                                  hint: "First Name",
                                  scure: false,
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2.4,
                                height: MediaQuery.of(context).size.height / 9,
                                child: CustomInputfield(
                                  label: "Last Name",
                                  hint: "Last Name",
                                  scure: false,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          CustomInputfield(
                            label: "Email",
                            hint: "example@mail.com",
                            scure: false,
                            inpType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 24),
                          CustomInputfield(
                            hint: "*********",
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
                          SizedBox(height: 24),
                          CustomInputfield(
                            hint: "*********",
                            label: "Confirm Password",
                            scure: _obscureTextConf,
                            suffixIcn: IconButton(
                              icon: Icon(_obscureTextConf
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                toggleConfPwVisiblity();
                              },
                              color: iconColor,
                            ),
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
                                        HomeScreen(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: btnColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              child: CustomText(
                                text: "Sign Up",
                                color: btnTextClr,
                                ftWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                Flexible(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.end,     // TODO : doesn't fit with normal text in the same line
                        children: <Widget>[
                          CustomText(
                            text: "Already have an account?",
                            color: Colors.white,
                            size: 14,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      LoginScreen(),
                                ),
                              );
                            },
                            child: CustomText(
                              text: "Sign In",
                              color: btnTextClr,
                              size: 14,
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            )),
      ),
    );
  }
}
