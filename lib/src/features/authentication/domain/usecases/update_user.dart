import 'package:equatable/equatable.dart';
import 'package:industry/core/usecase/usecase.dart';
import 'package:industry/core/utils/typedef.dart';
import 'package:industry/src/features/authentication/domain/repositories/authentication_repository.dart';

class UpdateUser extends UsecaseWithParams<void, UpdateUserParams> {
  const UpdateUser(this._repository);
  final AuthenticationRepository _repository;

  @override
  ResultVoid call(UpdateUserParams params) async => _repository.updateUser(
      id: params.id,
      createdAt: params.createdAt,
      name: params.name,
      avatar: params.avatar,
      article: params.article);
}

class UpdateUserParams extends Equatable {
  const UpdateUserParams(
      {required this.id,
      required this.createdAt,
      required this.name,
      required this.avatar,
      required this.article});

  // const UpdateUserParams.empty()
  //     : this(
  //           id:id,
  //           createdAt: '_empty.createdAt',
  //           name: '_empty.name',
  //           avatar: '_empty.avatar');
  final String id;
  final String createdAt;
  final String name;
  final String avatar;
  final String article;

  List<Object?> get props => [id, createdAt, name, avatar,article];
}
