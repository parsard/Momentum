import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:momentum/core/constants/app_colors.dart';
import 'package:momentum/ui/widgets/add_button.dart';
import 'package:momentum/ui/widgets/footer.dart';
import 'package:momentum/ui/widgets/time_entry_card.dart';
import 'package:momentum/viewModel/time_tracker_view_model.dart';

class TimeTrackerPage extends StatelessWidget {
  const TimeTrackerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TimeTrackerViewModel>(
      child: Stack(children: [AddButton(), AppFooter()]),
      builder: (context, trackerViewModel, child) {
        final timeEntries = trackerViewModel.timeEntries;

        return Scaffold(
          backgroundColor: AppColors.green_50,
          body: Stack(
            children: [
              if (timeEntries.isEmpty) ...[
                Positioned(
                  top: 250,
                  left: 90,
                  child: Image.asset('assets/trackerPage/Girl1.png'),
                ),
                Positioned(
                  bottom: 200,
                  right: 30,
                  child: Container(
                    width: 246,
                    height: 65,
                    decoration: BoxDecoration(
                      color: AppColors.myOrange,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Center(
                      child: Text(
                        'Click here to start your first time tracking.',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontFamily: 'Mulish',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ] else ...[
                SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Today',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Mulish',
                              ),
                            ),
                            const Icon(Icons.keyboard_arrow_down),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: timeEntries.length,
                          itemBuilder: (context, index) {
                            final entry = timeEntries[index];
                            return TimeEntryCard(
                              entry: entry,
                              onDelete: () {
                                trackerViewModel.removeEntry(index);
                              }, // Delete action
                              onFavorite: () {
                                trackerViewModel.toggleFavorite(
                                  entry.projectName +
                                      entry.startTime.toString(),
                                );
                              },
                              onNameChange: (newName) {
                                trackerViewModel.updateEntryName(
                                  index,
                                  newName,
                                );
                              }, // Toggle favorite
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 70),
                    ],
                  ),
                ),
              ],
              if (child != null) child,
            ],
          ),
        );
      },
    );
  }
}
