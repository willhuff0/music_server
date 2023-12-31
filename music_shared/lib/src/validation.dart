import 'package:email_validator/email_validator.dart';

const userNameMinLength = 2;
const userNameMaxLength = 24;

const userPasswordMinLength = 8;
const userPasswordMaxLength = 64;

const songNameMinLength = 1;
const songNameMaxLength = 50;

const songDescriptionMaxLength = 200;

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

bool validateSongName(String name) {
  if (name.length < songNameMinLength || name.length > songNameMaxLength) return false;

  return true;
}

bool validateSongDescription(String description) {
  if (description.length > songDescriptionMaxLength) return false;

  return true;
}
