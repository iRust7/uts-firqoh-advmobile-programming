import 'package:flutter/material.dart';

import 'models/user.dart';
import 'ui/pages/dashboard_page.dart';
import 'ui/pages/data_page.dart';
import 'ui/pages/login_page.dart';
import 'ui/pages/profile_page.dart';
import 'ui/pages/settings_page.dart';
import 'ui/theme/app_theme.dart';

void main() {
  runApp(const EduLearnApp());
}

class EduLearnApp extends StatelessWidget {
  const EduLearnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduLearn',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.buildTheme(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case DashboardPage.routeName:
            final user = settings.arguments as User? ?? dummyUser;
            return _buildTransition(
              DashboardPage(user: user),
              settings: settings,
            );
          case ProfilePage.routeName:
            final user = settings.arguments as User? ?? dummyUser;
            return _buildTransition(
              ProfilePage(user: user),
              settings: settings,
            );
          case DataPage.routeName:
            final user = settings.arguments as User? ?? dummyUser;
            return _buildTransition(
              DataPage(user: user),
              settings: settings,
            );
          case SettingsPage.routeName:
            final user = settings.arguments as User? ?? dummyUser;
            return _buildTransition(
              SettingsPage(user: user),
              settings: settings,
            );
          default:
            return _buildTransition(const LoginPage(), settings: settings);
        }
      },
      home: const LoginPage(),
    );
  }

  /// Provides a subtle fade transition for page navigation.
  PageRouteBuilder<dynamic> _buildTransition(Widget child, {RouteSettings? settings}) {
    return PageRouteBuilder<dynamic>(
      settings: settings,
      transitionDuration: const Duration(milliseconds: 450),
      pageBuilder: (_, animation, secondaryAnimation) => FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
        child: child,
      ),
    );
  }
}
