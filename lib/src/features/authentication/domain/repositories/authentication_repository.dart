
import 'package:industry/core/utils/typedef.dart';
import 'package:industry/src/features/authentication/domain/entities/user.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  //instead of writting the long datatype we can define it in the core folder as util so

  ResultVoid createUser(
      {required String createdAt,
      required String name,
      required String avatar});

  ResultFuture<List<User>> getUser();

  
  // Future <Either<Failure,void>> createUser({
  //   required String createdAt,
  //   required String name,
  //   required String avatar
  // });

  // Future <Either<Failure,List<User>>> getUser();
}
