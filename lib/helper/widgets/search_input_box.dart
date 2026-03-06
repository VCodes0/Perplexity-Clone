import 'package:perplexity_clone/core/constants/app_strings.dart';
import 'package:perplexity_clone/domain/controller/search_controller.dart';
import '../../core/themes/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../main.dart';

class SearchInputBox extends StatelessWidget {
  const SearchInputBox({super.key});

  @override
  Widget build(BuildContext context) {
    final QueryController controller = Get.find<QueryController>();

    return LayoutBuilder(
      builder: (context, constraints) {
        final double containerWidth = constraints.hasBoundedWidth
            ? constraints.maxWidth * 0.85
            : responsive.width * 0.85;

        return Center(
          child: Container(
            width: containerWidth,
            padding: EdgeInsets.symmetric(
              horizontal: responsive.width * 0.02,
              vertical: responsive.height * 0.015,
            ),
            decoration: BoxDecoration(
              color: AppColors.searchBar,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.searchBarBorder, width: 1),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ── Text field ─────────────────────────────────────────────
                TextField(
                  controller: controller.textController,
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: responsive.height * 0.02,
                  ),
                  onSubmitted: (_) => controller.search(),
                  decoration: InputDecoration(
                    hintText: AppStrings.searchHintText,
                    hintStyle: TextStyle(
                      color: AppColors.textGrey,
                      fontSize: responsive.height * 0.02,
                    ),
                    border: InputBorder.none,
                  ),
                ),
                SizedBox(height: responsive.height * 0.015),

                // ── Bottom row ─────────────────────────────────────────────
                Obx(() => Row(
                  children: [
                    // Focus mode selector
                    GestureDetector(
                      onTap: () => _showModeMenu(context, controller),
                      child: Row(
                        children: [
                          Icon(
                            Icons.auto_awesome,
                            color: AppColors.iconGrey,
                            size: responsive.height * 0.02,
                          ),
                          SizedBox(width: responsive.width * 0.005),
                          Text(
                            controller.selectedMode.value.capitalizeFirst!,
                            style: TextStyle(
                              color: AppColors.iconGrey,
                              fontSize: responsive.height * 0.018,
                            ),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            color: AppColors.iconGrey,
                            size: responsive.height * 0.02,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: responsive.width * 0.04),
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.add_circled,
                          color: AppColors.iconGrey,
                          size: responsive.height * 0.02,
                        ),
                        SizedBox(width: responsive.width * 0.01),
                        Text(
                          AppStrings.attach,
                          style: TextStyle(
                            color: AppColors.iconGrey,
                            fontSize: responsive.height * 0.018,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),

                    // Submit button
                    GestureDetector(
                      onTap: controller.isLoading.value ? null : controller.search,
                      child: Container(
                        height: responsive.height * 0.045,
                        width: responsive.height * 0.045,
                        decoration: BoxDecoration(
                          color: controller.isLoading.value
                              ? AppColors.iconGrey
                              : AppColors.submitButton,
                          shape: BoxShape.circle,
                        ),
                        child: controller.isLoading.value
                            ? const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.whiteColor,
                                ),
                              )
                            : Icon(
                                Icons.arrow_forward,
                                color: AppColors.whiteColor,
                                size: responsive.height * 0.022,
                              ),
                      ),
                    ),
                  ],
                )),

                // ── Error message ───────────────────────────────────────────
                Obx(() {
                  if (controller.errorMessage.isNotEmpty) {
                    return Padding(
                      padding: EdgeInsets.only(top: responsive.height * 0.01),
                      child: Text(
                        '⚠️ ${controller.errorMessage.value}',
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: responsive.height * 0.016,
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showModeMenu(BuildContext context, QueryController controller) {
    final modes = controller.availableModes;
    final modeIcons = {
      'auto': Icons.auto_awesome,
      'academic': Icons.school,
      'writing': Icons.edit,
      'math': Icons.calculate,
      'video': Icons.play_circle_outline,
      'social': Icons.people,
    };

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.searchBar,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: modes.map((mode) {
            return ListTile(
              leading: Icon(
                modeIcons[mode] ?? Icons.auto_awesome,
                color: AppColors.iconGrey,
              ),
              title: Text(
                mode.capitalizeFirst!,
                style: const TextStyle(color: AppColors.whiteColor),
              ),
              onTap: () {
                controller.setMode(mode);
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
