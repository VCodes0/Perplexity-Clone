import 'package:google_fonts/google_fonts.dart';
import 'package:perplexity_clone/domain/controller/search_controller.dart';
import 'package:perplexity_clone/presentation/views/result_view.dart';
import 'presentation/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/themes/app_colors.dart';

late Size responsive;

void main() => runApp(const NIKA1O());

class NIKA1O extends StatelessWidget {
  const NIKA1O({super.key});

  @override
  Widget build(BuildContext context) {
    responsive = MediaQuery.of(context).size;
    return GetMaterialApp(
      title: 'Perplexity Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.submitButton),
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
        scaffoldBackgroundColor: AppColors.background,
      ),
      initialBinding: BindingsBuilder(() {
        Get.put(QueryController(), permanent: true);
      }),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const HomeView()),
        GetPage(name: '/result', page: () => const ResultView()),
      ],
    );
  }
}
