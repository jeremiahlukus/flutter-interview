import 'package:flutter/material.dart';
import 'package:otto_app/app/auth/presentation/ui/screens/login_register_screen.dart';
import 'package:otto_app/app/auth/presentation/ui/screens/verify_otp_screen.dart';
import 'package:otto_app/app/pre_approval/presentation/ui/screens/calculating_offer_screen.dart';
import 'package:otto_app/app/pre_approval/presentation/ui/screens/offer_screen.dart';
import 'package:otto_app/app/pre_approval/presentation/ui/screens/user_details_screen.dart';
import 'package:otto_app/app/pre_approval/presentation/ui/screens/vehicle_condition_screen.dart';
import 'package:otto_app/app/pre_approval/presentation/ui/tabs/vehicle_details_tab_screen.dart';
import 'package:otto_app/screens/launch/launch_screen.dart';

class OttoRoutes {
  /// Launch Routes.
  static const launch = 'launch';

  /// Authentication routes.
  static const loginOrRegister = 'auth/login_or_register';
  static const verifyOTP = 'auth/verify_otp';

  //Pre-Approval Route.
  static const userDetails = 'pre-approval/user_details';
  static const vehicleDetails = 'pre-approval/vehicle-details';
  static const vehicleCondition = 'pre-approval/vehicle_condition';

  static const calculatingOffer = 'pre-approval/calculating_offer';
  static const offer = 'pre-approval/offer';

  static Map<String, Widget Function(BuildContext)> staticRoutes = {
    launch: (context) => const LaunchScreen(),
    userDetails: (context) => const UserDetailsScreen(),
    vehicleDetails: (context) => const VehicleDetailsTabScreen(),
    vehicleCondition: (context) => const VehicleConditionScreen(),
    calculatingOffer: (context) => const CalculatingOfferScreen(),
    offer: (context) => const OfferScreen(),
  };

  ///[dynamicRoutes] should be routes with parameter.
  static Route<dynamic> dynamicRoutes(RouteSettings settings) {
    switch (settings.name) {
      case loginOrRegister:
        return MaterialPageRoute(
          builder: (context) {
            return LoginOrRegisterScreen(
                tokenTimeOut: (settings.arguments ?? false) as bool);
          },
        );

      case verifyOTP:
        return MaterialPageRoute(
          builder: (context) {
            return VerifyOTPScreen(phoneNumber: settings.arguments as String);
          },
        );

      default:
        return MaterialPageRoute(
          builder: (context) {
            return const LaunchScreen();
          },
        );
    }
  }
}
