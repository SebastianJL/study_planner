import 'package:flutter/material.dart';
import 'package:study_planer/src/forms.dart';

class AddStudyPlanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('New study plan'),
      ),
      body: AddStudyPlanForm(),
    );
  }
}
