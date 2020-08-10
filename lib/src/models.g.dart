// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudyPlan _$StudyPlanFromJson(Map<String, dynamic> json) {
  return StudyPlan(
    subject: json['subject'] as String,
    examDate: DateTime.parse(json['examDate'] as String),
    learningGoals: (json['learningGoals'] as List)
        .map((e) => LearningGoal.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$StudyPlanToJson(StudyPlan instance) => <String, dynamic>{
      'subject': instance.subject,
      'examDate': instance.examDate.toIso8601String(),
      'learningGoals': instance.learningGoals,
    };

LearningGoal _$LearningGoalFromJson(Map<String, dynamic> json) {
  return LearningGoal(
    description: json['description'] as String,
    quantity: LearningGoal._intFromString(json['quantity']),
    quantifier: json['quantifier'] as String,
  );
}

Map<String, dynamic> _$LearningGoalToJson(LearningGoal instance) =>
    <String, dynamic>{
      'description': instance.description,
      'quantity': LearningGoal._intToString(instance.quantity),
      'quantifier': instance.quantifier,
    };
