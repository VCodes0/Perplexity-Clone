import 'package:perplexity_clone/core/constants/app_strings.dart';
import '../../core/themes/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../main.dart';

class SearchInputBox extends StatelessWidget {
  const SearchInputBox({super.key});

  @override
  Widget build(BuildContext context) {
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
                TextField(
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: responsive.height * 0.02,
                  ),
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
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.auto_awesome,
                          color: AppColors.iconGrey,
                          size: responsive.height * 0.02,
                        ),
                        SizedBox(width: responsive.width * 0.01),
                        Text(
                          AppStrings.focus,
                          style: TextStyle(
                            color: AppColors.iconGrey,
                            fontSize: responsive.height * 0.018,
                          ),
                        ),
                      ],
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
                    Container(
                      height: responsive.height * 0.045,
                      width: responsive.height * 0.045,
                      decoration: const BoxDecoration(
                        color: AppColors.submitButton,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_forward,
                        color: AppColors.whiteColor,
                        size: responsive.height * 0.022,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
