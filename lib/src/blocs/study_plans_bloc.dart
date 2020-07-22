import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:study_planer/src/models.dart';

part 'study_plans_event.dart';

part 'study_plans_state.dart';

class StudyPlansBloc extends Bloc<StudyPlansEvent, StudyPlansState> {
  var _studyPlans = [
//    StudyPlan(examDate: DateTime.now(), subject: 'Maths'),
//    StudyPlan(examDate: DateTime.now(), subject: 'Biology'),
  ];

  StudyPlansBloc() : super(StudyPlansInitial()) {
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
        yield StudyPlansLoaded(studyPlans: _studyPlans);
      }
    }
  }
}
