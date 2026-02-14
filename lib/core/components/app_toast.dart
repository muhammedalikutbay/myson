import 'package:flutter/material.dart';

class AppToast {
  static void show(BuildContext context, String message) {
    OverlayState? overlayState = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => _ToastWidget(
        message: message,
        onDismiss: () {
          overlayEntry.remove();
        },
      ),
    );

    overlayState.insert(overlayEntry);
  }
}

class _ToastWidget extends StatefulWidget {
  final String message;
  final VoidCallback onDismiss;

  const _ToastWidget({required this.message, required this.onDismiss});

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward();

    // Show for 1.5 seconds then fade out
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        _controller.reverse().then((value) => widget.onDismiss());
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 8, // Positioned at the bottom
      left: MediaQuery.of(context).size.width * 0.2,
      width: MediaQuery.of(context).size.width * 0.6,
      child: Material(
        color: Colors.transparent,
        child: FadeTransition(
          opacity: _opacity,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: Text(
                widget.message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
