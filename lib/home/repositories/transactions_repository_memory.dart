import 'package:finance/home/entities/transaction.dart';
import 'package:finance/home/entities/transaction_status_enum.dart';
import 'package:finance/home/interfaces/transactions_repository_interface.dart';
import 'package:finance/home/shared/result.dart';

class TransactionsRepositoryMemory implements ITransactionsRepository {
  final List<Transaction> _transactions = [];

  TransactionsRepositoryMemory() {
    _populateTransactions();
  }

  void _populateTransactions() {
    final descriptions = [
      'Groceries',
      'Rent',
      'Utilities',
      'Internet',
      'Transport',
      'Dining',
      'Shopping',
      'Gym',
      'Insurance',
      'Medical'
    ];

    for (int i = 1; i <= 100; i++) {
      final statusValues = TRANSACTION_STATUS.values.sublist(1);

      _transactions.add(
        Transaction(
          id: i,
          description: descriptions[i % descriptions.length],
          amount: (i * 10).toDouble(),
          date: DateTime.now().subtract(Duration(days: i)),
          status: statusValues[i % statusValues.length],
        ),
      );
    }

    _transactions.sort((a, b) => b.date.compareTo(a.date));
  }

  @override
  Future<Result<double>> getTotal({
    TRANSACTION_STATUS status = TRANSACTION_STATUS.all,
  }) async {
    try {
      final filtered = status == TRANSACTION_STATUS.all
          ? _transactions
          : _transactions.where((tr) => tr.status == status).toList();

      final total = filtered.fold<double>(0, (sum, e) => sum + e.amount);

      return Result.success(total);
    } catch (e) {
      return Result.error('Error calculating total $e');
    }
  }

  @override
  Future<Result<List<Transaction>>> getTransactions({
    int page = 1,
    int pageSize = 10,
    TRANSACTION_STATUS status = TRANSACTION_STATUS.all,
  }) async {
    try {
      final filtered = status == TRANSACTION_STATUS.all
          ? _transactions
          : _transactions.where((tr) => tr.status == status).toList();

      final start = (page - 1) * pageSize;
      final end = start + pageSize;

      if (start >= filtered.length) return Result.success([]);

      final paginated = filtered.sublist(
          start, end > filtered.length ? filtered.length : end);

      return Result.success(paginated);
    } catch (e) {
      return Result.error('Error fetching transactions $e');
    }
  }
}
