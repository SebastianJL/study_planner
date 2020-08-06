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
    validators: [
      FieldBlocValidators.required,
    ],
  );

  StudyPlanFormBloc(this.cubit) {
    addFieldBlocs(
      fieldBlocs: [
        subject,
        examDate,
      ],
    );
  }

  @override
  void onSubmitting() async {
    cubit.addStudyPlan(StudyPlan.fromJson(state.toJson()));
    emitSuccess();
  }
}
