part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginScreenEvent extends LoginEvent{
  final String email;
  final String password;

  const LoginScreenEvent({required this.email, required this.password});
}

class RegisterUserEvent extends LoginEvent{
  final String email;
  final String password;
  final String name;

  const RegisterUserEvent({required this.email, required this.password, required this.name});
}

class ResetPasswordEvent extends LoginEvent{
  final String email;

  const ResetPasswordEvent({required this.email});
}

class LogOutEvent extends LoginEvent{
  
}