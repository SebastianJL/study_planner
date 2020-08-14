import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@HiveType(typeId: 0)
@JsonSerializable(nullable: false)
class StudyPlan {

  @HiveField(0)
  String subject;

  @HiveField(1)
  DateTime examDate;

  @HiveField(2)
  List<LearningGoal> learningGoals;

  StudyPlan(
      {@required this.subject,
      @required this.examDate,
      @required this.learningGoals});

  factory StudyPlan.fromJson(Map<String, dynamic> json) =>
      _$StudyPlanFromJson(json);

  Map<String, dynamic> toJson() => _$StudyPlanToJson(this);


  String toString() {
    return '<$subject>';
  }
}

@HiveType(typeId: 1)
@JsonSerializable(nullable: false)
class LearningGoal {
  @HiveField(0)
  String description;

  @HiveField(1)
  @JsonKey(fromJson: _intFromString, toJson: _intToString)
  int quantity;

  @HiveField(2)
  String quantifier;

  LearningGoal({
    @required this.description,
    @required this.quantity,
    @required this.quantifier,
  });

  static int _intFromString(dynamic value) => int.parse(value as String);
  static String _intToString(dynamic value) => '${value as int}';

  factory LearningGoal.fromJson(Map<String, dynamic> json) =>
      _$LearningGoalFromJson(json);

  Map<String, dynamic> toJson() => _$LearningGoalToJson(this);
}
