import 'package:perplexity_clone/core/constants/app_strings.dart';
import 'package:perplexity_clone/core/themes/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'search_input_box.dart';
import '../../main.dart';

class SearchSection extends StatelessWidget {
  const SearchSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxWidth = constraints.hasBoundedWidth
            ? constraints.maxWidth * 0.9
            : mq.width * 0.9;

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.appTitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.ibmPlexMono(
                color: AppColors.whiteColor,
                fontSize: mq.width * 0.05,
                fontWeight: FontWeight.w400,
                height: 1.2,
                letterSpacing: -0.5,
              ),
            ),
            SizedBox(height: mq.height * 0.04),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: const SearchInputBox(),
            ),
          ],
        );
      },
    );
  }
}
