import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:study_planner/src/blocs/study_plan_cubit.dart';
import 'package:study_planner/src/models.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('StudyPlanCubit', () {
    Directory tmpDir;
    StudyPlan studyPlan;
    var uuid = Uuid();

    setUpAll(() async {
      tmpDir = await Directory.systemTemp.createTemp();
      Hive.init(tmpDir.path);
      Hive.registerAdapter(StudyPlanAdapter());
      Hive.registerAdapter(LearningGoalAdapter());
    });

    setUp(() async {
      studyPlan = StudyPlan(
        examDate: DateTime.parse('1969-07-20 20:18:04Z'),
        subject: 'Maths',
        learningGoals: [],
      );
    });

    tearDown(() {
      Hive.close();
    });

    test('emits study plans on creation.', () async {
      var boxId = uuid.v4();
      var testBox = await Hive.openBox<StudyPlan>('TestBox-$boxId');
      var cubit = StudyPlanCubit(testBox);
      expect(cubit.studyPlans.first, completion(equals(<StudyPlan>[])));

      testBox.close();
      cubit.close();
    });

    test('emits study plans on adding study plan.', () async {
      var boxId = uuid.v4();
      var testBox = await Hive.openBox<StudyPlan>('TestBox-$boxId');
      var cubit = StudyPlanCubit(testBox);

      testBox.add(studyPlan);
      await expectLater(
        cubit.studyPlans,
        emitsInOrder([
          <StudyPlan>[],
          <StudyPlan>[studyPlan]
        ]),
      );

      testBox.close();
      cubit.close();
    });

    test('emits StudyPlanAdded on call to addStudyPlan', () async {
      var boxId = uuid.v4();
      var testBox = await Hive.openBox<StudyPlan>('TestBox-$boxId');
      var cubit = StudyPlanCubit(testBox);

      expect(
        cubit,
        emitsInOrder([StudyPlanAdded(studyPlan)]),
      );
      cubit.listen((value) => value.runtimeType);

      testBox.close();
      cubit.close();
    }, skip: true);
  });
}
