import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(
      {required this.id,
      required this.createdAt,
      required this.name,
      required this.avatar,
      required this.article});

  const User.empty()
      : this(
            id: "1",
            createdAt: '_empty.createdAt',
            name: '_empty.name',
            avatar: '_empty.avatar',
            article: '_empty.avatar');
  final String id;
  final String createdAt;
  final String name;
  final String avatar;
  final String article;

  List<Object?> get props => [id];
}
