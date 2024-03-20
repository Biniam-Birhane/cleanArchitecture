import 'package:equatable/equatable.dart';
import 'package:industry/core/usecase/usecase.dart';
import 'package:industry/core/utils/typedef.dart';
import 'package:industry/src/features/authentication/domain/entities/user.dart';
import 'package:industry/src/features/authentication/domain/repositories/authentication_repository.dart';

class GetSingleUser extends UsecaseWithParams<List<User>, GetSingleUserParams> {
  GetSingleUser(this._repository);
  final AuthenticationRepository _repository;
  @override
  ResultFuture<List<User>> call(GetSingleUserParams params) async => _repository.getSingleUser(id:params.id);
}

class GetSingleUserParams extends Equatable {
  const GetSingleUserParams({required this.id});
  final String id;

  List<Object> get props => [id];
}
