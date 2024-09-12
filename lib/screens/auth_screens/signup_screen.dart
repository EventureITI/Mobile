import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventure/services/auth_service.dart';
import 'package:eventure/controllers/user_controller.dart';
import 'package:eventure/screens/auth_screens/login_screen.dart';
import 'package:eventure/utils/validators.dart';
import 'package:eventure/screens/home_screens/home_screen.dart';
import 'package:eventure/utils/text_colors.dart';
import 'package:eventure/widgets/custom_input_field.dart';
import 'package:eventure/widgets/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _obscureText = true;
  bool _obscureTextConf = true;
  final _formKey = GlobalKey<FormState>();
  String passStorage = "";

  List<String> signUpForm = [];
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confPasswordController = TextEditingController();

  final AuthService _auth = AuthService();

  UserController userController = Get.put(UserController());

  Future addUserDetails(String firstName, String lastName, String userEmail,
      String userPassword) async {
    await FirebaseFirestore.instance.collection("Users").add({
      'first_name': firstName,
      'last_name': lastName,
      'email': userEmail,
      'password': userPassword,
    });
  }

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
  void dispose() {
    // Dispose of the controllers when the widget is disposed
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confPasswordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                    flex: 2,
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
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                //TODO: smaller width
                                // First Name
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.4,
                                  height:
                                      MediaQuery.of(context).size.height / 7.5,
                                  child: CustomInputfield(
                                    label: "First Name",
                                    hint: "First Name",
                                    scure: false,
                                    controller: _firstNameController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "First Name is required";
                                      } else if (!nameRegExp.hasMatch(value) ||
                                          numberRegExp.hasMatch(value)) {
                                        return "Please, Enter a valid name";
                                      } else if (value.length < 3) {
                                        return "At least 3 letters for this field";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                                // Last Name
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.4,
                                  height:
                                      MediaQuery.of(context).size.height / 7.5,
                                  child: CustomInputfield(
                                    label: "Last Name",
                                    hint: "Last Name",
                                    scure: false,
                                    controller: _lastNameController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Last Name is required";
                                      } else if (!nameRegExp.hasMatch(value) ||
                                          numberRegExp.hasMatch(value)) {
                                        return "Please, Enter a valid name";
                                      } else if (value.length < 3) {
                                        return "At least 3 letters for this field";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            // SizedBox(height: 16),
                            //Email
                            CustomInputfield(
                              label: "Email",
                              hint: "example@mail.com",
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
                            SizedBox(height: 16),
                            //password
                            CustomInputfield(
                              hint: "*********",
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
                                  passStorage = value;
                                  print(passStorage);
                                  return null;
                                }
                              },
                            ),
                            SizedBox(height: 16),
                            //confirm password
                            CustomInputfield(
                              hint: "*********",
                              label: "Confirm Password",
                              scure: _obscureTextConf,
                              controller: _confPasswordController,
                              suffixIcn: IconButton(
                                icon: Icon(_obscureTextConf
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  toggleConfPwVisiblity();
                                },
                                color: iconColor,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Confirm Password is required";
                                } else if (value != passStorage) {
                                  return "Sorry, Not matched Password";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(height: 16),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 48,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    signUpForm = [
                                      _firstNameController.text,
                                      _lastNameController.text,
                                      _emailController.text,
                                      _passwordController.text,
                                      _confPasswordController.text
                                    ];

                                    print(signUpForm);

                                    User? user =
                                        await _auth.signUpWithEmailAndPassword(
                                            _emailController.text,
                                            _passwordController.text);
                                    if (user != null) {
                                      print("USER CREATED");
                                      Get.off(() => HomeScreen());

                                      addUserDetails(
                                        _firstNameController.text,
                                        _lastNameController.text,
                                        _emailController.text,
                                        _passwordController.text,
                                      );

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          // content: Text('Signed up successfully', style: TextStyle(color: Colors.white),),
                                          backgroundColor: Colors.transparent,
                                          // elevation: 2,
                                          content: AwesomeSnackbarContent(
                                              color: btnColor,
                                              title: "Signed Up",
                                              message:
                                                  "succesful process, Have Fun!!",
                                              contentType: ContentType.success),
                                        ),
                                      );
                                    } else {
                                      print("error occured");
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.transparent,
                                          content: AwesomeSnackbarContent(
                                              title:
                                                  "Cannot Sign Up, Try again",
                                              message:
                                                  "please, check your internet connectivity first",
                                              contentType: ContentType.failure),
                                        ),
                                      );
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: btnColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                                child: CustomText(
                                  text: "Sign Up",
                                  color: btnTextClr,
                                  ftWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
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
                              Get.to(() => LoginScreen());
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
