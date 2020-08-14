import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';
import 'package:study_planner/src/models.dart';

part 'study_plan_state.dart';

class StudyPlanCubit extends Cubit<StudyPlanState> {
  static final String boxName = 'StudyPlans';
  static bool _isInitialized = false;

  Box _box;

  /// This method must be called before an instance can be created.
  static Future<void> init() async {
    Hive.registerAdapter(StudyPlanAdapter());
    Hive.registerAdapter(LearningGoalAdapter());
    await Hive.openBox<StudyPlan>(boxName);
    _isInitialized = true;
  }

  StudyPlanCubit() : super(StudyPlanInitial()) {
    assert(_isInitialized);
    _box = Hive.box<StudyPlan>(boxName);
    _connectStreams();
    _controller.sink.add(_studyPlans);
  }

  void _connectStreams() {
    _box.listenable().addListener(() {
      _controller.sink.add(_studyPlans);
    });
  }

  StreamController _controller = StreamController<List<StudyPlan>>();

  List<StudyPlan> get _studyPlans => _box.values.toList();

  Stream<List<StudyPlan>> get studyPlans => _controller.stream;

  addStudyPlan(StudyPlan studyPlan) {
    _box.add(studyPlan);
    emit(StudyPlanAdded(studyPlan, true));
  }

  removeStudyPlan(StudyPlan studyPlan) {
//  todo(SebastianJL): delete studyplan
    emit(StudyPlanRemoved(studyPlan));
  }

  @override
  Future<void> close() async {
    await _box.close();
    await _controller.close();
    return super.close();
  }
}
