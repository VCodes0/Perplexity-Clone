import 'package:perplexity_clone/core/themes/app_colors.dart';
import 'package:perplexity_clone/domain/controller/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../main.dart';

class ResultView extends StatelessWidget {
  const ResultView({super.key});

  @override
  Widget build(BuildContext context) {
    final QueryController controller = Get.find<QueryController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.sideNav,
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.whiteColor),
          onPressed: controller.clearSearch,
        ),
        title: Obx(() => Text(
              controller.searchResponse.value?.query ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                color: AppColors.whiteColor,
                fontWeight: FontWeight.w500,
                fontSize: responsive.height * 0.020,
              ),
            )),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: responsive.width * 0.015),
            child: TextButton.icon(
              onPressed: controller.clearSearch,
              icon: const Icon(Icons.add, color: AppColors.submitButton, size: 18),
              label: Text(
                'New Search',
                style: TextStyle(
                  color: AppColors.submitButton,
                  fontSize: responsive.height * 0.017,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.submitButton),
          );
        }

        final response = controller.searchResponse.value;
        if (response == null) {
          return Center(
            child: Text(
              'No results yet.',
              style: TextStyle(color: AppColors.textGrey),
            ),
          );
        }

        return SelectionArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: responsive.width * 0.06,
              vertical: responsive.height * 0.03,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Answer Section ───────────────────────────────────────
                _sectionHeader('Answer', Icons.auto_awesome, AppColors.submitButton),
                SizedBox(height: responsive.height * 0.015),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(responsive.width * 0.025),
                  decoration: BoxDecoration(
                    color: AppColors.searchBar,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.searchBarBorder),
                  ),
                  child: MarkdownBody(
                    data: response.answer,
                    shrinkWrap: true,
                    styleSheet: MarkdownStyleSheet(
                      p: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: responsive.height * 0.019,
                        height: 1.6,
                      ),
                      h1: GoogleFonts.inter(
                        color: AppColors.whiteColor,
                        fontSize: responsive.height * 0.028,
                        fontWeight: FontWeight.bold,
                      ),
                      h2: GoogleFonts.inter(
                        color: AppColors.whiteColor,
                        fontSize: responsive.height * 0.024,
                        fontWeight: FontWeight.bold,
                      ),
                      h3: GoogleFonts.inter(
                        color: AppColors.whiteColor,
                        fontSize: responsive.height * 0.021,
                        fontWeight: FontWeight.w600,
                      ),
                      strong: const TextStyle(
                        color: AppColors.submitButton,
                        fontWeight: FontWeight.bold,
                      ),
                      code: GoogleFonts.jetBrainsMono(
                        color: const Color(0xFF89D4CF),
                        backgroundColor: const Color(0xFF1A2332),
                        fontSize: responsive.height * 0.017,
                      ),
                      codeblockDecoration: BoxDecoration(
                        color: const Color(0xFF1A2332),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.searchBarBorder),
                      ),
                      blockquote: TextStyle(
                        color: AppColors.textGrey,
                        fontSize: responsive.height * 0.018,
                        fontStyle: FontStyle.italic,
                      ),
                      listBullet: const TextStyle(color: AppColors.submitButton),
                    ),
                  ),
                ),

                SizedBox(height: responsive.height * 0.04),

                // ── Sources Section ───────────────────────────────────────
                if (response.sources.isNotEmpty) ...[
                  _sectionHeader('Sources', Icons.link, AppColors.iconGrey),
                  SizedBox(height: responsive.height * 0.015),
                  ...response.sources.asMap().entries.map(
                    (entry) => _SourceCard(
                      index: entry.key + 1,
                      title: entry.value.title,
                      url: entry.value.url,
                      snippet: entry.value.snippet,
                    ),
                  ),
                ],

                SizedBox(height: responsive.height * 0.04),

                // ── Meta info ──────────────────────────────────────────────
                Center(
                  child: Text(
                    'Powered by ${response.modelUsed} · Mode: ${response.searchMode}',
                    style: TextStyle(
                      color: AppColors.iconGrey,
                      fontSize: responsive.height * 0.014,
                    ),
                  ),
                ),
                SizedBox(height: responsive.height * 0.03),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _sectionHeader(String title, IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: GoogleFonts.inter(
            color: AppColors.whiteColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _SourceCard extends StatelessWidget {
  final int index;
  final String title;
  final String url;
  final String snippet;

  const _SourceCard({
    required this.index,
    required this.title,
    required this.url,
    required this.snippet,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: responsive.height * 0.015),
      padding: EdgeInsets.all(responsive.width * 0.02),
      decoration: BoxDecoration(
        color: AppColors.searchBar,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.searchBarBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Index badge
          Container(
            width: 28,
            height: 28,
            margin: const EdgeInsets.only(right: 12, top: 2),
            decoration: BoxDecoration(
              color: AppColors.submitButton.withValues(alpha: 0.15),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.submitButton.withValues(alpha: 0.4)),
            ),
            child: Center(
              child: Text(
                '$index',
                style: const TextStyle(
                  color: AppColors.submitButton,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.w600,
                    fontSize: responsive.height * 0.018,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  url,
                  style: TextStyle(
                    color: AppColors.submitButton,
                    fontSize: responsive.height * 0.015,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.submitButton,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                if (snippet.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    snippet,
                    style: TextStyle(
                      color: AppColors.textGrey,
                      fontSize: responsive.height * 0.016,
                      height: 1.5,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
