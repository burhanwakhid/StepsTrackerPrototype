import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

@immutable
class HistoryPointModel {
  final String id;
  final int point;
  final Timestamp createdAt;

  HistoryPointModel({
    required this.id,
    required this.point,
    required this.createdAt,
  });

  HistoryPointModel.fromJson(Map<String, Object?> json)
      : this(
          id: json['id_user']! as String,
          point: json['point']! as int,
          createdAt: json['created_at']!.runtimeType == String
              ? Timestamp.fromDate(
                  DateTime.parse(json['created_at']! as String))
              : json['created_at']! as Timestamp,
        );

  Map<String, Object?> toJson() {
    return {
      'id_user': id,
      'point': point,
      'created_at': createdAt.toDate().toIso8601String(),
    };
  }
}
