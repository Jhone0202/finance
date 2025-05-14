import 'package:finance/home/entities/transaction_status_enum.dart';

class Transaction {
  final int id;
  final String description;
  final double amount;
  final DateTime date;
  final TRANSACTION_STATUS status;

  Transaction({
    required this.id,
    required this.description,
    required this.amount,
    required this.date,
    required this.status,
  });
}
