import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/constants/app_colors.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.only(top: 10),
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.green_50,
              boxShadow: [
                BoxShadow(
                  color: Color(0xB0BAA559).withAlpha(89),
                  offset: Offset(0, -4),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    'assets/footer/menu-unselect.svg',
                    width: 32,
                    height: 32,
                  ),
                ),

                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/todo');
                  },
                  icon: SvgPicture.asset(
                    'assets/footer/task-square-unselect.svg',
                    width: 32,
                    height: 32,
                  ),
                ),

                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    'assets/footer/calendar-unselect.svg',
                    width: 32,
                    height: 32,
                  ),
                ),

                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/tracker');
                  },
                  icon: SvgPicture.asset(
                    'assets/footer/timer-start-select.svg',
                    width: 32,
                    height: 32,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
