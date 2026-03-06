import '../../helper/widgets/search_section.dart';
import '../../helper/widgets/side_bar.dart';
import '../../helper/footer_links.dart';
import 'package:flutter/material.dart';
import '../../main.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SideBar(),
          Expanded(
            child: Column(
              children: [
                Expanded(child: Center(child: const SearchSection())),
                FooterLinks(responsive: responsive),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
