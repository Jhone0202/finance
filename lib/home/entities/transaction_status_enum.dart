import 'package:flutter/material.dart';

enum TRANSACTION_STATUS {
  all,
  approved,
  pending,
  rejected,
}

Color getStatusColor(TRANSACTION_STATUS status) {
  switch (status) {
    case TRANSACTION_STATUS.all:
      return Colors.deepPurple;
    case TRANSACTION_STATUS.approved:
      return Colors.green;
    case TRANSACTION_STATUS.pending:
      return Colors.blueGrey;
    case TRANSACTION_STATUS.rejected:
      return Colors.red;
  }
}

String getStatusText(TRANSACTION_STATUS status) {
  switch (status) {
    case TRANSACTION_STATUS.all:
      return 'All Transactions';
    case TRANSACTION_STATUS.approved:
      return 'Approved';
    case TRANSACTION_STATUS.pending:
      return 'Pending';
    case TRANSACTION_STATUS.rejected:
      return 'Rejected';
  }
}
