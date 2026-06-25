import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/subject_provider.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  Color _gradeColor(BuildContext context, String grade) {
    final colorScheme = Theme.of(context).colorScheme;
    switch (grade) {
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

  String _gradeMessage(String grade) {
    switch (grade) {
      case 'A':
        return 'Excellent! Outstanding performance!';
      case 'B':
        return 'Good job! Keep it up!';
      case 'C':
        return 'Average. Try harder!';
      case 'F':
        return 'Failed. Need serious improvement!';
      default:
        return '';
    }
  }

  IconData _gradeIcon(String grade) {
    switch (grade) {
      case 'A':
        return Icons.emoji_events;
      case 'B':
        return Icons.thumb_up;
      case 'C':
        return Icons.auto_stories;
      case 'F':
        return Icons.warning_rounded;
      default:
        return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: Consumer<SubjectProvider>(
        builder: (context, provider, _) {
          if (provider.subjects.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.assessment_outlined,
                    size: 80,
                    color: colorScheme.primary.withOpacity(0.3),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No data yet',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: colorScheme.onSurface.withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Add subjects to see your summary',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface.withOpacity(0.4),
                    ),
                  ),
                ],
              ),
            );
          }

          final overallGrade = provider.overallGrade;
          final gradeColor = _gradeColor(context, overallGrade);
          final average = provider.averageMark;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        gradeColor.withOpacity(0.8),
                        gradeColor,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: gradeColor.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Overall Result',
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: colorScheme.onPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        overallGrade,
                        style: TextStyle(
                          color: colorScheme.onPrimary,
                          fontSize: 72,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _gradeIcon(overallGrade),
                            color: colorScheme.onPrimary.withOpacity(0.9),
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              _gradeMessage(overallGrade),
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: colorScheme.onPrimary.withOpacity(0.9),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: _statCard(
                        context,
                        '${provider.totalSubjects}',
                        'Total Subjects',
                        Icons.library_books_outlined,
                        colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _statCard(
                        context,
                        average.toStringAsFixed(1),
                        'Average Mark',
                        Icons.bar_chart,
                        colorScheme.secondary,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: _statCard(
                        context,
                        '${provider.passingSubjects.length}',
                        'Subjects Passed',
                        Icons.check_circle_outline,
                        colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _statCard(
                        context,
                        '${provider.failingSubjects.length}',
                        'Subjects Failed',
                        Icons.cancel_outlined,
                        colorScheme.error,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Average Mark Progress',
                          style: theme.textTheme.titleMedium,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: LinearProgressIndicator(
                                  value: average / 100,
                                  backgroundColor:
                                  colorScheme.onSurface.withOpacity(0.1),
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    gradeColor,
                                  ),
                                  minHeight: 12,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              '${average.toStringAsFixed(1)}%',
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: gradeColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  'Subject Breakdown',
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 10),

                ...provider.subjects.map(
                      (subject) => Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: _gradeColor(context, subject.grade)
                            .withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            subject.name,
                            style: theme.textTheme.titleMedium,
                          ),
                        ),
                        Text(
                          '${subject.mark}/100',
                          style: theme.textTheme.bodyMedium,
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _gradeColor(context, subject.grade)
                                .withOpacity(0.15),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            subject.grade,
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: _gradeColor(context, subject.grade),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _statCard(
      BuildContext context,
      String value,
      String label,
      IconData icon,
      Color color,
      ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: theme.textTheme.headlineMedium?.copyWith(
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withOpacity(0.6),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}