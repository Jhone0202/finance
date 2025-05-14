import 'package:finance/home/shared/result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finance/home/entities/transaction.dart';
import 'package:finance/home/entities/transaction_status_enum.dart';
import 'package:finance/home/interfaces/transactions_repository_interface.dart';

class FakeRepository implements ITransactionsRepository {
  final bool shouldFail;

  FakeRepository({this.shouldFail = false});

  @override
  Future<Result<List<Transaction>>> getTransactions({
    int page = 1,
    int pageSize = 10,
    TRANSACTION_STATUS status = TRANSACTION_STATUS.all,
  }) async {
    if (shouldFail) {
      return Result.error('Erro ao buscar transações');
    }

    return Result.success([
      Transaction(
        id: 1,
        description: 'Teste',
        amount: 100.0,
        date: DateTime.now(),
        status: TRANSACTION_STATUS.approved,
      ),
    ]);
  }

  @override
  Future<Result<double>> getTotal({
    TRANSACTION_STATUS status = TRANSACTION_STATUS.all,
  }) async {
    if (shouldFail) {
      return Result.error('Erro ao buscar total');
    }

    return Result.success(100.0);
  }
}
