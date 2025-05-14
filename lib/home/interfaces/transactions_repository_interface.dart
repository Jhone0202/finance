import 'package:finance/home/entities/transaction.dart';
import 'package:finance/home/entities/transaction_status_enum.dart';
import 'package:finance/home/shared/result.dart';

abstract class ITransactionsRepository {
  Future<Result<List<Transaction>>> getTransactions({
    int page = 1,
    int pageSize = 10,
    TRANSACTION_STATUS status = TRANSACTION_STATUS.all,
  });

  Future<Result<double>> getTotal({
    TRANSACTION_STATUS status = TRANSACTION_STATUS.all,
  });
}
