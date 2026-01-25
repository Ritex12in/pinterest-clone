import 'package:flutter/material.dart';

class CustomBottomSheet {
  static void showCreateBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.only(bottom: 24),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),

              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade700,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    const Spacer(),
                    const Text(
                      "Start creating now",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),

                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _CreateItem(
                    icon: Icons.push_pin_outlined,
                    label: "Pin",
                    onTap: () {},
                  ),
                  _CreateItem(
                    icon: Icons.content_cut,
                    label: "Collage",
                    onTap: () {},
                  ),
                  _CreateItem(
                    icon: Icons.dashboard_outlined,
                    label: "Board",
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  static void showUpdateOptionsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Options",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 16),

              _OptionItem(
                title: "Delete update",
                onTap: () {},
              ),

              const SizedBox(height: 16),

              _OptionItem(
                title: "View notification settings",
                onTap: () {},
              ),

              const SizedBox(height: 28),

              Center(
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Text(
                      "Close",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CreateItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _CreateItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyLarge!.color;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: textColor?.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }
}

class _OptionItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _OptionItem({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

