import '../../helper/widgets/search_section.dart';
import '../../helper/widgets/side_bar.dart';
import '../../core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Row(
        children: [
          SideBar(),
          Expanded(
            child: Column(
              children: [
                Expanded(child: Center(child: const SearchSection())),
                FooterLinks(screenSize: screenSize),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FooterLinks extends StatelessWidget {
  final Size screenSize;
  const FooterLinks({super.key, required this.screenSize});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: screenSize.height * 0.03),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildLink('Pro'),
          SizedBox(width: screenSize.width * 0.02),
          _buildLink('Enterprise'),
          SizedBox(width: screenSize.width * 0.02),
          _buildLink('Store'),
          SizedBox(width: screenSize.width * 0.02),
          _buildLink('Blog'),
          SizedBox(width: screenSize.width * 0.02),
          _buildLink('Careers'),
          SizedBox(width: screenSize.width * 0.02),
          _buildLink('English (English)'),
        ],
      ),
    );
  }

  Widget _buildLink(String text) {
    return Text(
      text,
      style: TextStyle(
        color: AppColors.footerGrey, // You have this color defined
        fontSize: screenSize.height * 0.016,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
