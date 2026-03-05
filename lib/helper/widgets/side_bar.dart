import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perplexity_clone/core/constants/app_strings.dart';
import '../../core/themes/app_colors.dart';
import '../../domain/controller/sidebar_controller.dart';
import '../../main.dart';

class SideBar extends StatelessWidget {
  SideBar({super.key});

  final SideBarController controller = Get.put(SideBarController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedContainer(
        duration: const Duration(milliseconds: 100),

        width: controller.isCollapsed.value ? mq.width * .035 : mq.width * .12,

        color: AppColors.sideNav,
        child: Column(
          crossAxisAlignment: controller.isCollapsed.value
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            SizedBox(height: mq.height * .025),

            _mainIcon(Icons.auto_awesome_mosaic, () {}),

            _appIcon(CupertinoIcons.add, () {}, AppStrings.home),
            _appIcon(CupertinoIcons.search, () {}, AppStrings.search),
            _appIcon(Icons.language, () {}, AppStrings.disCover),
            _appIcon(Icons.auto_awesome, () {}, AppStrings.aiTools),
            _appIcon(CupertinoIcons.cloud, () {}, AppStrings.cloud),

            const Spacer(),

            _appIcon(
              controller.isCollapsed.value
                  ? Icons.keyboard_arrow_right
                  : Icons.keyboard_arrow_left,
              controller.toggleSidebar,
              AppStrings.appName,
            ),
          ],
        ),
      ),
    );
  }

  InkWell _mainIcon(IconData icon, VoidCallback? onTap) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        margin: EdgeInsets.symmetric(
          vertical: mq.height * .025,
          horizontal: controller.isCollapsed.value ? 0 : mq.width * .010,
        ),
        child: Icon(icon, color: AppColors.whiteColor, size: mq.height * .040),
      ),
    );
  }

  InkWell _appIcon(IconData icon, VoidCallback? onTap, String text) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: mq.height * .005),
        child: Row(
          mainAxisAlignment: controller.isCollapsed.value
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              margin: EdgeInsets.symmetric(
                vertical: mq.height * .015,
                horizontal: controller.isCollapsed.value ? 0 : mq.width * .010,
              ),
              child: Icon(
                icon,
                color: AppColors.iconGrey,
                size: mq.height * .025,
              ),
            ),

            if (!controller.isCollapsed.value)
              Expanded(
                child: Text(
                  text,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: mq.height * .020,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
