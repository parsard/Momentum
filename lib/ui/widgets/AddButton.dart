import 'package:flutter/material.dart';
import 'package:momentum/ui/widgets/TimerInputDialog.dart';

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
                builder: (BuildContext context) {
                  return TimerInputDialog();
                },
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
