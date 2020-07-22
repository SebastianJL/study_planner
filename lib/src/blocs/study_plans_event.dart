part of 'study_plans_bloc.dart';

abstract class StudyPlansEvent extends Equatable {
  const StudyPlansEvent();
}

class GetStudyPlans extends StudyPlansEvent {
  @override
  List<Object> get props => [];
}
