import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:eventure/screens/auth_screens/firebase_auth_impl/firebase_services.dart';
import 'package:eventure/screens/auth_screens/firebase_auth_impl/user_controller.dart';
import 'package:eventure/screens/auth_screens/forget_password_screen.dart';
import 'package:eventure/screens/auth_screens/signup_screen.dart';
import 'package:eventure/utils/validators.dart';
import 'package:eventure/screens/home_screens/home_screen.dart';
import 'package:eventure/utils/text_colors.dart';
import 'package:eventure/widgets/custom_input_field.dart';
import 'package:eventure/widgets/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  final _loginFormKey = GlobalKey<FormState>();

  List<String> loginForm = [];
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuthService _auth = FirebaseAuthService();

  UserController userController = Get.put(UserController());

  void togglePwVisiblity() {
    setState(() {
      _obscureText = !_obscureText;
      // print(_obscureText);
    });
  }

  @override
  void dispose() {
    // Dispose of the controllers when the widget is disposed
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                Form(
                  key: _loginFormKey,
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
                      Column(
                        children: <Widget>[
                          CustomInputfield(
                            hint: "Enter your password",
                            label: "Password",
                            scure: _obscureText,
                            controller: _passwordController,
                            suffixIcn: IconButton(
                              icon: Icon(_obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                togglePwVisiblity();
                              },
                              color: iconColor,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Password is required";
                              } else if (value.length < 6) {
                                return "Password must be at least 6 characters";
                              } else {
                                return null;
                              }
                            },
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            alignment: AlignmentDirectional.centerEnd,
                            child: TextButton(
                              onPressed: () {
                                Get.to(()=>ForgetPasswordScreen());
                              },
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
                          onPressed: () async {
                            if (_loginFormKey.currentState!.validate()) {
                              loginForm = [
                                _emailController.text,
                                _passwordController.text,
                              ];

                              print(loginForm);
                              User? user =
                                  await _auth.signInWithEmailAndPassword(
                                      _emailController.text,
                                      _passwordController.text);
                              if (user != null) {
                                print("USER LOGGED IN");
                                print(user);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        HomeScreen(),
                                  ),
                                );
                                // Get.off(()=>HomeScreen());

                                userController.loggedIn();

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.transparent,
                                    content: AwesomeSnackbarContent(
                                        color: btnColor,
                                        title: "Signed In",
                                        message: "Welcome Back, Have Fun!!",
                                        contentType: ContentType.success),
                                  ),
                                );
                              } else {
                                print("error occured");
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.transparent,
                                    content: AwesomeSnackbarContent(
                                        title: "Couldn't Sign in",
                                        message:
                                            "Email and Password are Invalid",
                                        contentType: ContentType.failure),
                                  ),
                                );
                              }
                            }
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
                        Get.off(() => SignupScreen());
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
