import 'package:expense_tracker_app/routes/app_routes.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

class AuthController extends GetxController {
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Scan your fingerprint to authenticate',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      if (authenticated) {
        Get.offAllNamed(AppRoutes.HOME);
      }
    } catch (e) {
      debugPrint('Error authenticating: $e');
    }
    return authenticated;
  }

  @override
  void onInit() {
    super.onInit();
    authenticate();
  }
}
