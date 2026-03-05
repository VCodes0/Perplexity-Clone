import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/themes/app_colors.dart';
import '../../main.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  bool isCollapsed = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      width: isCollapsed ? mq.width * .050 : mq.width * .090,
      color: AppColors.sideNav,
      child: Column(
        children: [
          SizedBox(height: mq.height * .025),
          Icon(
            Icons.auto_awesome_mosaic,
            color: AppColors.whiteColor,
            size: mq.height * .040,
          ),
          _appIcon(CupertinoIcons.add, () {}),
          _appIcon(CupertinoIcons.search, () {}),
          _appIcon(Icons.language, () {}),
          _appIcon(Icons.auto_awesome, () {}),
          _appIcon(CupertinoIcons.cloud, () {}),
          const Spacer(),
          _appIcon(
            isCollapsed
                ? Icons.keyboard_arrow_right
                : Icons.keyboard_arrow_left,
            () {
              setState(() {
                isCollapsed = !isCollapsed;
              });
            },
          ),
        ],
      ),
    );
  }

  InkWell _appIcon(IconData? icon, void Function()? onTap) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        margin: EdgeInsets.symmetric(vertical: mq.height * .025),
        child: Icon(icon, color: AppColors.iconGrey, size: mq.height * .025),
      ),
    );
  }
}
