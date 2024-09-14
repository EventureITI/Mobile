import 'package:eventure/screens/profile_screens/edit_profile_screen.dart';
import 'package:eventure/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:eventure/utils/text_colors.dart';
import 'package:eventure/widgets/custom_input_field.dart';
import 'package:eventure/widgets/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool _obscureTextNew = true;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final userLoggedEmail = FirebaseAuth.instance.currentUser?.email;
  final AuthService database = AuthService();

  
  bool _isLoading = false;

  Future<void> updateUserPassword(String oldPass, String newPass) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        await database.updateUserPassword(userLoggedEmail!, oldPass, newPass);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
                color: btnColor,
                title: "All Done!",
                message: "Password changed successfully!!",
                contentType: ContentType.success),
          ),
        );
        Get.off(()=> EditProfileScreen());
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

  void togglePwVisiblity() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void toggleConfPwVisiblity() {
    setState(() {
      _obscureTextNew = !_obscureTextNew;
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                CustomText(
                  text: "Change Password",
                  color: titleColor,
                  size: 32,
                  ftWeight: FontWeight.w600,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      CustomInputfield(
                            hint: "*********",
                            label: "OLd Password",
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
                                return "Old Password must be at least 6 characters";
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: 24),
                          CustomInputfield(
                            hint: "*********",
                            label: "New Password",
                            scure: _obscureTextNew,
                            controller: _newPasswordController,
                            suffixIcn: IconButton(
                              icon: Icon(_obscureTextNew
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                toggleConfPwVisiblity();
                              },
                              color: iconColor,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "New Password is required";
                              } else if (value.length < 6) {
                                return "Password must be at least 6 characters";
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
                            updateUserPassword(_passwordController.text, _newPasswordController.text);
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
                        Get.off(() => EditProfileScreen());
                      },
                      child: CustomText(
                        text: "Back to Profile",
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