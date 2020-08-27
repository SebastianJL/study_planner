import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:study_planner/src/blocs/study_plan_cubit.dart';
import 'package:study_planner/src/models.dart';
import 'package:study_planner/src/route_generator.dart';

const appName = 'StudyPlanner';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory appDocDir = await getApplicationDocumentsDirectory();

  initLogging();
  Box<StudyPlan> box = await initHive(appDocDir);

  runApp(
    BlocProvider(
      create: (BuildContext _) => StudyPlanCubit(box),
      child: MyApp(),
    ),
  );
}

void initLogging() {
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: [${record.loggerName}] ${record.time}: ${record.message}');
  });
}

Future<Box<StudyPlan>> initHive(Directory appDocDir) async {
  await Hive.initFlutter(appDocDir.path);

  Hive.registerAdapter(StudyPlanAdapter());
  Hive.registerAdapter(LearningGoalAdapter());
  var box = await Hive.openBox<StudyPlan>('StudyPlan');
  return box;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
