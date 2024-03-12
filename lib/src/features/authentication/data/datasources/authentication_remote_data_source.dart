import 'dart:convert';

import 'package:industry/core/errors/exception.dart';
import 'package:industry/core/utils/constants.dart';
import 'package:industry/core/utils/typedef.dart';
import 'package:industry/src/features/authentication/data/models/user_model.dart';
import 'package:dio/dio.dart';

abstract class AuthenticationRemoteDataSource {
  Future<void> createUser(
      {required String createdAt,
      required String name,
      required String avatar});

  Future<List<UserModel>> getUser();
}

const kCreateUserEndpoint = '/users';
const kGetUserEndpoint = '/users';

class AuthenticationRemoteDataSourceImp
    implements AuthenticationRemoteDataSource {
  @override
  Future<void> createUser(
      {required String createdAt,
      required String name,
      required String avatar}) async {
    try {
      Response response = await Dio().post('$kbaseUrl$kCreateUserEndpoint',
          data: jsonEncode(
              {'createdAt': createdAt, 'name': name, 'avatar': avatar}));

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(message: response.data, statusCode: 100);
      }
    } on APIException {
      rethrow; //inorder to not use from catch block
    } on Exception catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<UserModel>> getUser() async {
    try {
      Response response = await Dio().get('$kbaseUrl$kGetUserEndpoint');
      print(response);
      if (response.statusCode != 200) {
        throw APIException(message: response.data, statusCode: 100);
      }
      return List<DataMap>.from(response.data as List)
          .map((userData) => UserModel.fromMap(userData))
          .toList();
    } on APIException {
      rethrow; //inorder to not use from catch block
    } on Exception catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}
