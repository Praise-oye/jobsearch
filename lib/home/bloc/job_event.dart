part of 'job_bloc.dart';

@immutable
sealed class JobEvent {}

class JobInitialEvent extends JobEvent{}

class JobDisplayedEvent extends JobEvent{}

class JobSearchEvent extends JobEvent{
  final String query;

  JobSearchEvent({required this.query});
}

class JobSavedEvent extends JobEvent{
  final JobUiModel job;

  JobSavedEvent({required this.job});
}

class ApplyForJobs extends JobEvent{
  final String applyLink;

  ApplyForJobs(this.applyLink);

}

class FetchUserName extends JobEvent{}


