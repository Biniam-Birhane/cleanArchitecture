import 'package:equatable/equatable.dart';
import 'package:industry/core/usecase/usecase.dart';
import 'package:industry/core/utils/typedef.dart';
import 'package:industry/src/features/authentication/domain/repositories/authentication_repository.dart';

class DeleteUser extends UsecaseWithParams<void, DeleteUserParams> {
  const DeleteUser(this._repository);
  final AuthenticationRepository _repository;

  @override
  ResultVoid call(DeleteUserParams params) async => _repository.deleteUser(
      id: params.id,
      createdAt: params.createdAt,
      name: params.name,
      avatar: params.avatar);
}

class DeleteUserParams extends Equatable {
  const DeleteUserParams(
      {required this.id,required this.createdAt, required this.name, required this.avatar});

  // const DeleteUserParams.empty()
  //     : this(
  //           id:id,
  //           createdAt: '_empty.createdAt',
  //           name: '_empty.name',
  //           avatar: '_empty.avatar');
  final String id;
  final String createdAt;
  final String name;
  final String avatar;

  List<Object?> get props => [id, createdAt, name, avatar];
}
