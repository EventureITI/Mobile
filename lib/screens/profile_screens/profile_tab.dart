import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:eventure/controllers/user_controller.dart';
import 'package:eventure/screens/auth_screens/login_screen.dart';
import 'package:eventure/screens/contact_screen.dart';
import 'package:eventure/screens/home_screens/home_screen.dart';
import 'package:eventure/screens/profile_screens/edit_profile_screen.dart';
import 'package:eventure/screens/profile_screens/user_tickets_screen.dart';
import 'package:eventure/services/auth_service.dart';
import 'package:eventure/utils/text_colors.dart';
import 'package:eventure/widgets/custom_text.dart';
import 'package:eventure/widgets/profile_option.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  // final FirebaseAuthService _auth = FirebaseAuthService();
  UserController userController = Get.put(UserController());
  UserController controller = UserController();
  final AuthService database = AuthService();
  final userLoggedEmail = FirebaseAuth.instance.currentUser?.email;
  // final iddd = FirebaseAuth.instance.currentUser?.uid;

  List<String> userId = [];

  Future<void> fetchUserData(String? email) async {
    Map<String, dynamic>? userData = await database.getUserDataByEmail(email);

    if (userData != null) {
      print('User Data: $userData');

      userController.saveUserData(userData['firstName'], userData['lastName']);
      // print("${controller.fName.value} ${controller.lName.value}");
    } else {
      print('No user found or error occurred.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchUserData(userLoggedEmail),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while waiting for the Future to complete
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: bgColor,
              child: Center(
                child: CircularProgressIndicator(
                  color: btnColor,
                ),
              ),
            );
          } else if (snapshot.hasError) {
            // Handle errors
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: bgColor,
                child: Column(
                  children: <Widget>[
                    CustomText(
                      text: "Profile",
                      color: Colors.white,
                      size: 22,
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    SvgPicture.asset(
                      "images/carbon_user-avatar-filled.svg",
                      height: 96,
                      width: 96,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Obx(
                      () => userController.signed.value == true
                          ? CustomText(
                              text:
                                  "${userController.fName.value} ${userController.lName.value}"
                                      .capitalize,
                              color: Colors.white,
                              size: 25,
                            )
                          : SizedBox(
                              width: MediaQuery.of(context).size.width / 3,
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.to(() => LoginScreen());
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: btnColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                                child: CustomText(
                                  text: "Login",
                                  color: Colors.white,
                                  ftWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Obx(() => userController.signed.value == true
                        ? ProfileOption(
                            action: () {},
                            optionIcon: "assets/icons/ticket_outline.svg",
                            optionText: "Your Tickets",
                            nextScreen: UserTicketsScreen())
                        : Container()),
                    Obx(() => userController.signed.value == true
                        ? Container(
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            width: MediaQuery.of(context).size.width,
                            height: 1,
                            color: inpBg,
                          )
                        : Container()),
                    Obx(() => userController.signed.value == true
                        ? ProfileOption(
                            action: () {},
                            optionIcon: "assets/icons/acc.svg",
                            optionText: "Edit Profile",
                            nextScreen: EditProfileScreen())
                        : Container()),
                    ProfileOption(
                        action: () {
                          // Get.to(()=> ContactScreen());
                        },
                        optionIcon: "assets/icons/contact.svg",
                        optionText: "Contact Us",
                        nextScreen: ContactScreen()),
                    Obx(() => userController.signed.value == true
                        ? ProfileOption(
                            action: () {
                              // print(authUser);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.transparent,
                                  content: AwesomeSnackbarContent(
                                      color: btnColor,
                                      title: "Signed Out",
                                      message:
                                          "succesful signed out, see you soon!!",
                                      contentType: ContentType.success),
                                ),
                              );
                              // userController.fetchUser();
                              FirebaseAuth.instance.signOut();
                              userController.loggedOut();
                              userController.defaultData();

                              print("USER SIGNED OUT");
                            },
                            optionIcon: "assets/icons/logout.svg",
                            optionText: "Log Out",
                            nextScreen: HomeScreen())
                        : Container())
                  ],
                ),
              ),
            );
          }
        });
  }
}
