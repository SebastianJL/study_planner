part of 'study_plans_bloc.dart';

abstract class StudyPlansState {
  const StudyPlansState();
}

class StudyPlansEmpty extends StudyPlansState {}

class StudyPlansLoading extends StudyPlansState {}

class StudyPlansLoaded extends StudyPlansState {
  final Stream<List<StudyPlan>> studyPlans;

  StudyPlansLoaded({@required this.studyPlans});

  @override
  List<Object> get props => throw UnimplementedError();

}
