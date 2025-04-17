part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();
  
  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState{}

class LoginLoadedState extends LoginState{}

class LoginFailedState extends LoginState{}

class RegisterLoadingState extends LoginState{}

class RegisterLoadedState extends LoginState{}

class RegisterFailedState extends LoginState{
  final String error;

  const RegisterFailedState({required this.error});
}

class ResetLoadingState extends LoginState{}

class ResetLoadedState extends LoginState{}

class ResetFailedState extends LoginState{
  final String errorMessage;

  const ResetFailedState({required this.errorMessage});
}

class LogOutLoadedState extends LoginState{}

class LogOutFailedState extends LoginState{}