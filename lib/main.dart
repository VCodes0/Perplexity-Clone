import 'package:flutter/material.dart';

import 'core/themes/app_colors.dart';
import 'presentation/views/home_view.dart';

late Size mq;
void main() {
  runApp(const PerplexityClone());
}

class PerplexityClone extends StatelessWidget {
  const PerplexityClone({super.key});

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return MaterialApp(
      title: 'Perplexity Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: AppColors.background),
      home: HomeView(),
    );
  }
}
