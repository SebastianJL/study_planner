import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:study_planner/src/blocs/study_plan_cubit.dart';
import 'package:study_planner/src/models.dart';

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
  final StudyPlan _newStudyPlan = StudyPlan.empty();
  final _format = DateFormat("yyyy-MM-dd");
  final _initialDate = DateTime.now();
  final _firstDate = DateTime(2000);
  final _lastDate = DateTime.now().add(Duration(days: 2 * 365));
  StudyPlanCubit cubit;

  @override
  Widget build(BuildContext context) {
    cubit = BlocProvider.of<StudyPlanCubit>(context);
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.book),
              title: TextFormField(
                decoration: InputDecoration(
                    labelText: 'Subject', hintText: 'Math, biology, ...'),
                onSaved: (value) =>
                    setState(() => _newStudyPlan.subject = value),
                validator: (value) {
                  String answer;
                  if (value.isEmpty) {
                    answer = 'Enter subject';
                  }
                  // todo: add validation.
                  return answer;
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.event),
              title: DateTimeField(
                format: _format,
                decoration: InputDecoration(labelText: 'Exam date'),
                onSaved: (value) => _newStudyPlan.examDate = value,
                initialValue: _initialDate,
                onShowPicker: (context, value) =>
                    showDatePicker(
                      context: context,
                      initialDate: _initialDate,
                      firstDate: _firstDate,
                      lastDate: _lastDate,
                    ),
              ),
            ),
            RaisedButton(
              onPressed: () async {
                final form = _formKey.currentState;
                if (form.validate()) {
                  form.save();
                  Navigator.of(context).pop();
                  cubit.addStudyPlan(_newStudyPlan);
                }
              },
              child: Text('Create study plan.'),
            )
          ],
        ),
      ),
    );
  }
}
