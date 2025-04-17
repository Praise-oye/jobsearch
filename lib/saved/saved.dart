import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tut/saved/bloc/saved_bloc.dart';
import 'package:tut/saved/saved_tile.dart';


class Saved extends StatefulWidget {
  const Saved({
    super.key,
  });

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  @override
  void initState() {
    // TODO: implement initState
    savedBloc.add(SavedListingLoadedEvent());
    super.initState();
  }

  final SavedBloc savedBloc = SavedBloc();
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: SafeArea(
                child: Column(
                  children: [
                    const Text(
                      "Saved Jobs",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    BlocConsumer<SavedBloc, SavedState>(
                        bloc: savedBloc,
                        listener: (context, state) {
                          if (state is SavedErrorState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("error")),
                            );
                          }
                          
                        },
                        builder: (context, state) {
                          if (state is SavedLoadedState) {
                            if (state.savedJobs.isEmpty) {
                              return const Center(
                                child: Text(
                                  "No Jobs saved",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            } else {
                              return Expanded(
                                child: ListView.builder(
                                  itemCount: state.savedJobs.length,
                                  itemBuilder: (context, index) {
                                    return SavedCard(
                                      jobUiModel: state.savedJobs[index],
                                      savedBloc: savedBloc,
                                    );
                                  },
                                ),
                              );
                            }
                          } else {
                            return const Center(
                              child: Text(
                                "No Jobs saved",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            );
                          }
                        })
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
