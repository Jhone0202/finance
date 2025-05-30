import 'package:intl/intl.dart';

String formatRealBr(double valor) {
  return NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(valor);
}

String getFriendlyDateTime(DateTime? dateTime, {bool separated = false}) {
  if (dateTime == null) return 'Data não informada';

  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(const Duration(days: 1));
  final dateFormatted = DateFormat('dd MMM yyyy', 'pt_BR').format(dateTime);

  if (dateTime.isAfter(today)) {
    return 'Hoje às${separated ? '\n' : ' '}${DateFormat.Hm('pt_BR').format(dateTime)}';
  } else if (dateTime.isAfter(yesterday)) {
    return 'Ontem às${separated ? '\n' : ' '}${DateFormat.Hm('pt_BR').format(dateTime)}';
  } else {
    return '$dateFormatted às${separated ? '\n' : ' '}${DateFormat.Hm('pt_BR').format(dateTime)}';
  }
}
