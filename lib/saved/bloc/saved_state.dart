part of 'saved_bloc.dart';

@immutable
sealed class SavedState {}

final class SavedInitial extends SavedState {}

final class SavedLoadedState extends SavedState {
  final List<JobUiModel> savedJobs;

  SavedLoadedState({required this.savedJobs});
}

final class SavedLoadingState extends SavedState {}

final class SavedErrorState extends SavedState {}

final class JobRemovedState extends SavedState{}