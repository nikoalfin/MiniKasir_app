import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NumberInputFormatter extends TextInputFormatter {
  final NumberFormat formatter;

  NumberInputFormatter({required String locale})
    : formatter = NumberFormat.decimalPattern(locale);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Hapus semua karakter non-digit untuk pemrosesan
    final String cleanText = newValue.text.replaceAll(
      formatter.symbols.GROUP_SEP,
      '',
    );

    // Konversi ke int atau double
    final double? parsedValue = double.tryParse(cleanText);

    if (parsedValue == null) {
      return oldValue; // Kembali ke nilai lama jika input tidak valid
    }

    // Format angka
    final String formattedText = formatter.format(parsedValue);

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
