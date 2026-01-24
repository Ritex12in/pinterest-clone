import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/app_routes.dart';

class SearchInputPage extends StatefulWidget {
  final String? initialQuery;
  const SearchInputPage({super.key, this.initialQuery});

  @override
  State<SearchInputPage> createState() => _SearchInputPageState();
}

class _SearchInputPageState extends State<SearchInputPage> {
  late final TextEditingController controller;

  final suggestions = const [
    "Aesthetic wallpapers",
    "Pose reference",
    "Easy drawings",
    "Interior design",
    "Nature photography",
    "Minimalist design",
    "Tattoo ideas",
    "Mehndi designs",
    "UI inspiration",
    "Fitness motivation",
    "Food photography",
    "Street photography",
  ];

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.initialQuery ?? "");
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _submit([String? value]) {
    final query = (value ?? controller.text).trim();
    if (query.isEmpty) return;

    context.pushReplacement(AppRoutes.searchResults(query));
  }

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyLarge!.color;
    final cardColor = textColor?.withValues(alpha: 0.15);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  _SquareIconButton(
                    icon: Icons.arrow_back,
                    onTap: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),

                  Expanded(
                    child: SizedBox(
                      height: 52,
                      child: TextField(
                        controller: controller,
                        autofocus: true,
                        textInputAction: TextInputAction.search,
                        onSubmitted: _submit,
                        decoration: InputDecoration(
                          hintText: "Search for ideas",
                          filled: true,
                          fillColor: cardColor,
                          contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  _SquareIconButton(
                    icon: Icons.search,
                    onTap: () => _submit(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(12),
                child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: suggestions.map((text) {
                    return _SuggestionChip(
                      text: text,
                      onTap: () => _submit(text),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SquareIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _SquareIconButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyLarge!.color;
    return SizedBox(
      height: 52,
      width: 52,
      child: Material(
        color: textColor?.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Icon(icon),
        ),
      ),
    );
  }
}

class _SuggestionChip extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _SuggestionChip({
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyLarge!.color;
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: textColor?.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
