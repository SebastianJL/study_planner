part of 'study_plans_bloc.dart';

abstract class StudyPlansEvent {
  const StudyPlansEvent();
}

class GetStudyPlans extends StudyPlansEvent {}

class AddStudyPlan extends StudyPlansEvent {
  final StudyPlan studyPlan;

  AddStudyPlan(this.studyPlan);
}