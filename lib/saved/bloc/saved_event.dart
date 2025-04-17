part of 'saved_bloc.dart';

@immutable
sealed class SavedEvent {}

class SavedListingLoadedEvent extends SavedEvent{
  
}

class SavedRemovedEvent extends SavedEvent{
  final JobUiModel jobUiModel;

  SavedRemovedEvent({required this.jobUiModel});


}

class ApplyForJobs extends SavedEvent{
  final String applyLink;

  ApplyForJobs(this.applyLink);
}