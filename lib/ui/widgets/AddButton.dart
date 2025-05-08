import 'package:flutter/material.dart';
import 'package:momentum/ui/widgets/TimerInputDialog.dart';
import 'package:momentum/viewModel/time_list_view_model.dart';
import 'package:momentum/viewModel/time_tracker_view_model.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';

class AddButton extends StatelessWidget {
  const AddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 130,
          right: 20,
          child: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder:
                    (context) =>
                        ChangeNotifierProvider(create: (_) => TimeTrackerViewModel(), child: TimerInputDialog()),
              );
            },
            backgroundColor: AppColors.green_500,
            shape: CircleBorder(),
            child: Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
