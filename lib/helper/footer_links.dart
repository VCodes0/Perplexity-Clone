import '../core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class FooterLinks extends StatelessWidget {
  final Size responsive;
  const FooterLinks({super.key, required this.responsive});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: responsive.height * 0.03),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildLink('Pro'),
          SizedBox(width: responsive.width * 0.02),
          _buildLink('Enterprise'),
          SizedBox(width: responsive.width * 0.02),
          _buildLink('Store'),
          SizedBox(width: responsive.width * 0.02),
          _buildLink('Blog'),
          SizedBox(width: responsive.width * 0.02),
          _buildLink('Careers'),
          SizedBox(width: responsive.width * 0.02),
          _buildLink('English (English)'),
        ],
      ),
    );
  }

  Widget _buildLink(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: responsive.height * 0.016,
        color: AppColors.footerGrey,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
