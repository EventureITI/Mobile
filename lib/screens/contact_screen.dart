import 'package:eventure/screens/profile_screens/profile_tab.dart';
import 'package:eventure/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:emailjs/emailjs.dart' as emailjs;

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegExp.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    } else if (value.length < 3) {
      return 'Name must be at least 3 characters long';
    }
    return null;
  }

  String? _validateNotEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  String? _validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Description is required';
    } else if (value.length < 18) {
      return 'Description must be at least 18 characters long';
    }
    return null;
  }

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
          child: Form(
            key: _formKey, // Wrap the form fields with the Form widget
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.0),

                // Form
                customFormField(
                    "Name", "Your name/organization", _nameController,
                    validator: _validateName),
                customFormField("Email", "Your email address", _emailController,
                    validator: _validateEmail),
                customFormField(
                    "Subject", "Contact/event subject", _subjectController,
                    validator: _validateNotEmpty),
                customFormField("Event description", "Details about your event",
                    _descriptionController,
                    maxLines: 4, validator: _validateDescription),

                // Send Button
                Container(
                  width: double.infinity,
                  height: 48,
                  child: TextButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, proceed with sending the email
                        final templateParams = {
                          'user_name': _nameController.text,
                          'user_email': _emailController.text,
                          'subject': _subjectController.text,
                          'message': _descriptionController.text,
                        };

                        bool success = await sendEmail(templateParams);

                        if (success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Email sent successfully!')),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Failed to send email.')),
                          );
                        }
                      }
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
        ),
      ),
    );
  }

  Future<bool> sendEmail(dynamic templateParams) async {
    try {
      await emailjs.send(
        'service_ki1a50v',
        'template_sc7nkis',
        templateParams,
        const emailjs.Options(
          publicKey: '2X53uaQIWtewlAiTX',
          privateKey: '4eeVzUCxkeIPT7GA1bpZx',
        ),
      );
      print('SUCCESS!');
      return true;
    } catch (error) {
      if (error is emailjs.EmailJSResponseStatus) {
        print('ERROR... ${error.status}: ${error.text}');
      }
      print(error.toString());
      return false;
    }
  }
}
