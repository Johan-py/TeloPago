import 'package:firebase_auth/firebase_auth.dart';
import '../services/user_service.dart';

class CompleteProfileController {
  final UserService _userService = UserService();

  Future<void> submitProfile({
    required String name,
    required String email,
    required String carnet,
    required DateTime birthDate,
  }) async {
    if (name.isEmpty || email.isEmpty || carnet.isEmpty) {
      throw Exception('Todos los campos son obligatorios');
    }

    await _userService.saveUserProfile(
      name: name,
      email: email,
      carnet: carnet,
      birthDate: birthDate,
    );
  }

  String getCurrentEmail() {
    final user = FirebaseAuth.instance.currentUser;
    return user?.email ?? '';
  }
}
