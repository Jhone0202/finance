import 'package:finance/home/controllers/home_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finance/home/entities/transaction_status_enum.dart';

import '../mocks/fake_transactions_repository.dart';

void main() {
  group('HomeController Tests', () {
    test('Should load transactions and total successfully', () async {
      final controller = HomeController(FakeRepository());

      await controller.load();

      expect(controller.transactions.length, 1);
      expect(controller.total, 100.0);
      expect(controller.errorMessage, isNull);
      expect(controller.isLoading, isFalse);
    });

    test('Should handle error when loading data', () async {
      final controller = HomeController(FakeRepository(shouldFail: true));

      await controller.load();

      expect(controller.transactions, isEmpty);
      expect(controller.total, 0.0);
      expect(controller.errorMessage, isNotNull);
      expect(controller.isLoading, isFalse);
    });

    test('Should change status and trigger data reload', () {
      final controller = HomeController(FakeRepository());

      controller.setStatus(TRANSACTION_STATUS.approved);

      expect(controller.status, TRANSACTION_STATUS.approved);
      expect(controller.isLoading, isTrue);
    });
  });
}
