import 'package:flutter/material.dart';

import '../../helper/widgets/side_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: [
        SideBar(),
        Column(children: [])]),
    );
  }
}
