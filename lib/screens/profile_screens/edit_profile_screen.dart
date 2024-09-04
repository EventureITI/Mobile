import 'package:eventure/screens/auth_screens/login_screen.dart';
import 'package:eventure/screens/home_screens/home_screen.dart';
import 'package:eventure/screens/profile_screens/profile_tab.dart';
import 'package:eventure/utils/text_colors.dart';
import 'package:eventure/widgets/custom_input_field.dart';
import 'package:eventure/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
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
      appBar: AppBar(
        backgroundColor: Color(0xFF1C1C1C),
        title: Text(
          'Edit Profile',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => ProfileTab(),
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(24),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: bgColor,
          child: Column(
            children: <Widget>[
              Flexible(
                  flex: 1,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: <Widget>[
                        SvgPicture.asset(
                          "assets/icons/avatar_placeholder.svg",
                          height: 96,
                          width: 96,
                        ),
                        SizedBox(height: 32),
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
                        SizedBox(height: 8),
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
                              text: "Save",
                              color: btnTextClr,
                              ftWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
