import 'package:telopago/core/services/complete_profile_service.dart';

class CompleteProfileController {
  final AuthService _authService = AuthService();

  Future<void> submitProfile({
    required String name,
    required String email,
    required String carnet,
    required DateTime birthDate,
    required String password,
  }) {
    return _authService.registerUser(
      name: name,
      email: email,
      carnet: carnet,
      birthDate: birthDate,
      password: password,
    );
  }
}
