import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:study_planer/src/models.dart';

part 'study_plan_state.dart';

class StudyPlanCubit extends Cubit<StudyPlanState> {
  StudyPlanCubit() : super(StudyPlanInitial());

  List<StudyPlan> _studyPlans = [];

  Stream<List<StudyPlan>> get studyPlans =>
      Stream<List<StudyPlan>>.periodic(Duration(seconds: 1), (_) => _studyPlans);

  addStudyPlan(StudyPlan studyPlan) {
    _studyPlans.add(studyPlan);
    emit(StudyPlanAdded(studyPlan, true));
  }

  removeStudyPlan(StudyPlan studyPlan) {
    _studyPlans.remove(studyPlan);
    emit(StudyPlanRemoved(studyPlan));
  }
}
