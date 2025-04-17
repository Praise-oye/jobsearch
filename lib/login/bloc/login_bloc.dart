import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginScreenEvent>(loginScreenEvent);
    on<RegisterUserEvent>(registerUserEvent);
    on<ResetPasswordEvent>(resetPasswordEvent);
    on<LogOutEvent>(logOutEvent);
  }
//------------------------LOGIN------------------------------------------------------
  FutureOr<void> loginScreenEvent(
      LoginScreenEvent event, Emitter<LoginState> emit) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final firebaseDatabase = FirebaseFirestore.instance;

    try {
      emit(LoginLoadingState());

      final user = await firebaseAuth.signInWithEmailAndPassword(
          email: event.email, password: event.password);
      if (user.user == null) {
        emit(LoginFailedState());
        return;
      }
      final resultOwner = await firebaseDatabase
          .collection("users")
          .where("email", isEqualTo: user.user?.email)
          .get();
      if (resultOwner.docs.isNotEmpty) {
        emit(LoginLoadedState());
      } else if (resultOwner.docs.isEmpty) {
        emit(LoginFailedState());
      }
    } catch (e) {
      emit(LoginFailedState());
    }
  }

  //------------REGISTER USER------------------------------------------------

  FutureOr<void> registerUserEvent(
      RegisterUserEvent event, Emitter<LoginState> emit) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final firebaseDatabase = FirebaseFirestore.instance;

    try {
      emit(RegisterLoadingState());

      final rewardUser = await firebaseDatabase
          .collection("users")
          .where("email", isEqualTo: event.email)
          .get();

      if (rewardUser.docs.isNotEmpty) {
        emit(const RegisterFailedState(error: 'User Exists'));
      } else if (rewardUser.docs.isEmpty) {
        final createUser = await firebaseAuth.createUserWithEmailAndPassword(
            email: event.email, password: event.password);
        await firebaseDatabase.collection("users").doc(createUser.user?.uid).set({
          'email': event.email,
          'name': event.name
        });
        emit(RegisterLoadedState());
      }
    } catch (e) {
      emit(const RegisterFailedState(error: ''));
    }
  }

//----------------RESET------------------------------------------------------
  FutureOr<void> resetPasswordEvent(
      ResetPasswordEvent event, Emitter<LoginState> emit) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    try {
      emit(ResetLoadingState());
      await firebaseAuth.sendPasswordResetEmail(email: event.email);
      emit(ResetLoadedState());
    } catch (e) {
      emit(ResetFailedState(errorMessage: e.toString()));
    }
  }

  FutureOr<void> logOutEvent(LogOutEvent event, Emitter<LoginState> emit) async {
     final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    try{
      await firebaseAuth.signOut();
      emit(LogOutLoadedState());
    } catch (e) {
      emit(LogOutFailedState());
    }
  }
}
