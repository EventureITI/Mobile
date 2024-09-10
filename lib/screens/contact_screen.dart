import 'package:eventure/screens/profile_screens/profile_tab.dart';
import 'package:eventure/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Contact Us',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              )),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.0),

                // Form
                customFormField("Name", "Your name/organization"),
                customFormField("Email", "Your email address"),
                customFormField("Subject", "Contact/event subject"),
                customFormField("Event description", "Details about your event",
                    maxLines: 4),

                // Send Button
                Container(
                  width: double.infinity,
                  height: 48,
                  child: TextButton(
                    onPressed: () {
                      ///
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Color(0xFF4FE0D2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      'Send',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
