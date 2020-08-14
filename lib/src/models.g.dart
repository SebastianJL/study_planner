// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudyPlanAdapter extends TypeAdapter<StudyPlan> {
  @override
  final int typeId = 0;

  @override
  StudyPlan read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudyPlan(
      subject: fields[0] as String,
      examDate: fields[1] as DateTime,
      learningGoals: (fields[2] as List)?.cast<LearningGoal>(),
    );
  }

  @override
  void write(BinaryWriter writer, StudyPlan obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.subject)
      ..writeByte(1)
      ..write(obj.examDate)
      ..writeByte(2)
      ..write(obj.learningGoals);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudyPlanAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LearningGoalAdapter extends TypeAdapter<LearningGoal> {
  @override
  final int typeId = 1;

  @override
  LearningGoal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LearningGoal(
      description: fields[0] as String,
      quantity: fields[1] as int,
      quantifier: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LearningGoal obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.description)
      ..writeByte(1)
      ..write(obj.quantity)
      ..writeByte(2)
      ..write(obj.quantifier);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LearningGoalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
