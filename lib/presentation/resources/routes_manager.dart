import 'package:flutter/material.dart';

import '../../app/di.dart';
import '../forgot_password/view/forgot_password_view.dart';
import '../login/view/login_view.dart';
import '../main/main_view.dart';
import '../onboarding/view/onboarding_view.dart';
import '../register/view/register_view.dart';
import '../splash/splash_view.dart';
import '../store_details/store_details_view.dart';
import 'strings_manager.dart';

class Routes {
  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String forgotPasswordRoute = '/forgotPassword';
  static const String onBoardingRoute = '/onBoarding';
  static const String mainRoute = '/main';
  static const String storeDetailsRoute = '/storeDetails';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());

      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginView());

      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnBoardingView());

      case Routes.registerRoute:
        // initRegisterModule();
        return MaterialPageRoute(builder: (_) => const RegisterView());

      case Routes.forgotPasswordRoute:
        initForgotPasswordModule();
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());

      case Routes.mainRoute:
        // initHomeModule();
        return MaterialPageRoute(builder: (_) => const MainView());

      case Routes.storeDetailsRoute:
        // initStoreDetailsModule();
        return MaterialPageRoute(builder: (_) => const StoreDetailsView());

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(
            // 'No Route Found'
            AppStrings.noRouteFound,
          ),
        ),
        body: const Center(
          child: Text(
            AppStrings.noRouteFound,

            // 'AppStrings.noRouteFound.tr()',
          ),
        ),
      ),
    );
  }
}
