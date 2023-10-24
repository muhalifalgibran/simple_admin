import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_admin/core/di/service_locator.dart';
import 'package:simple_admin/core/network/dio_client.dart';
import 'package:simple_admin/features/presentation/pages/influencer_directory_page.dart';
import 'package:simple_admin/features/presentation/providers/influencer_provider.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<InfluencerProvider>(
          create: (context) => InfluencerProvider(),
        ),
      ],
      child: MaterialApp(
          title: 'Influencer Directory',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: InfluencerDirectoryPage()),
    );
  }
}
