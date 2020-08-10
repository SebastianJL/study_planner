import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:form_bloc/form_bloc.dart';
import 'package:study_planner/src/blocs/study_plan_cubit.dart';
import 'package:study_planner/src/models.dart';

class StudyPlanFormBloc extends FormBloc<String, String> {
  final StudyPlanCubit cubit;

  // ignore: close_sinks
  final subject = TextFieldBloc(
    name: 'subject',
    validators: [
      FieldBlocValidators.required,
    ],
  );

  // ignore: close_sinks
  final examDate = InputFieldBloc<DateTime, Object>(
    name: 'examDate',
    toJson: (value) => value.toIso8601String(),
    validators: [
      FieldBlocValidators.required,
    ],
  );

  // ignore: close_sinks
  final learningGoals = ListFieldBloc<LearningGoalFieldBloc>(
    name: 'learningGoals',
  );

  StudyPlanFormBloc(this.cubit) {
    addFieldBlocs(
      fieldBlocs: [
        subject,
        examDate,
        learningGoals,
      ],
    );
  }

  @override
  void onSubmitting() async {
    cubit.addStudyPlan(StudyPlan.fromJson(state.toJson()));
    emitSuccess();
  }

  void addLearningGoal() {
    learningGoals.addFieldBloc(LearningGoalFieldBloc(
        description: TextFieldBloc(
          name: 'description',
          validators: [FieldBlocValidators.required],
        ),
        quantity: TextFieldBloc(
          name: 'quantity',
          validators: [FieldBlocValidators.required, _isInt],
        ),
        quantifier: TextFieldBloc(
          name: 'quantifier',
          validators: [FieldBlocValidators.required],
        )));
  }

  void removeLearningGoal(int index) {
    learningGoals.removeFieldBlocAt(index);
  }
}

class LearningGoalFieldBloc extends GroupFieldBloc {
  final TextFieldBloc description;
  final TextFieldBloc quantity;
  final TextFieldBloc quantifier;

  LearningGoalFieldBloc(
      {@required this.description,
      @required this.quantity,
      @required this.quantifier,
      String name})
      : super([description, quantity, quantifier], name: name);
}

String _isInt(String value) {
  try {
    int.parse(value);
    return null;
  } on FormatException {
    return "isInt - Validator Error";
  }
}
