import 'package:bcrypt/bcrypt.dart';

String hashedPassword(String password) {
  return BCrypt.hashpw(password, BCrypt.gensalt());
}

bool checkPassword(String password, hashed) {
  return BCrypt.checkpw(password, hashed);
}
