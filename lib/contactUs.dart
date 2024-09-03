import 'package:eventure/widgets/buildForm.dart';
import 'package:flutter/material.dart';

class ContactUsScreen extends StatelessWidget {
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
              // the back button
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
                buildFormField("Name", "Your name/organization"),
                buildFormField("Email", "Your email address"),
                buildFormField("Subject", "Contact/event subject"),
                buildFormField("Event description", "Details about your event",
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
