import 'package:flutter/material.dart';

class AnimatedSearchButton extends StatefulWidget {
  final VoidCallback onTap;

  const AnimatedSearchButton({super.key, required this.onTap});

  @override
  State<AnimatedSearchButton> createState() => _AnimatedSearchButtonState();
}

class _AnimatedSearchButtonState extends State<AnimatedSearchButton> {
  bool _collapsed = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) setState(() => _collapsed = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;
    final bg = Theme.of(context).cardColor;

    return Material(
      borderRadius: BorderRadius.circular(16),
      color: bg,
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(28),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          curve: Curves.fastOutSlowIn,
          width: _collapsed ? 56 : 140,
          height: 56,
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInOutCubic,
                left: _collapsed ? 16 : 20,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: _collapsed ? 0 : 1,
                  child: Text(
                    "Find more",
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              AnimatedPositioned(
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInOutCubic,
                right: _collapsed ? 16 : 20,
                child: Icon(Icons.search, color: textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}