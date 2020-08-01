import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_planer/src/blocs/study_plan_cubit.dart';
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
  StudyPlanCubit cubit;

  @override
  Widget build(BuildContext context) {
    cubit = BlocProvider.of<StudyPlanCubit>(context);
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
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
            firstDate: DateTime(2000),
            lastDate: DateTime.now().add(Duration(days: 2 * 365)),
            onDateSaved: (value) => _newStudyPlan.examDate = value,
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
    );
  }
}
