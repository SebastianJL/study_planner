part of 'study_plans_bloc.dart';

abstract class StudyPlansState extends Equatable {
  const StudyPlansState();
}

class StudyPlansEmpty extends StudyPlansState {
  @override
  List<Object> get props => throw UnimplementedError();

}

class StudyPlansLoading extends StudyPlansState {
  @override
  List<Object> get props => throw UnimplementedError();
}

class StudyPlansLoaded extends StudyPlansState {
  final Stream<List<StudyPlan>> studyPlans;

  StudyPlansLoaded({@required this.studyPlans});

  @override
  List<Object> get props => throw UnimplementedError();

}
