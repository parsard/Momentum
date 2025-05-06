import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:momentum/core/constants/app_colors.dart';
import 'package:momentum/core/constants/svg_path.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final String iconPath;
  final VoidCallback onPressed;
  const CustomOutlinedButton({
    super.key,
    required this.text,
    required this.iconPath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColors.babyPowder,
        side: BorderSide(color: AppColors.green_500),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(iconPath),
          SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.night,
            ),
          ),
        ],
      ),
    );
  }
}
