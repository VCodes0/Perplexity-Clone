import 'package:google_fonts/google_fonts.dart';
import 'presentation/views/home_view.dart';
import 'package:flutter/material.dart';
import 'core/themes/app_colors.dart';

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.submitButton),
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
        scaffoldBackgroundColor: AppColors.background,
      ),
      home: HomeView(),
    );
  }
}
