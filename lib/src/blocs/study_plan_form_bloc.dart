import 'package:form_bloc/form_bloc.dart';

class StudyPlanFormBloc extends FormBloc<String, String> {
  // ignore: close_sinks
  final subject = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
  );
  // ignore: close_sinks
  final examDate = InputFieldBloc<DateTime, Object>(
    validators: [
      FieldBlocValidators.required,
    ],
  );

  StudyPlanFormBloc() {
    addFieldBlocs(
      fieldBlocs: [
        subject,
        examDate,
      ],
    );
  }

  @override
  void onSubmitting() async {
    print(this);
    emitSuccess();
  }
}
