import 'package:flutter/material.dart';
import 'package:simple_admin/core/network/dio_client.dart';
import 'package:simple_admin/features/presentation/pages/influencer_directory_page.dart';

void main() {
  DioClient.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Influencer Directory',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: InfluencerDirectoryPage());
  }
}
