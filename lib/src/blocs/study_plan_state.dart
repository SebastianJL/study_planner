part of 'study_plan_cubit.dart';

@immutable
abstract class StudyPlanState extends Equatable{}

class StudyPlanInitial extends StudyPlanState {
  @override
  List<Object> get props => [];
}

class StudyPlanAdded extends StudyPlanState {
  final StudyPlan studyPlan;
  final bool successful;

  StudyPlanAdded(this.studyPlan, this.successful);

  @override
  List<Object> get props => [studyPlan];
}

class StudyPlanRemoved extends StudyPlanState {
  final StudyPlan studyPlan;

  StudyPlanRemoved(this.studyPlan);

  @override
  List<Object> get props => [studyPlan];
}
