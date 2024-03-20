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

class UpdatingUser extends AuthenticationState {
  const UpdatingUser();
}

class DeletingUser extends AuthenticationState {
  const DeletingUser();
}

class UserCreated extends AuthenticationState {
  const UserCreated();
}

class UserUpdated extends AuthenticationState {
  const UserUpdated();
}

class UserDeleted extends AuthenticationState {
  const UserDeleted();
}

class UsersLoaded extends AuthenticationState {
  const UsersLoaded(this.users);
  final List<User> users;
  @override
  List<Object> get props => users.map((user) => user.id).toList();
}

class SingleUserLoaded extends AuthenticationState {
  const SingleUserLoaded(this.user);
  final List<User> user; 
}



class AuthenticationError extends AuthenticationState {
  const AuthenticationError(this.message);
  final String message;
  List<Object> get props => [message];
}
