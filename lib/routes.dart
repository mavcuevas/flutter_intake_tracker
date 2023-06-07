import 'package:flutter/material.dart';
import 'screens/sign_in_screen.dart';
import 'package:flutter_intake_tracker/screens/landing_page.dart';
import 'package:flutter_intake_tracker/admin_dashboard.dart';
import 'package:flutter_intake_tracker/screens/register_user.dart';
import 'package:flutter_intake_tracker/screens/logs_screen.dart';
import 'package:flutter_intake_tracker/screens/notifications_screen.dart';

class Routes {
  static const String landingPage = '/';
  static const String signIn = '/signin';
  static const String adminDashboardScreen = '/admin-dashboard';
  static const String registerDBScreen = '/admin-dashboard/register-screen';
  static const String logsScreen = '/admin-dashboard/logs-screen';
  static const String usersScreen = '/admin-dashboard/users-screen';
  static const String notificationsScreen =
      '/admin-dashboard/notifications-screen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case landingPage:
        return MaterialPageRoute(builder: (_) => LandingPage());
      case signIn:
        return MaterialPageRoute(builder: (_) => SignInPage());
      case adminDashboardScreen:
        return MaterialPageRoute(builder: (_) => AdminDashboard());
      case registerDBScreen:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case logsScreen:
        return MaterialPageRoute(builder: (_) => LogsScreen());
      case notificationsScreen:
        return MaterialPageRoute(builder: (_) => NotificationsScreen());
      default:
        // Handle unknown routes here
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Route not found'),
            ),
          ),
        );
    }
  }
}
