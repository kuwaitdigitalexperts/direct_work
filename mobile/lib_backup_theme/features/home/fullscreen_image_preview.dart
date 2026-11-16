import 'package:flutter/material.dart';
import '../../core/localization/app_localizations.dart';

class FullscreenImagePreview extends StatefulWidget {
  final String imagePath;
  final String? title;

  const FullscreenImagePreview({
    super.key,
    required this.imagePath,
    this.title,
  });

  static Future<void> show(
    BuildContext context, {
    required String imagePath,
    String? title,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => FullscreenImagePreview(
          imagePath: imagePath,
          title: title,
        ),
      ),
    );
  }

  @override
  State<FullscreenImagePreview> createState() => _FullscreenImagePreviewState();
}

class _FullscreenImagePreviewState extends State<FullscreenImagePreview> {
  final TransformationController _controller = TransformationController();
  TapDownDetails? _doubleTapDetails;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleDoubleTap() {
    if (_controller.value != Matrix4.identity()) {
      _controller.value = Matrix4.identity();
    } else {
      final position = _doubleTapDetails?.localPosition ?? Offset.zero;
      _controller.value = Matrix4.identity()
        ..translate(-position.dx * 1.5, -position.dy * 1.5)
        ..scale(2.5);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final displayTitle = widget.title ?? loc['preview'];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar matching Screenshot 2
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  // Rounded square Close (X) button
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 20,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),

                  // Title: "Preview"
                  Expanded(
                    child: Text(
                      displayTitle,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),

                  // Reset Zoom or Info Action
                  IconButton(
                    icon: const Icon(Icons.fullscreen_exit, color: Color(0xFF64748B)),
                    tooltip: 'Reset zoom',
                    onPressed: () {
                      _controller.value = Matrix4.identity();
                    },
                  ),
                ],
              ),
            ),

            const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),

            // Interactive Image Canvas
            Expanded(
              child: GestureDetector(
                onDoubleTapDown: (details) => _doubleTapDetails = details,
                onDoubleTap: _handleDoubleTap,
                child: InteractiveViewer(
                  transformationController: _controller,
                  minScale: 0.8,
                  maxScale: 4.5,
                  child: Center(
                    child: Hero(
                      tag: 'fullscreen_${widget.imagePath}',
                      child: Image.asset(
                        widget.imagePath,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => const Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.broken_image, size: 64, color: Color(0xFF94A3B8)),
                              SizedBox(height: 8),
                              Text('Image not available', style: TextStyle(color: Color(0xFF94A3B8))),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
