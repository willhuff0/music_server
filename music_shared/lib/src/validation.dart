import 'package:email_validator/email_validator.dart';

const userNameMinLength = 2;
const userNameMaxLength = 24;

const userPasswordMinLength = 8;
const userPasswordMaxLength = 64;

bool validateUserName(String name) {
  if (name.length < userNameMinLength || name.length > userNameMaxLength) return false;

  return true;
}

bool validateUserEmail(String email) {
  return EmailValidator.validate(email);
}

bool validateUserPassword(String password) {
  if (password.length < userPasswordMinLength || password.length > userPasswordMaxLength) return false;

  return true;
}
