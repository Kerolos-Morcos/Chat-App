part of 'auth_bloc.dart';

abstract class AuthBlocState {}

class AuthInitial extends AuthBlocState {}

class LoginBlocLoading extends AuthBlocState {}

class LoginBlocSuccess extends AuthBlocState {}

class LoginBlocFailure extends AuthBlocState {
  final String errorMessage;
  LoginBlocFailure(this.errorMessage);
}

class RegisterBlocLoading extends AuthBlocState {}

class RegisterBlocSuccess extends AuthBlocState {}

class RegisterBlocFailure extends AuthBlocState {
  final String errorMessage;
  RegisterBlocFailure(this.errorMessage);
}
