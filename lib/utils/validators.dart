final RegExp nameRegExp = RegExp(r'^[a-zA-Z\s]+$'); 
final RegExp numberRegExp = RegExp(r'\d');
  // final specialCharPattern = RegExp(r'[!@#$%^&*+\-=\[\]{};:\'",.<>/?\\|`~]');
final RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z.-]+\.[a-zA-Z]{2,3}$');

String? validateEmail(String? value) {
  if(value == null || value.isEmpty ){
    return "Email is required";
  }
  else if(!emailRegExp.hasMatch(value)){
    return "Please, Enter a valid Email";
  }
  else{
    return null;
  }
}