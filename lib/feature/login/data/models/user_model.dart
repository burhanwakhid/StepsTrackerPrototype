import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

@immutable
class UserModel {
  final String id;
  final String nama;
  final int totalStep;
  final int initialStep;
  final int point;
  final Timestamp createdAt;

  UserModel({
    required this.id,
    required this.nama,
    required this.initialStep,
    required this.point,
    required this.totalStep,
    required this.createdAt,
  });

  UserModel.fromJson(Map<String, Object?> json)
      : this(
          id: json['id_user']! as String,
          nama: json['nama_user']! as String,
          totalStep: json['total_step']! as int,
          point: json['point']! as int,
          initialStep: json['initial_step']! as int,
          createdAt: json['created_at']!.runtimeType == String
              ? Timestamp.fromDate(
                  DateTime.parse(json['created_at']! as String))
              : json['created_at']! as Timestamp,
        );

  Map<String, Object?> toJson() {
    return {
      'id_user': id,
      'nama_user': nama,
      'initial_step': initialStep,
      'total_step': totalStep,
      'point': point,
      'created_at': createdAt.toDate().toIso8601String(),
    };
  }
}
