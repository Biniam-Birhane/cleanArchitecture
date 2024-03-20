import 'dart:convert';

import 'package:industry/core/utils/typedef.dart';
import 'package:industry/src/features/authentication/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.createdAt,
    required super.name,
    required super.avatar,
    required super.article
  });

  
  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source) as DataMap);

  UserModel.fromMap(DataMap map)
      : this(
            avatar: map['avatar'] as String,
            id: map['id'] as String,
            createdAt: map['createdAt'] as String,
            name: map['name'],
            article: map['article']);

  UserModel copyWith({
    String? id,
    String? createdAt,
    String? name,
    String? avatar,
    String? article,
  }) {
    return UserModel(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        name: name ?? this.name,
        avatar: avatar ?? this.avatar,
        article: article ?? this.article);
  }

  DataMap toMap() =>
      {"id": id, "createdAt": createdAt, "name": name, "avatar": avatar, "article":article,};

  String toJson() => jsonEncode(toMap());
}
