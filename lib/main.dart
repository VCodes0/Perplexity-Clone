import 'package:flutter/material.dart';

import 'core/themes/app_colors.dart';

void main() {
  runApp(const PerplexityClone());
}

class PerplexityClone extends StatelessWidget {
  const PerplexityClone({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perplexity Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: AppColors.background),
    );
  }
}

