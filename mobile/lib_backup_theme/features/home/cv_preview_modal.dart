import 'package:flutter/material.dart';
import '../../core/localization/app_localizations.dart';
import '../../models/applicant_model.dart';

class CvPreviewModal extends StatefulWidget {
  final ApplicantModel applicant;

  const CvPreviewModal({
    super.key,
    required this.applicant,
  });

  static Future<void> show(BuildContext context, ApplicantModel applicant) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => CvPreviewModal(applicant: applicant),
    );
  }

  @override
  State<CvPreviewModal> createState() => _CvPreviewModalState();
}

class _CvPreviewModalState extends State<CvPreviewModal> {
  final TransformationController _transformationController = TransformationController();
  int _currentPage = 1;
  final int _totalPages = 2;

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  void _zoomIn() {
    final matrix = _transformationController.value.clone();
    matrix.scale(1.2);
    _transformationController.value = matrix;
  }

  void _zoomOut() {
    final matrix = _transformationController.value.clone();
    matrix.scale(0.8);
    _transformationController.value = matrix;
  }

  void _resetZoom() {
    _transformationController.value = Matrix4.identity();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Container(
      height: MediaQuery.of(context).size.height * 0.92,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            // Handle bar
            const SizedBox(height: 10),
            Center(
              child: Container(
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFCBD5E1),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Top Header: Title, Page Pill, Close Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
              child: Row(
                children: [
                  // Close button
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF1F5F9),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 18,
                        color: Color(0xFF334155),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),

                  // Title: Preview
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          loc['preview'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        Text(
                          widget.applicant.resumeFileName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Page Indicator Pill (e.g. Page 1 / 2)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${loc['page']} $_currentPage / $_totalPages',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF475569),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(height: 1, color: Color(0xFFE2E8F0)),

            // Interactive CV Preview Canvas
            Expanded(
              child: Container(
                color: const Color(0xFF0F172A), // Dark studio background for crisp contrast
                child: Center(
                  child: InteractiveViewer(
                    transformationController: _transformationController,
                    minScale: 0.8,
                    maxScale: 4.0,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.35),
                              blurRadius: 18,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: widget.applicant.resumePreviewImage != null
                            ? Image.asset(
                                widget.applicant.resumePreviewImage!,
                                fit: BoxFit.contain,
                              )
                            : _buildFallbackCvDocument(loc),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Controls Bar at Bottom: Zoom In, Reset, Zoom Out, Page Switch
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Color(0xFFE2E8F0)),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Page switch buttons
                  Row(
                    children: [
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: _currentPage > 1
                            ? () {
                                setState(() => _currentPage--);
                                _resetZoom();
                              }
                            : null,
                        child: Text(isRtl ? 'التالي' : 'Prev'),
                      ),
                      const SizedBox(width: 8),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: _currentPage < _totalPages
                            ? () {
                                setState(() => _currentPage++);
                                _resetZoom();
                              }
                            : null,
                        child: Text(isRtl ? 'السابق' : 'Next'),
                      ),
                    ],
                  ),

                  // Zoom Controls
                  Row(
                    children: [
                      IconButton(
                        tooltip: 'Zoom Out',
                        icon: const Icon(Icons.zoom_out, color: Color(0xFF475569)),
                        onPressed: _zoomOut,
                      ),
                      IconButton(
                        tooltip: 'Reset Zoom',
                        icon: const Icon(Icons.restore, color: Color(0xFF475569)),
                        onPressed: _resetZoom,
                      ),
                      IconButton(
                        tooltip: 'Zoom In',
                        icon: const Icon(Icons.zoom_in, color: Color(0xFF1D4ED8)),
                        onPressed: _zoomIn,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFallbackCvDocument(AppLocalizations loc) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(24),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: const Color(0xFFEFF6FF),
                backgroundImage: widget.applicant.photoUrl != null
                    ? AssetImage(widget.applicant.photoUrl!)
                    : null,
                child: widget.applicant.photoUrl == null
                    ? const Text('DW', style: TextStyle(fontWeight: FontWeight.bold))
                    : null,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.applicant.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    Text(
                      widget.applicant.profession,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF1D4ED8),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 10),
          Text(
            loc['personal_information'],
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text('${loc['phone_label']}: ${widget.applicant.phone}'),
          Text('${loc['email_label']}: ${widget.applicant.email}'),
          Text('${loc['nationality']}: ${widget.applicant.nationality}'),
          Text('${loc['years_of_experience']}: ${widget.applicant.experienceYears}'),
          const SizedBox(height: 14),
          Text(
            loc['short_bio'],
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            widget.applicant.bio,
            style: const TextStyle(fontSize: 12, color: Color(0xFF475569)),
          ),
        ],
      ),
    );
  }
}
