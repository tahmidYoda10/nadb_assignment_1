import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/subject.dart';
import '../providers/subject_provider.dart';

class AddSubjectScreen extends StatefulWidget {
  const AddSubjectScreen({super.key});

  @override
  State<AddSubjectScreen> createState() => _AddSubjectScreenState();
}

class _AddSubjectScreenState extends State<AddSubjectScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _markController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _markController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<SubjectProvider>();

    if (provider.subjectExists(_nameController.text.trim())) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(
                Icons.warning_rounded,
                color: Theme.of(context).colorScheme.onError,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '"${_nameController.text.trim()}" already exists!',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onError,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }

    final subject = Subject(
      name: _nameController.text.trim(),
      mark: int.parse(_markController.text.trim()),
    );

    provider.addSubject(subject);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.check_circle_rounded,
              color: Colors.white,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '"${subject.name}" added successfully! Grade: ${subject.grade}',
              ),
            ),
          ],
        ),
      ),
    );

    _nameController.clear();
    _markController.clear();
    _formKey.currentState!.reset();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        colorScheme.primary,
                        colorScheme.secondary,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.add_circle_outline,
                        color: colorScheme.onPrimary,
                        size: 40,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Add New Subject',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: colorScheme.onPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Enter subject name and marks to track your grade',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onPrimary.withOpacity(0.85),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                Text(
                  'Subject Name',
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _nameController,
                  textCapitalization: TextCapitalization.words,
                  style: TextStyle(color: colorScheme.onSurface),
                  decoration: const InputDecoration(
                    hintText: 'e.g. Mathematics',
                    prefixIcon: Icon(Icons.book_outlined),
                    labelText: 'Subject Name',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Subject name cannot be empty';
                    }
                    if (value.trim().length < 2) {
                      return 'Name must be at least 2 characters';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 24),

                Text(
                  'Marks Obtained',
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _markController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: colorScheme.onSurface),
                  decoration: const InputDecoration(
                    hintText: 'e.g. 75',
                    prefixIcon: Icon(Icons.grade_outlined),
                    labelText: 'Mark (0 - 100)',
                    suffixText: '/ 100',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Mark cannot be empty';
                    }
                    final mark = int.tryParse(value.trim());
                    if (mark == null) {
                      return 'Please enter a valid number';
                    }
                    if (mark < 0 || mark > 100) {
                      return 'Mark must be between 0 and 100';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: colorScheme.primary.withOpacity(0.3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Grade Scale',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _gradeRow(context, 'A', '80 - 100', colorScheme.primary),
                      _gradeRow(context, 'B', '65 - 79', colorScheme.secondary),
                      _gradeRow(
                        context,
                        'C',
                        '50 - 64',
                        colorScheme.tertiary ??
                            colorScheme.primary.withOpacity(0.6),
                      ),
                      _gradeRow(context, 'F', '0 - 49', colorScheme.error),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _submitForm,
                    icon: const Icon(Icons.add),
                    label: const Text('Add Subject'),
                  ),
                ),

                const SizedBox(height: 20),

                Consumer<SubjectProvider>(
                  builder: (context, provider, _) {
                    return Center(
                      child: Text(
                        'Total subjects added: ${provider.totalSubjects}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.primary,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _gradeRow(
      BuildContext context,
      String grade,
      String range,
      Color color,
      ) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              grade,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            range,
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}