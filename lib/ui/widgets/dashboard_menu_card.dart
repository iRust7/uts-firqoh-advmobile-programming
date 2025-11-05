import 'package:flutter/material.dart';

class DashboardMenuCard extends StatefulWidget {
  const DashboardMenuCard({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.caption,
    this.gradient,
  });

  final IconData icon;
  final String label;
  final String? caption;
  final VoidCallback onTap;
  final List<Color>? gradient;

  @override
  State<DashboardMenuCard> createState() => _DashboardMenuCardState();
}

class _DashboardMenuCardState extends State<DashboardMenuCard> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _controller.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _controller.reverse();
      },
      child: AnimatedScale(
        scale: _isHovered ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(24),
          child: Ink(
            decoration: BoxDecoration(
              gradient: widget.gradient != null
                  ? LinearGradient(
                      colors: widget.gradient!,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
              color: widget.gradient == null ? Colors.white : null,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: (widget.gradient?.last ?? Colors.black).withOpacity(_isHovered ? 0.15 : 0.08),
                  blurRadius: _isHovered ? 28 : 20,
                  offset: Offset(0, _isHovered ? 16 : 12),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _controller.value * 0.1,
                        child: Transform.scale(
                          scale: 1 + (_controller.value * 0.1),
                          child: child,
                        ),
                      );
                    },
                    child: Container(
                      height: 64,
                      width: 64,
                      decoration: BoxDecoration(
                        color: (widget.gradient != null ? Colors.white : theme.colorScheme.primary).withOpacity(0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        widget.icon,
                        size: 32,
                        color: widget.gradient != null ? Colors.white : theme.colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.label,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: widget.gradient != null ? Colors.white : null,
                    ),
                  ),
                  if (widget.caption != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      widget.caption!,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: widget.gradient != null ? Colors.white.withOpacity(0.8) : Colors.black54,
                        height: 1.4,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
