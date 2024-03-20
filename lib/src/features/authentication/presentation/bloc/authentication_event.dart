part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
  @override
  List<Object> get props => [];
}

class CreateUserEvent extends AuthenticationEvent {
  const CreateUserEvent(
      {required this.createdAt,
      required this.name,
      required this.avatar,
      required this.article});

  final String createdAt;
  final String name;
  final String avatar;
  final String article;
  List<Object> get props => [createdAt, name, avatar,article];
}

class UpdateUserEvent extends AuthenticationEvent {
  const UpdateUserEvent(
      {required this.id,
      required this.createdAt,
      required this.name,
      required this.avatar,
      required this.article});
  final String id;
  final String createdAt;
  final String name;
  final String avatar;
  final String article;

  @override
  List<Object> get props => [id, createdAt, name, avatar, article];
}

class DeleteUserEvent extends AuthenticationEvent {
  const DeleteUserEvent(
      {required this.id,
      required this.createdAt,
      required this.name,
      required this.avatar});
  final String id;
  final String createdAt;
  final String name;
  final String avatar;

  @override
  List<Object> get props => [id, createdAt, name, avatar];
}

class GetSingleUserEvent extends AuthenticationEvent {
  const GetSingleUserEvent({required this.id});
  final String id;

  @override
  List<Object> get props => [id];
}

class GetUserEvent extends AuthenticationEvent {
  const GetUserEvent();
}
