import 'package:finance/home/entities/transaction.dart';
import 'package:finance/home/entities/transaction_status_enum.dart';
import 'package:finance/home/interfaces/transactions_repository_interface.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  final ITransactionsRepository repository;

  HomeController(this.repository);

  List<Transaction> transactions = [];
  double total = 0.0;
  String? errorMessage;
  bool isLoading = false;
  bool isLoadingMore = false;
  bool hasMore = true;

  int currentPage = 1;
  final int pageSize = 10;
  TRANSACTION_STATUS status = TRANSACTION_STATUS.all;

  Future load() async {
    isLoading = true;
    notifyListeners();

    currentPage = 1;
    hasMore = true;

    final result = await repository.getTransactions(
      page: currentPage,
      status: status,
    );
    final totalResult = await repository.getTotal(status: status);

    if (result.isSuccess && totalResult.isSuccess) {
      transactions = result.data ?? [];
      total = totalResult.data ?? 0.0;
      errorMessage = null;

      if ((result.data?.length ?? 0) < pageSize) {
        hasMore = false;
      }
    } else {
      errorMessage = result.error ?? totalResult.error;
    }

    isLoading = false;
    notifyListeners();
  }

  Future loadMore() async {
    if (isLoadingMore || !hasMore) return;

    isLoadingMore = true;
    notifyListeners();

    final nextPage = currentPage + 1;
    final result = await repository.getTransactions(
      page: nextPage,
      status: status,
    );

    if (result.isSuccess) {
      final newData = result.data ?? [];

      if (newData.isEmpty || newData.length < pageSize) {
        hasMore = false;
      }

      transactions.addAll(newData);
      currentPage = nextPage;
    } else {
      errorMessage = result.error;
    }

    isLoadingMore = false;
    notifyListeners();
  }

  void setStatus(TRANSACTION_STATUS newStatus) {
    status = newStatus;
    notifyListeners();
    load();
  }
}
