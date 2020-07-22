import 'package:flutter/material.dart';
import 'package:study_planer/src/forms.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  final String title = 'Study planer';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/icon/icon-white.png'),
        ),
        title: Text(title),
      ),
      body: Center(
        child: Text('No study plans yet. Press "+" to create.'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(
            '/forms/AddStudyPlanPage',
          );
        },
        tooltip: 'Add study plan.',
        child: Icon(Icons.add),
      ),
    );
  }
}

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
