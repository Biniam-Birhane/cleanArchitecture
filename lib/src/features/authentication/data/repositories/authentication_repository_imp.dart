import 'package:dartz/dartz.dart';
import 'package:industry/core/errors/exception.dart';
import 'package:industry/core/errors/failure.dart';
import 'package:industry/core/utils/typedef.dart';
import 'package:industry/src/features/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:industry/src/features/authentication/domain/entities/user.dart';
import 'package:industry/src/features/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImp implements AuthenticationRepository {
  AuthenticationRepositoryImp(this._remoteDataSource);

  final AuthenticationRemoteDataSource _remoteDataSource;
  @override
  ResultVoid createUser(
      {required String createdAt,
      required String name,
      required String avatar}) async {
    try {
      await _remoteDataSource.createUser(
          createdAt: createdAt, name: name, avatar: avatar);
      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<User>> getUser() async {
    try {
      final result = await _remoteDataSource.getUser();
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
