import 'package:finance/home/controllers/home_controller.dart';
import 'package:finance/home/pages/home_page.dart';
import 'package:finance/home/repositories/transactions_repository_memory.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
      supportedLocales: const <Locale>[Locale('pt', 'BR')],
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) =>
                HomeController(TransactionsRepositoryMemory())..load(),
          ),
        ],
        child: const HomePage(),
      ),
    );
  }
}
