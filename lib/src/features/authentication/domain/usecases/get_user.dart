import 'package:industry/core/usecase/usecase.dart';
import 'package:industry/core/utils/typedef.dart';
import 'package:industry/src/features/authentication/domain/entities/user.dart';
import 'package:industry/src/features/authentication/domain/repositories/authentication_repository.dart';

class GetUsers extends UsecasesWithoutParams<List<User>> {
  const GetUsers(this._repository);
  final AuthenticationRepository _repository;

  @override
  ResultFuture<List<User>> call() async => _repository.getUser();
}
