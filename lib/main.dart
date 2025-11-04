import 'package:flutter/material.dart';
import 'package:job_app/provider/fav_job_provider.dart';
import 'package:job_app/provider/job_details_provider.dart';
import 'package:job_app/screens/job_list.dart';
import 'package:job_app/utils/app_colors.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => JobDetailsProvider()),
      ChangeNotifierProvider(create: (_) => FavJobProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors().backgroundColor(context),
        appBarTheme: AppBarTheme(color: AppColors().backgroundColor(context)),
      ),
      home: const JobListScreen(),
    );
  }
}
