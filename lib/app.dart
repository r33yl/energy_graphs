import 'package:energy_graphs/screens/home_page.dart';
import 'package:energy_graphs/services/database/get_user_data.dart';
import 'package:energy_graphs/services/providers.dart';
import 'package:energy_graphs/services/themes/theme_provider.dart';
import 'package:energy_graphs/services/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providersList,
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          // init and get user data
          initUserData(context);

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            themeMode: themeProvider.selectedThemeMode,
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
