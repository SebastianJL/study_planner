import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:study_planer/src/models.dart';

part 'study_plans_event.dart';

part 'study_plans_state.dart';

class StudyPlansBloc extends Bloc<StudyPlansEvent, StudyPlansState> {
  var _studyPlans = [];

  StudyPlansBloc() : super(StudyPlansEmpty()) {
    this.add(GetStudyPlans());
  }

  @override
  Stream<StudyPlansState> mapEventToState(
    StudyPlansEvent event,
  ) async* {
    if (event is GetStudyPlans) {
      yield StudyPlansLoading();
      if (_studyPlans.isEmpty) {
        yield StudyPlansEmpty();
      } else {
        yield StudyPlansLoaded(
          studyPlans: Stream<List<StudyPlan>>.periodic(
              Duration(seconds: 1), (_) => _studyPlans),
        );
      }
    } else if (event is AddStudyPlan) {
      _studyPlans.add(event.studyPlan);
      yield StudyPlanAdded(event.studyPlan, true);
    }
  }
}
