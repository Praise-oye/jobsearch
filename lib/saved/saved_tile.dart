import 'package:flutter/material.dart';
import 'package:tut/models/job_models.dart';
import 'package:tut/saved/bloc/saved_bloc.dart';
import 'package:tut/shared/default_button.dart';



class SavedCard extends StatelessWidget {
  final JobUiModel jobUiModel;
  final SavedBloc savedBloc;
  const SavedCard({
    super.key,
    required this.jobUiModel,
    required this.savedBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(
          color: Colors.white,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              jobUiModel.title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              jobUiModel.company,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: Colors.white,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    jobUiModel.location,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.attach_money,
                  color: Colors.white,
                ),
                const SizedBox(width: 4),
                Text(
                  jobUiModel.salary,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 16),
                const Icon(
                  Icons.work_outline,
                  color: Colors.white,
                ),
                const SizedBox(width: 4),
                Text(
                  jobUiModel.jobType,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                  child: DefaultButton(
                    text: "Apply",
                    onPressed: () {
                      savedBloc.add(ApplyForJobs(jobUiModel.applyLink));
                    },
                    buttonColor: Colors.purple,
                    textColor: Colors.white,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DefaultButton(
                    text: "Remove",
                    onPressed: () {
                    savedBloc.add(SavedRemovedEvent(jobUiModel: jobUiModel));
                    },
                    buttonColor: Colors.purple,
                    textColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
