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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.backgroundColor,
        appBarTheme: AppBarTheme(color: AppColors.backgroundColor),
      ),
      home: const JobListScreen(),
    );
  }
}
