import 'package:flutter/material.dart';

import '../constants/app_spacing.dart';
import '../theme/app_colors.dart';

class PasswordStrengthIndicator extends StatelessWidget {
  const PasswordStrengthIndicator({super.key, required this.password});

  final String password;

  int get _score {
    if (password.isEmpty) return 0;
    var score = 1;
    if (password.length >= 8) score++;
    if (RegExp(r'\d').hasMatch(password) &&
        RegExp(r'[^\d\s]').hasMatch(password)) {
      score++;
    }
    if (password.length >= 12 ||
        RegExp(r'[^\p{L}\d]', unicode: true).hasMatch(password)) {
      score++;
    }
    return score;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final score = _score;

    final (label, color) = switch (score) {
      0 => ('', colors.outlineVariant),
      1 => ('Слабкий пароль', colors.error),
      2 => ('Пароль середньої надійності', colors.warning),
      3 => ('Надійний пароль', colors.positive),
      _ => ('Дуже надійний пароль', colors.positive),
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            for (var i = 0; i < 4; i++)
              Expanded(
                child: Container(
                  height: 4,
                  margin: EdgeInsets.only(right: i < 3 ? AppSpacing.xs : 0),
                  decoration: BoxDecoration(
                    color: i < score ? color : colors.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
          ],
        ),
        if (label.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.xs),
            child: Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(color: color),
            ),
          ),
      ],
    );
  }
}
