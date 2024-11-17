import 'package:devswipe/homepage/home_page.dart';
import 'package:devswipe/services/provider_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderService(),
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Pixeboy',
          textTheme: const TextTheme(
            bodyLarge: TextStyle(fontSize: 24, color: Colors.black),
            bodyMedium: TextStyle(fontSize: 18, color: Colors.black),
            bodySmall: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: Consumer<ProviderService>(
          builder: (context, providerService, child) {
            if (providerService.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (providerService.error.isNotEmpty) {
              return Center(child: Text('Error: ${providerService.error}'));
            } else {
              return HomePage(user: providerService.user!);
            }
          },
        ),
      ),
    );
  }
}
