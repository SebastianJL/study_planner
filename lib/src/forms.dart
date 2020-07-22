import 'package:flutter/material.dart';
import 'package:study_planer/src/models.dart';

class AddStudyPlanForm extends StatefulWidget {
  @override
  AddStudyPlanFormState createState() {
    return AddStudyPlanFormState();
  }
}

class AddStudyPlanFormState extends State<AddStudyPlanForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  StudyPlan _newStudyPlan = StudyPlan.empty();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
                labelText: 'Subject', hintText: 'Math, biology, ...'),
            onSaved: (value) => setState(() => _newStudyPlan.subject = value),
            validator: (value) {
              String answer;
              if (value.isEmpty) {
                answer = 'Enter subject';
              }
              // todo: add validation.
              return answer;
            },
          ),
          Text('Date of exam'),
          InputDatePickerFormField(
            initialDate: DateTime.now(),
            firstDate: DateTime.parse("2020-07-20"),
            lastDate: DateTime.parse("2020-07-27"),
            onDateSaved: (value) => _newStudyPlan.examDate = value,
          ),
          RaisedButton(
            onPressed: () async {
              final form = _formKey.currentState;
              String response;
              if (form.validate()) {
                form.save();
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text('Processing Data')));

                _newStudyPlan.save().then((successful) {
                  if (successful) {
                    response = 'Saved $_newStudyPlan.';
                  } else {
                    response = 'Failed to save $_newStudyPlan.';
                  }
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text(response)));
                });
              }
            },
            child: Text('Create study plan.'),
          )
        ]));
  }
}
