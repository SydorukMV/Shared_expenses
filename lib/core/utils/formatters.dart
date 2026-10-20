const _nbsp = '\u00A0';
const _currency = '\u00A0грн';

const _monthsGenitive = [
  'січня',
  'лютого',
  'березня',
  'квітня',
  'травня',
  'червня',
  'липня',
  'серпня',
  'вересня',
  'жовтня',
  'листопада',
  'грудня',
];

String formatMoney(int amount, {bool signed = false}) {
  final digits = amount.abs().toString();
  final buffer = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) buffer.write(_nbsp);
    buffer.write(digits[i]);
  }
  final sign = amount < 0 ? '−' : (signed && amount > 0 ? '+' : '');
  return '$sign$buffer$_currency';
}

String formatShortDate(DateTime date) {
  final day = date.day.toString().padLeft(2, '0');
  final month = date.month.toString().padLeft(2, '0');
  return '$day.$month';
}

String formatDayMonth(DateTime date) =>
    '${date.day} ${_monthsGenitive[date.month - 1]}';

String pluralize(int count, String one, String few, String many) {
  final mod10 = count % 10;
  final mod100 = count % 100;
  if (mod10 == 1 && mod100 != 11) return one;
  if (mod10 >= 2 && mod10 <= 4 && (mod100 < 12 || mod100 > 14)) return few;
  return many;
}

String formatMembers(int count) =>
    '$count ${pluralize(count, 'учасник', 'учасники', 'учасників')}';
