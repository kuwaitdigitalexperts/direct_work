import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/localization/app_localizations.dart';
import '../../shared/widgets/app_dialogs.dart';

class CreateCommercialScreen extends StatelessWidget {
  const CreateCommercialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(l10n.translate('post_commercial')),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: AppDialogs.buildAvailableSoonCard(context),
      ),
    );
  }
}

/*
// ============================================================================
// CREATE COMMERCIAL FORM - DEFERRED TO NEXT VERSION
// Preserved for the next release.
// ============================================================================
/*
class _FullCreateCommercialScreenState extends State<CreateCommercialScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _businessNameController = TextEditingController();
  final _descController = TextEditingController();
  final _websiteController = TextEditingController();
  final _phoneController = TextEditingController();

  String _selectedCategory = 'offers';
  bool _isSubmitting = false;

  final List<Map<String, String>> _categories = [
    {'id': 'offers', 'name_ar': 'عروض تجارية وشركات', 'name_en': 'Business & Corporate Offers'},
    {'id': 'automotive', 'name_ar': 'سيارات وتأجير', 'name_en': 'Automotive & Car Rental'},
    {'id': 'real_estate', 'name_ar': 'عقارات ومقاولات', 'name_en': 'Real Estate & Contracting'},
    {'id': 'medical', 'name_ar': 'مراكز طبية وعيادات', 'name_en': 'Medical Clinics & Centers'},
    {'id': 'restaurants', 'name_ar': 'مطاعم ومقاهي', 'name_en': 'Restaurants & Cafes'},
    {'id': 'education', 'name_ar': 'معهد تدريب وتعليم', 'name_en': 'Training & Education'},
    {'id': 'other', 'name_ar': 'أخرى', 'name_en': 'Other Business'},
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _businessNameController.dispose();
    _descController.dispose();
    _websiteController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}
*/
*/
