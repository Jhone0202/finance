import 'package:finance/home/components/home_body_data.dart';
import 'package:finance/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Transactions'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Consumer<HomeController>(
        builder: (context, controller, _) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.errorMessage != null) {
            return Center(child: Text(controller.errorMessage!));
          }

          return HomeBodyData(
            transactions: controller.transactions,
            total: controller.total,
            onStatusChanged: (status) {
              controller.setStatus(status);
            },
            selectedStatus: controller.status,
          );
        },
      ),
    );
  }
}
