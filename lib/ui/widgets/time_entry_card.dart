import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../model/TimeEntry.dart';
import 'package:hexcolor/hexcolor.dart';

class TimeEntryCard extends StatelessWidget {
  final TimeEntry entry;
  final VoidCallback onDelete;
  final VoidCallback onFavorite;
  final void Function(String) onNameChange;

  const TimeEntryCard({
    super.key,
    required this.entry,
    required this.onDelete,
    required this.onFavorite,
    required this.onNameChange,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      // Add sliding functionality
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => onFavorite(),
            backgroundColor: HexColor('#d3e5d3'),
            foregroundColor: HexColor('#4d504d'),
            icon: Icons.star,
            label: 'Favorite',
          ),
          SlidableAction(
            onPressed: (context) => onDelete(),
            backgroundColor: HexColor('#f5d3d3'),
            foregroundColor: HexColor('#e64133'),
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: HexColor('#e8f3e5'),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              Icons.play_arrow,
              color: Colors.black, // Replace with an SVG if needed
              size: 24,
            ),

            const SizedBox(width: 8),

            Expanded(
              child: TextFormField(
                initialValue: entry.projectName,
                style: TextStyle(
                  fontFamily: 'Mulish',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: HexColor('#121113'),
                ),
                decoration: const InputDecoration(border: InputBorder.none),
                onFieldSubmitted: (value) {
                  if (value.isNotEmpty) {
                    onNameChange(value);
                  }
                },
              ),
            ),

            // Duration Display
            Text(
              '${entry.duration.inHours}:${entry.duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${entry.duration.inSeconds.remainder(60).toString().padLeft(2, '0')}',
              style: TextStyle(
                fontFamily: 'Mulish',
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: HexColor('#898989'),
              ),
            ),

            // Conditional Star Next to Name
            if (entry.isFavorite) ...[
              Icon(Icons.star, color: HexColor('#dad676'), size: 18),
            ],
            // Three-dot Icon (for additional actions, if needed)
            const Icon(Icons.more_vert, size: 24, color: Colors.black),
          ],
        ),
      ),
    );
  }
}
