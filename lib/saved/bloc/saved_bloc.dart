import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tut/models/job_models.dart';
import 'package:tut/saved/saved_item.dart';
import 'package:url_launcher/url_launcher.dart';



part 'saved_event.dart';
part 'saved_state.dart';

class SavedBloc extends Bloc<SavedEvent, SavedState> {
  SavedBloc() : super(SavedInitial()) {
    on<SavedListingLoadedEvent>(savedListingLoadedEvent);
    on<SavedRemovedEvent>(savedRemovedEvent);
    on<ApplyForJobs>(applyForJobs);
  }

  FutureOr<void> savedListingLoadedEvent(SavedListingLoadedEvent event, Emitter<SavedState> emit) {
    emit(SavedLoadedState(savedJobs: savedItem));
  }

  FutureOr<void> savedRemovedEvent(SavedRemovedEvent event, Emitter<SavedState> emit) {
    savedItem.remove(event.jobUiModel);
    emit(SavedLoadedState(savedJobs: savedItem));
   
  }
  FutureOr<void> applyForJobs(ApplyForJobs event, Emitter<SavedState> emit) async {
    final Uri applyLink = Uri.parse(event.applyLink);

    if (await canLaunchUrl(applyLink)) {
      await launchUrl(applyLink, mode: LaunchMode.externalApplication);
    } else {}
  }
}
