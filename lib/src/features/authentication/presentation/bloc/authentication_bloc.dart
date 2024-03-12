import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:industry/src/features/authentication/domain/entities/user.dart';
import 'package:industry/src/features/authentication/domain/usecases/create_user.dart';
import 'package:industry/src/features/authentication/domain/usecases/get_user.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(
      {required CreateUser createUser, required GetUsers getUser})
      : _createUser = createUser,
        _getUsers = getUser,
        super(AuthenticationInitial()) {
    on<CreateUserEvent>(_createUserHandler);
    on<GetUserEvent>(_getUserHandler);
  }

  final CreateUser _createUser;
  final GetUsers _getUsers;

  Future<void> _createUserHandler(
    CreateUserEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const CreatingUser());

    final result = await _createUser(CreateUserParams(
      createdAt: event.createdAt,
      name: event.name,
      avatar: event.avatar,
    ));
    //fold used for to send message for the dartz either
    result.fold((failure) => emit(AuthenticationError(failure.errorMessage)),
        (_) => emit(const UserCreated()));
  }

  Future<void> _getUserHandler(
      GetUserEvent event, Emitter<AuthenticationState> emit) async {
    emit(const GettingUsers());

    final result = await _getUsers();
    result.fold((failure) => AuthenticationError(failure.errorMessage),
        (users) => emit(UsersLoaded(users)));
  }
}
