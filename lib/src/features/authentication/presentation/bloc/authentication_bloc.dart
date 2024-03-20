import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:industry/core/errors/failure.dart';
import 'package:industry/src/features/authentication/domain/entities/user.dart';
import 'package:industry/src/features/authentication/domain/usecases/create_user.dart';
import 'package:industry/src/features/authentication/domain/usecases/delete_user.dart';
import 'package:industry/src/features/authentication/domain/usecases/get_single_user.dart';
import 'package:industry/src/features/authentication/domain/usecases/get_user.dart';
import 'package:industry/src/features/authentication/domain/usecases/update_user.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(
      {required CreateUser createUser,
      required GetUsers getUser,
      required UpdateUser updateUser,
      required DeleteUser deleteUser,
      required GetSingleUser getSingleUser})
      : _createUser = createUser,
        _getUsers = getUser,
        _getSingleUser = getSingleUser,
        _updateUser = updateUser,
        _deleteUser = deleteUser,
        super(AuthenticationInitial()) {
    on<CreateUserEvent>(_createUserHandler);
    on<UpdateUserEvent>(_updateUserHandler);
    on<GetUserEvent>(_getUserHandler);
    on<DeleteUserEvent>(_deleteUserHandler);
    on<GetSingleUserEvent>(_getSingleUserHandler);
  }

  final CreateUser _createUser;
  final GetUsers _getUsers;
  final UpdateUser _updateUser;
  final DeleteUser _deleteUser;
  final GetSingleUser _getSingleUser;
  Future<void> _createUserHandler(
    CreateUserEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const CreatingUser());

    final result = await _createUser(CreateUserParams(
      createdAt: event.createdAt,
      name: event.name,
      avatar: event.avatar,
      article: event.article
    ));
    //fold used for to send message for the dartz either
    result.fold((failure) => emit(AuthenticationError(failure.errorMessage)),
        (_) => emit(const UserCreated()));
  }

  Future<void> _updateUserHandler(
      UpdateUserEvent event, Emitter<AuthenticationState> emit) async {
    emit(const UpdatingUser());
    final result = await _updateUser(UpdateUserParams(
        id: event.id,
        createdAt: event.createdAt,
        name: event.name,
        avatar: event.avatar,article: event.article));
    result.fold((failure) => emit(AuthenticationError(failure.errorMessage)),
        (_) => emit(const UserUpdated()));
  }

  Future<void> _deleteUserHandler(
      DeleteUserEvent event, Emitter<AuthenticationState> emit) async {
    emit(const DeletingUser());
    final result = await _deleteUser(DeleteUserParams(
        id: event.id,
        createdAt: event.createdAt,
        name: event.name,
        avatar: event.avatar));
    result.fold((failure) => emit(AuthenticationError(failure.errorMessage)),
        (_) => emit(const UserDeleted()));
  }

  Future<void> _getUserHandler(
      GetUserEvent event, Emitter<AuthenticationState> emit) async {
    emit(const GettingUsers());

    final result = await _getUsers();
    result.fold((failure) => AuthenticationError(failure.errorMessage),
        (users) => emit(UsersLoaded(users)));
  }

  Future<void> _getSingleUserHandler(
      GetSingleUserEvent event, Emitter<AuthenticationState> emit) async {
    emit(const GettingUsers());
    final result = await _getSingleUser(GetSingleUserParams(id: event.id));
    result.fold((failure) => AuthenticationError(failure.errorMessage),
        (user) => emit(SingleUserLoaded(user)));
  }
}
