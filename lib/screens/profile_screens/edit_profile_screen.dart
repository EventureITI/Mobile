import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventure/screens/auth_screens/firebase_auth_impl/firebase_services.dart';
import 'package:eventure/screens/auth_screens/firebase_auth_impl/user_controller.dart';
import 'package:eventure/screens/auth_screens/login_screen.dart';
import 'package:eventure/screens/home_screens/home_screen.dart';
import 'package:eventure/screens/profile_screens/profile_tab.dart';
import 'package:eventure/utils/text_colors.dart';
import 'package:eventure/utils/validators.dart';
import 'package:eventure/widgets/custom_input_field.dart';
import 'package:eventure/widgets/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final FirebaseAuthService database = FirebaseAuthService();
  late Future<DocumentSnapshot> userData;
  bool _obscureText = true;
  bool _obscureTextConf = true;
  File? _image;
  final picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  UserController controller = UserController();

  String passStorage = "";
  dynamic userrIddd = null;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confPasswordController = TextEditingController();

  final userLoggedEmail = FirebaseAuth.instance.currentUser?.email;

  List<String> userId = [];
  Map<dynamic, dynamic> userDetails = {};
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

  // Pick Image
  Future selectImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      }
    });
  }

  // Upload Image
  Future uploadImage() async {
    if (_image == null) return;

    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
  }

  void fetchUserData(String? email) async {
    Map<String, dynamic>? userData = await database.getUserDataByEmail(email);

    if (userData != null) {
      print('User Data: $userData');
      _firstNameController.text = userData['first_name'];
      _lastNameController.text = userData['last_name'];
      _emailController.text = userData['email'];
    } else {
      print('No user found or error occurred.');
    }
  }

  @override
  void initState() {
    fetchUserData(userLoggedEmail);
    super.initState();
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
            Get.back();
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
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              selectImage();
                            },
                            child: _image == null
                                ? SvgPicture.asset(
                                    "assets/icons/avatar_placeholder.svg",
                                    height: 180,
                                    width: 180,
                                  )
                                : Container(
                                    height: 180,
                                    width: 180,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(120),
                                      child: Image.file(
                                        _image!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
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
                                  controller: _firstNameController,
                                  label: "First Name",
                                  hint: "First Name",
                                  scure: false,
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
                              Container(
                                width: MediaQuery.of(context).size.width / 2.4,
                                height: MediaQuery.of(context).size.height / 9,
                                child: CustomInputfield(
                                  controller: _lastNameController,
                                  label: "Last Name",
                                  hint: "Last Name",
                                  scure: false,
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
                          SizedBox(height: 8),
                          CustomInputfield(
                            controller: _emailController,
                            label: "Email",
                            hint: "example@mail.com",
                            scure: false,
                            inpType: TextInputType.emailAddress,
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
                          SizedBox(height: 24),
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
                          SizedBox(height: 24),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.transparent,
                                      content: AwesomeSnackbarContent(
                                          color: btnColor,
                                          title: "Profile Saved!",
                                          message:
                                              "succesful process, all changes done!!",
                                          contentType: ContentType.success),
                                    ),
                                  );
                                } else {
                                  print("error occured");
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.transparent,
                                      content: AwesomeSnackbarContent(
                                          title: "Cannot Update Profile",
                                          message:
                                              "Unexpected Something Occured",
                                          contentType: ContentType.failure),
                                    ),
                                  );
                                }
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
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
