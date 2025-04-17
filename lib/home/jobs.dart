
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tut/home/bloc/job_bloc.dart';
import 'package:tut/home/job_card.dart';
import 'package:tut/home/widget/header.dart';
import 'package:tut/login/bloc/login_bloc.dart';
import 'package:tut/shared/job_style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    jobBloc.add(JobDisplayedEvent());
    
    super.initState();
  }

  final JobBloc jobBloc = JobBloc();
  final LoginBloc loginBloc = LoginBloc();
  final TextEditingController searchController = TextEditingController();
  void _onSearch() {
    final query = searchController.text.trim();
    if (query.isNotEmpty) {
      jobBloc.add(JobSearchEvent(query: query));
    } else {
      jobBloc.add(JobDisplayedEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 const Header(),
                  
                  Text(
                    'Jobs',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[300],
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                      controller: searchController,
                      cursorColor: JobStyle.white,
                      style: const TextStyle(color: JobStyle.white),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        suffixIcon: Icon(
                          Icons.search,
                          color: JobStyle.white,
                        ),
                        hintText: "Search",
                        hintStyle: TextStyle(
                          color: JobStyle.white,
                        ),
                      ),
                      onChanged: (query) => _onSearch()),
                  const SizedBox(height: 20),
                  BlocConsumer<JobBloc, JobState>(
                    buildWhen: (previous, current) {
                      return current is! JobSavedToSavedEvent;
                    },
                    bloc: jobBloc,
                    listener: (context, state) {
                      if (state is JobSavedToSavedEvent) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Job added to saved'),
                          ),
                        );
                      }
                      
                    },
                    builder: (context, state) {
                      if (state is JobLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is JobLoadedState) {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: state.jobs.length,
                            itemBuilder: (context, index) {
                              return JobCard(
                                  jobUiModel: state.jobs[index], jobBloc: jobBloc);
                            },
                          ),
                        );
                      } else if (state is JobFailedState) {
                        return Center(
                          child: Text('Failed to load jobs: ${state.message}'),
                        );
                      } else {
                        return const Center(
                          child: Text('No data available'),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}