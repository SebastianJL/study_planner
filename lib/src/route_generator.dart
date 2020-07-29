import 'package:flutter/material.dart';
import 'package:study_planer/src/pages/add_study_plan_page.dart';
import 'package:study_planer/src/pages/home_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/forms/AddStudyPlanPage':
        // Validation of correct data type
        if (args == null) {
          return MaterialPageRoute(
            builder: (_) => AddStudyPlanPage(),
          );
        }
        return _errorRoute(settings.name);
      default:
        return _errorRoute(settings.name);
    }
  }

  static Route<dynamic> _errorRoute(String route) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Could not find route $route.'),
        ),
      );
    });
  }
}
