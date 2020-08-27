import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:study_planner/src/models.dart';

part 'study_plan_state.dart';

class StudyPlanCubit extends Cubit<StudyPlanState> {
  static final log = Logger('StudyPlanCubit');

  final Box _box;
  final _controller = StreamController<List<StudyPlan>>(
    onListen: () {
      log.info('Listened to studyPlan stream.');
    },
  );

  StudyPlanCubit(this._box) : super(StudyPlanInitial()) {
    _connectStreams();
    _controller.sink.add(_studyPlans);
  }

  void _connectStreams() {
    _box.listenable().addListener(() {
      _controller.sink.add(_studyPlans);
    });
  }

  List<StudyPlan> get _studyPlans => _box.values.toList();

  Stream<List<StudyPlan>> get studyPlans => _controller.stream;

  Future<void> addStudyPlan(StudyPlan studyPlan) async {
    await _box.add(studyPlan);
    emit(StudyPlanAdded(studyPlan));
  }

  Future<void> removeStudyPlan(int index, StudyPlan studyPlan) async {
    assert(_box.getAt(index) == studyPlan);
    await _box.deleteAt(index);
    emit(StudyPlanRemoved(studyPlan));
  }

  @override
  Future<void> close() async {
    await _box.close();
    await _controller.close();
    return super.close();
  }
}
