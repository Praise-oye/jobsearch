part of 'job_bloc.dart';

@immutable
sealed class JobState {}

final class JobInitial extends JobState {}

class JobLoadingState extends JobState{}

class JobLoadedState extends JobState{
   final List<JobUiModel> jobs;

  JobLoadedState({required this.jobs});
}

class JobFailedState extends JobState{
  get message => null;
}

class JobSavedLoadedState extends JobState{
  final List<JobUiModel> savedJobs;

  JobSavedLoadedState({required this.savedJobs});
}

class JobSavedToSavedEvent extends JobState{}

class FetchUserNameLoadedState extends JobState{
  final String username;

  FetchUserNameLoadedState({required this.username});
}

class FetchUserNameLoadingState extends JobState{}

class FetchUserNameFailedState extends JobState{}