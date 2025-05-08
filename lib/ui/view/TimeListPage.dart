import 'package:flutter/material.dart';
import 'package:momentum/ui/view/time_tracker_page.dart';
import 'package:momentum/ui/view/widgets/footer.dart';
import 'package:momentum/viewModel/time_tracker_view_model.dart';
import 'package:momentum/ui/widgets/AddButton.dart';
import 'package:momentum/viewModel/time_list_view_model.dart';
import 'package:momentum/viewModel/time_tracker_view_model.dart';
import 'package:provider/provider.dart';
import '../widgets/TimeEntryCard.dart';

class TimeListPage extends StatelessWidget {
  const TimeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<TimeListViewModel, TimeTrackerViewModel>(
      builder: (context, listVM, tracker, child) {
        final timeEntries = tracker.timeEntries;
        return Scaffold(
          body: Stack(
            children: [
              SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          Text(
                            'Today',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Mulish'),
                          ),
                          Icon(Icons.keyboard_arrow_down),
                          FloatingActionButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => TimeTrackerPage()));
                            },
                            child: Icon(Icons.arrow_back),
                          ),
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
                            onDelete: () => listVM.removeEntryByKey(entry.projectName + entry.startTime.toString()),
                            onFavorite: () => listVM.toggleFavorite(entry.projectName + entry.startTime.toString()),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 70),
                  ],
                ),
              ),
              AddButton(),
              AppFooter(),
            ],
          ),
        );
      },
    );
  }
}
