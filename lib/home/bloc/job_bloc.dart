import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:tut/models/job_models.dart';
import 'package:tut/saved/saved_item.dart';

import 'package:url_launcher/url_launcher.dart';

part 'job_event.dart';
part 'job_state.dart';

class JobBloc extends Bloc<JobEvent, JobState> {
  JobBloc() : super(JobInitial()) {
    on<JobDisplayedEvent>(jobDisplayedEvent);
    on<JobSearchEvent>(jobSearchEvent);
    on<JobSavedEvent>(jobSavedEvent);
    on<ApplyForJobs>(applyForJobs);
    on<FetchUserName>(fetchUserName);
  }

  FutureOr<void> jobDisplayedEvent(
      JobDisplayedEvent event, Emitter<JobState> emit) async {
    try {
      emit(JobLoadingState());
      String apiKey = "c160af37b20f3df91b325ef542504dbc";
      String appId = "2765d912";
      String url =
          "https://api.adzuna.com/v1/api/jobs/za/search/1?app_id=$appId&app_key=$apiKey";

      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is Map<String, dynamic> && data.containsKey('results')) {
          List<JobUiModel> jobs = (data['results'] as List)
              .map((jobJson) => JobUiModel.fromJson(jobJson))
              .toList();
          emit(JobLoadedState(jobs: jobs));
        }
      }
    } catch (e) {
      emit(JobFailedState());
    }
  }

  FutureOr<void> jobSearchEvent(JobSearchEvent event, Emitter<JobState> emit) async {
    try {
      emit(JobLoadingState());
      String apiKey = "c160af37b20f3df91b325ef542504dbc";
      String appId = "2765d912";
      String url =
          "https://api.adzuna.com/v1/api/jobs/za/search/1?app_id=$appId&app_key=$apiKey&what=${event.query}";

      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is Map<String, dynamic> && data.containsKey('results')) {
          List<JobUiModel> jobs = (data['results'] as List)
              .map((jobJson) => JobUiModel.fromJson(jobJson))
              .toList();
          emit(JobLoadedState(jobs: jobs));
        }
      }
    } catch (e) {
      emit(JobFailedState());
    }
  }

  FutureOr<void> jobSavedEvent(JobSavedEvent event, Emitter<JobState> emit) {
    savedItem.add(event.job);
    emit(JobSavedToSavedEvent());
  }

  FutureOr<void> applyForJobs(ApplyForJobs event, Emitter<JobState> emit) async {
    final Uri applyLink = Uri.parse(event.applyLink);

    if (await canLaunchUrl(applyLink)) {
      await launchUrl(applyLink, mode: LaunchMode.externalApplication);
    } else {}
  }

  FutureOr<void> fetchUserName(FetchUserName event, Emitter<JobState> emit) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String userId = user.uid;

        DocumentSnapshot userDoc =
            await FirebaseFirestore.instance.collection('users').doc(userId).get();

        String userName = userDoc['name'];
        emit(FetchUserNameLoadedState(username: userName));
      } else {
        emit(FetchUserNameFailedState());
      }
    } catch (e) {
      emit(FetchUserNameFailedState());
    }
  }
}
