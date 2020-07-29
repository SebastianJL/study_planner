part of 'study_plans_bloc.dart';

abstract class StudyPlansState {
  const StudyPlansState();
}

class StudyPlansEmpty extends StudyPlansState {}

class StudyPlansLoading extends StudyPlansState {}

class StudyPlansLoaded extends StudyPlansState {
  final Stream<List<StudyPlan>> studyPlans;

  StudyPlansLoaded({@required this.studyPlans});
}

class StudyPlanAdded extends StudyPlansState {
  final StudyPlan studyPlan;
  final bool successful;

  StudyPlanAdded(this.studyPlan, this.successful);
}
