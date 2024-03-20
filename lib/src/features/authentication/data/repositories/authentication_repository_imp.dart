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
      required String avatar,
      required String article
      }) async {
    try {
      await _remoteDataSource.createUser(
          createdAt: createdAt, name: name, avatar: avatar,article:article);
      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  ResultVoid updateUser(
      {required String id,
      required String createdAt,
      required String name,
      required String avatar,
      required String article}) async {
    try {
      await _remoteDataSource.updateUser(
          id: id, createdAt: createdAt, name: name, avatar: avatar,article: article);
      return const Right(null);
    } on APIException catch (e) {
      return left(APIFailure.fromException(e));
    }
  }

  ResultVoid deleteUser(
      {required String id,
      required String createdAt,
      required String name,
      required String avatar}) async {
    try {
      await _remoteDataSource.deleteUser(
          id: id, createdAt: createdAt, name: name, avatar: avatar);
      return const Right(null);
    } on APIException catch (e) {
      return left(APIFailure.fromException(e));
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

  ResultFuture<List<User>> getSingleUser({required String id}) async {
    try {
      final result = await _remoteDataSource.getSingleUser(id: id);
      return Right(result);
    } on APIException catch (e) {
      return left(APIFailure.fromException(e));
    }
  }
}
