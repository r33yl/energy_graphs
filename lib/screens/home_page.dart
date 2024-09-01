import 'package:energy_graphs/screens/image_page.dart';
import 'package:energy_graphs/services/themes/theme_provider.dart';
import 'package:energy_graphs/screens/table_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void updateTab(int index) {
    setState(() {
      _tabController.index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.bolt),
            SizedBox(width: 8.0),
            Text("Графіки відключень"),
          ],
        ),
        bottom: tabController(),
        actions: [
          IconButton(
            splashRadius: 20,
            icon: Theme.of(context).brightness == Brightness.light
                ? const Icon(Icons.dark_mode)
                : const Icon(Icons.light_mode),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).setThemeMode(
                  Theme.of(context).brightness == Brightness.light
                      ? ThemeMode.dark
                      : ThemeMode.light);
            },
          ),
          const SizedBox(width: 4.0),
        ],
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: [
            TablePage(updateTab: updateTab),
            const ImagePage(),
          ],
        ),
      ),
    );
  }

  Tab myTab({required String text}) {
    return Tab(
      height: 42,
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  TabBar tabController() {
    Widget myTab({required String text, IconData? icon}) {
      return Tab(
        height: 44,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) Icon(icon),
            if (icon != null) const SizedBox(width: 8.0),
            Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return TabBar(
      controller: _tabController,
      padding: const EdgeInsets.symmetric(horizontal: 1.0),
      unselectedLabelColor: Theme.of(context).disabledColor.withOpacity(0.6),
      splashBorderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
      overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) => Theme.of(context).splashColor),
      tabs: [
        myTab(text: "Таблиця", icon: Icons.bar_chart_outlined),
        myTab(text: "Зображення", icon: Icons.image_outlined),
      ],
    );
  }
}
