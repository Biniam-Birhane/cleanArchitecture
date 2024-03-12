import 'package:equatable/equatable.dart';
import 'package:industry/core/usecase/usecase.dart';
import 'package:industry/core/utils/typedef.dart';
import 'package:industry/src/features/authentication/domain/repositories/authentication_repository.dart';

class CreateUser extends UsecaseWithParams<void, CreateUserParams> {
  CreateUser(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultVoid call(CreateUserParams params) async => _repository.createUser(
      createdAt: params.createdAt, name: params.name, avatar: params.avatar);
}

class CreateUserParams extends Equatable {
  const CreateUserParams(
      {required this.createdAt, required this.name, required this.avatar});

  const CreateUserParams.empty()
      : this(
            createdAt: '_empty.createdAt',
            name: '_empty.name',
            avatar: '_empty.avatar');

  final String createdAt;
  final String name;
  final String avatar;

  List<Object?> get props => [createdAt, name, avatar];
}
