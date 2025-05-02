import 'package:flutter/material.dart';
import 'package:momentum/ui/view/time_tracker_page.dart';
import 'package:momentum/ui/widgets/footer.dart';

class TimeListPage extends StatelessWidget {
  const TimeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TimeTrackerPage()),
              );
            },
            child: Icon(Icons.arrow_back),
          ),
        ],
      ),
    );
  }
}
