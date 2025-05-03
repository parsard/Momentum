import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:momentum/core/constants/app_colors.dart';
import '../../model/time_entry.dart';

class TimeEntryCard extends StatelessWidget {
  final TimeEntry entry;
  final VoidCallback? onDelete;
  final VoidCallback onFavorite;

  const TimeEntryCard({
    super.key,
    required this.entry,
    this.onDelete,
    required this.onFavorite,
  });

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(duration.inHours)}:${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}";
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(entry.projectName + entry.startTime.toString()),
      background: slideRightBackground(),
      secondaryBackground: slideLeftBackground(),
      onDismissed: (direction) {
        if (onDelete != null) onDelete!();
      },
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          return true; // delete
        } else if (direction == DismissDirection.startToEnd) {
          onFavorite();
          return false; // don't delete, just toggle favorite
        }
        return false;
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.green_100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Removed Play/Pause Button!
            Expanded(
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      entry.projectName,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        fontFamily: 'Mulish',
                      ),
                    ),
                  ),
                  if (entry.isFavorite)
                    Row(
                      children: [
                        const SizedBox(width: 8),
                        Icon(Icons.star, color: Colors.yellow[700], size: 18),
                      ],
                    ),
                ],
              ),
            ),
            const SizedBox(width: 24),
            Text(
              formatDuration(entry.duration),
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 16,
                fontFamily: 'Mulish',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget slideRightBackground() {
    return Container(
      color: Colors.yellow[600],
      alignment: Alignment.centerLeft,
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Icon(Icons.star, color: Colors.white, size: 32),
      ),
    );
  }

  Widget slideLeftBackground() {
    return Container(
      color: Colors.red[400],
      alignment: Alignment.centerRight,
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Icon(Icons.delete, color: Colors.white, size: 32),
      ),
    );
  }
}
