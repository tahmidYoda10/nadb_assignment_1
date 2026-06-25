import 'package:flutter/material.dart';
import '../models/subject.dart';

class SubjectTile extends StatelessWidget {
  final Subject subject;
  final int index;

  const SubjectTile({
    super.key,
    required this.subject,
    required this.index,
  });

  Color _gradeColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    switch (subject.grade) {
      case 'A':
        return colorScheme.primary;
      case 'B':
        return colorScheme.secondary;
      case 'C':
        return colorScheme.primary.withOpacity(0.6);
      case 'F':
        return colorScheme.error;
      default:
        return colorScheme.onSurface;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final gradeColor = _gradeColor(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: colorScheme.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Text(
                '${index + 1}',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subject.name,
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.bar_chart,
                        size: 14,
                        color: colorScheme.onSurface.withOpacity(0.6),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Mark: ${subject.mark}/100',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: subject.mark / 100,
                      backgroundColor: colorScheme.onSurface.withOpacity(0.1),
                      valueColor: AlwaysStoppedAnimation<Color>(gradeColor),
                      minHeight: 5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 14),

            Container(
              width: 44,
              height: 44,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: gradeColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: gradeColor.withOpacity(0.4),
                ),
              ),
              child: Text(
                subject.grade,
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: gradeColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}