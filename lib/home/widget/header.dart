import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tut/home/bloc/job_bloc.dart';
import 'package:tut/home/widget/logout.dart';
import 'package:tut/shared/job_style.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {

  final JobBloc jobBloc = JobBloc();

  @override
  void initState() {
    super.initState();
    jobBloc.add(FetchUserName());
  }

  @override
  void dispose() {
    jobBloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobBloc, JobState>(
      bloc: jobBloc,
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (state is FetchUserNameLoadedState)
              Text(
                'Hello, ${state.username}',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: JobStyle.white,
                ),
              )
            else if (state is FetchUserNameFailedState)
              const Text(
                'Hello, Guest',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: JobStyle.white,
                ),
              )
            else
              const CircularProgressIndicator(),
            const LogoutButton()
          ],
        );
      },
    );
  }
}

