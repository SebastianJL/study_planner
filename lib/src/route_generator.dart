import 'package:flutter/material.dart';
import 'package:study_planner/src/models.dart';
import 'package:study_planner/src/pages/study_plan_form.dart';
import 'package:study_planner/src/pages/home_page.dart';

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
            builder: (_) => StudyPlanForm(),
          );
        } else if (args is StudyPlan) {
          return MaterialPageRoute(
            builder: (_) => StudyPlanForm(studyPlan: args),
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
