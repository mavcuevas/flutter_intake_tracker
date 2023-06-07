import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter_intake_tracker/screens/dashboard_screen.dart';
import 'package:flutter_intake_tracker/routes.dart';
import 'package:flutter_intake_tracker/screens/register_user.dart';
import 'package:flutter_intake_tracker/screens/logs_screen.dart';
import 'package:flutter_intake_tracker/screens/notifications_screen.dart';

class AdminDashboard extends StatefulWidget {
  static const String id = 'admin-dashboard';

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  Widget _selectedScreen = DashBoardScreen();

  currentScreen(item) {
    switch (item.route) {
      case DashBoardScreen.id:
        setState(() {
          _selectedScreen = DashBoardScreen();
        });
        break;
      case Routes.registerDBScreen:
        setState(() {
          _selectedScreen = RegisterScreen();
        });
        break;
      case Routes.logsScreen:
        setState(() {
          _selectedScreen = LogsScreen();
        });
        break;
      case Routes.notificationsScreen:
        setState(() {
          _selectedScreen = NotificationsScreen();
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Admin Panel'),
      ),
      sideBar: SideBar(
        items: const [
          AdminMenuItem(
            title: 'Dashboard',
            route: DashBoardScreen.id,
            icon: Icons.dashboard,
          ),
          AdminMenuItem(
            title: 'Users',
            route: Routes.registerDBScreen,
            icon: Icons.person,
          ),
          AdminMenuItem(
            title: 'Logs',
            route: Routes.logsScreen,
            icon: Icons.history,
          ),
          AdminMenuItem(
            title: 'Notifications',
            route: Routes.notificationsScreen,
            icon: Icons.notifications,
          ),
        ],
        selectedRoute: AdminDashboard.id,
        onSelected: (item) {
          currentScreen(item);
        },
        header: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              'header',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        footer: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              'footer',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: _selectedScreen,
    );
  }
}
