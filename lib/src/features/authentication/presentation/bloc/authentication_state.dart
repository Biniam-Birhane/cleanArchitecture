part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class CreatingUser extends AuthenticationState {
  const CreatingUser();
}

class GettingUsers extends AuthenticationState {
  const GettingUsers();
}

class UserCreated extends AuthenticationState {
  const UserCreated();
}

class UsersLoaded extends AuthenticationState {
  const UsersLoaded(this.users);
  final List<User> users;
  @override
  List<Object> get props => users.map((user) => user.id).toList();
}

class AuthenticationError extends AuthenticationState {
  const AuthenticationError(this.message);
  final String message;
  List<Object> get props => [message];
}