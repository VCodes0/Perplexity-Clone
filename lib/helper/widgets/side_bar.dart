import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/themes/app_colors.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  bool isCollapsed = false;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return LayoutBuilder(
      builder: (context, constraints) {
        double collapsedWidth = mq.width * .06;
        double expandedWidth = mq.width * .13;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: isCollapsed ? collapsedWidth : expandedWidth,
          color: AppColors.sideNav,
          child: Column(
            crossAxisAlignment: isCollapsed
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            children: [
              SizedBox(height: mq.height * .025),

              _mainIcon(Icons.auto_awesome_mosaic, () {}, 'NIKA-AI', mq),

              _appIcon(CupertinoIcons.add, () {}, 'HOME', mq),
              _appIcon(CupertinoIcons.search, () {}, 'SEARCH', mq),
              _appIcon(Icons.language, () {}, 'DISCOVER', mq),
              _appIcon(Icons.auto_awesome, () {}, 'AI TOOLS', mq),
              _appIcon(CupertinoIcons.cloud, () {}, 'CLOUD', mq),

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
                'COLLAPSE',
                mq,
              ),
            ],
          ),
        );
      },
    );
  }

  InkWell _mainIcon(IconData icon, VoidCallback? onTap, String text, Size mq) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: isCollapsed
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: EdgeInsets.symmetric(
              vertical: mq.height * .025,
              horizontal: isCollapsed ? 0 : mq.width * .01,
            ),
            child: Icon(
              icon,
              color: AppColors.whiteColor,
              size: mq.height * .04,
            ),
          ),
          if (!isCollapsed)
            Expanded(
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: mq.height * .023,
                ),
              ),
            ),
        ],
      ),
    );
  }

  InkWell _appIcon(IconData icon, VoidCallback? onTap, String text, Size mq) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: mq.height * .005),
        child: Row(
          mainAxisAlignment: isCollapsed
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: EdgeInsets.symmetric(
                vertical: mq.height * .015,
                horizontal: isCollapsed ? 0 : mq.width * .01,
              ),
              child: Icon(
                icon,
                color: AppColors.iconGrey,
                size: mq.height * .025,
              ),
            ),

            if (!isCollapsed)
              Expanded(
                child: Text(
                  text,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: mq.height * .02,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
