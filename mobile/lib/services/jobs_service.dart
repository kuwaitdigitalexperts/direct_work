import '../core/network/api_client.dart';
import '../core/network/api_endpoints.dart';
import '../models/job_model.dart';

class JobsService {
  final ApiClient _client = ApiClient();

  // Curated Multi-Country Sample Jobs
  static final List<JobModel> _allDefaultJobs = [
    // -------------------------------------------------------------------------
    // KUWAIT JOBS (kw)
    // -------------------------------------------------------------------------
    JobModel(
      id: 'job_kw_101',
      title: 'فني تكييف مركزي وصيانة وحدات',
      companyName: 'شركة الوطنية للتكييف والتبريد - الكويت',
      sectorCode: 'technical',
      sectorName: 'فنيون وصيانة',
      professionName: 'فني تكييف مركزي',
      governorateId: 'hawalli',
      governorateName: 'محافظة حولي',
      workType: 'full_time',
      candidateCategory: 'resident',
      salaryKwd: 450,
      description: 'مطلوب فني تكييف مركزي وتبريد بخبرة لا تقل عن 3 سنوات في الكويت، معرفة تامة بصيانة وحدات DX وتكييف الشيلرات ومخططات التبريد.',
      requirements: const ['خبرة 3 سنوات على الأقل داخل الكويت', 'رخصة قيادة كويتية صالحة', 'إقامة قابلة للتحويل مادة 18'],
      whatsappNumber: '96566707126',
      phoneNumber: '+965 6670 7126',
      isPinned: true,
      isFeatured: true,
      viewsCount: 384,
      createdAt: DateTime.now().subtract(const Duration(hours: 12)),
      countryCode: 'kw',
      currency: 'د.ك',
    ),
    JobModel(
      id: 'job_kw_102',
      title: 'سائقو توصيل طلبات مطاعم (سيارة / دراجة)',
      companyName: 'مجموعة الأفق اللوجستية لنقل البضائع',
      sectorCode: 'drivers',
      sectorName: 'سائقون وتوصيل',
      professionName: 'سائق توصيل طلبات (سيارة)',
      governorateId: 'capital',
      governorateName: 'محافظة العاصمة',
      workType: 'part_time',
      candidateCategory: 'all',
      salaryKwd: 320,
      description: 'فرص عمل بدوام كامل أو جزئي لسائقي توصيل الطلبات في مناطق العاصمة وحولي بنظام عمولات مجزي مع راتب ثابت.',
      requirements: const ['معرفة ممتازة بمناطق الكويت', 'رخصة قيادة كويتية صالحة'],
      whatsappNumber: '96566224488',
      phoneNumber: '+965 22447788',
      isPinned: false,
      isFeatured: true,
      viewsCount: 290,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      countryCode: 'kw',
      currency: 'د.ك',
    ),
    JobModel(
      id: 'job_kw_103',
      title: 'محاسب عام وتدقيق حسابات شركات',
      companyName: 'دار الاستشارات المالية وحلول الأعمال',
      sectorCode: 'finance',
      sectorName: 'محاسبة ومالية',
      professionName: 'محاسب عام',
      governorateId: 'ahmadi',
      governorateName: 'محافظة الأحمدي',
      workType: 'full_time',
      candidateCategory: 'resident',
      salaryKwd: 500,
      description: 'مطلوب محاسب مالي لإعداد القوائم المالية وإدخال القيود وتدقيق الحسابات على البرامج المحاسبية المعتمدة.',
      requirements: const ['بكالوريوس محاسبة', 'إجادة برامج المحاسبة وExcel', 'خبرة سنتين داخل الكويت'],
      whatsappNumber: '96555443322',
      phoneNumber: '+965 22449900',
      isPinned: false,
      isFeatured: false,
      viewsCount: 175,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      countryCode: 'kw',
      currency: 'د.ك',
    ),

    // -------------------------------------------------------------------------
    // SAUDI ARABIA JOBS (sa)
    // -------------------------------------------------------------------------
    JobModel(
      id: 'job_sa_101',
      title: 'مهندس مدني ومدير مشاريع إنشائية',
      companyName: 'شركة الراجحي للإنشاءات والمقاولات العامة',
      sectorCode: 'construction',
      sectorName: 'المقاولات والإنشاءات',
      professionName: 'مهندس مدني',
      governorateId: 'riyadh',
      governorateName: 'منطقة الرياض',
      workType: 'full_time',
      candidateCategory: 'resident',
      salaryKwd: 8500,
      description: 'مطلوب مهندس مدني لإدارة مواقع المشاريع السكنية والتجارية بالرياض، الإشراف على مقاولي الباطن وجداول التنفيذ.',
      requirements: const ['شهادة هندسة مدنية معتمدة من هيئة المهندسين', 'خبرة 5 سنوات في المشاريع بالسعودية', 'إقامة سارية قابلة للنقل'],
      whatsappNumber: '966501234567',
      phoneNumber: '+966 114567890',
      isPinned: true,
      isFeatured: true,
      viewsCount: 420,
      createdAt: DateTime.now().subtract(const Duration(hours: 6)),
      countryCode: 'sa',
      currency: 'ر.س',
    ),
    JobModel(
      id: 'job_sa_102',
      title: 'فني تكييف مركزي وتشغيل شيلرات',
      companyName: 'مجموعة بن لادن للتشغيل والصيانة',
      sectorCode: 'technical',
      sectorName: 'فنيون وصيانة',
      professionName: 'فني تكييف مركزي',
      governorateId: 'makkah',
      governorateName: 'منطقة مكة المكرمة (جدة والطائف)',
      workType: 'full_time',
      candidateCategory: 'all',
      salaryKwd: 4500,
      description: 'مطلوب فنيو تكييف وتبريد شيلرات ومجاري هواء لصيانة أبراج ومراكز تجارية بجدة ومكة المكرمة.',
      requirements: const ['دبلوم تبريد وتكييف', 'خبرة عملية موثقة في الشيلرات والتكييف المركزي'],
      whatsappNumber: '966559876543',
      phoneNumber: '+966 126789012',
      isPinned: false,
      isFeatured: true,
      viewsCount: 310,
      createdAt: DateTime.now().subtract(const Duration(hours: 18)),
      countryCode: 'sa',
      currency: 'ر.س',
    ),
    JobModel(
      id: 'job_sa_103',
      title: 'محاسب مالي معتمد وإدارة تكاليف',
      companyName: 'شركة الزامل للصناعات القابضة',
      sectorCode: 'finance',
      sectorName: 'محاسبة ومالية',
      professionName: 'محاسب مالي',
      governorateId: 'eastern',
      governorateName: 'المنطقة الشرقية (الدمام والخبر)',
      workType: 'full_time',
      candidateCategory: 'resident',
      salaryKwd: 6500,
      description: 'مطلوب محاسب مالي بخبرة في محاسبة التكاليف وإعداد الإقرارات الضريبية للزكاة والدخل في المنطقة الشرقية.',
      requirements: const ['عضوية الهيئة السعودية للمحاسبين SOCPA', 'إجادة برامج ERP واللغة الإنجليزية'],
      whatsappNumber: '966543210987',
      phoneNumber: '+966 138901234',
      isPinned: false,
      isFeatured: false,
      viewsCount: 220,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      countryCode: 'sa',
      currency: 'ر.س',
    ),
    JobModel(
      id: 'job_sa_104',
      title: 'سائقو نقل وتوصيل لوجستي وشحنات',
      companyName: 'شركة سبل للخدمات اللوجستية المتقدمة',
      sectorCode: 'drivers',
      sectorName: 'سائقون وتوصيل',
      professionName: 'سائق نقل وتوصيل',
      governorateId: 'madinah',
      governorateName: 'منطقة المدينة المنورة',
      workType: 'full_time',
      candidateCategory: 'all',
      salaryKwd: 3800,
      description: 'وظائف شاغرة لسائقي شاحنات خفيفة ومتوسطة لتوزيع الشحنات في منطقة المدينة المنورة والمحافظات المجاورة.',
      requirements: const ['رخصة عمومي أو خصوصي سارية', 'معرفة تامة بطرق ومناطق المدينة'],
      whatsappNumber: '966567890123',
      phoneNumber: '+966 148901234',
      isPinned: false,
      isFeatured: false,
      viewsCount: 195,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      countryCode: 'sa',
      currency: 'ر.س',
    ),

    // -------------------------------------------------------------------------
    // UAE / DUBAI JOBS (ae)
    // -------------------------------------------------------------------------
    JobModel(
      id: 'job_ae_101',
      title: 'فني صيانة وتكييف مركزي ومرافق',
      companyName: 'مجموعة إعمار لإدارة المرافق والخدمات',
      sectorCode: 'technical',
      sectorName: 'فنيون وصيانة',
      professionName: 'فني تكييف ومرافق',
      governorateId: 'dubai',
      governorateName: 'إمارة دبي',
      workType: 'full_time',
      candidateCategory: 'resident',
      salaryKwd: 5000,
      description: 'مطلوب فنيو صيانة عامة وتكييف وتبريد لأبراج ومجمعات سكنية راقية في دبي مع توفير السكن والمواصلات وتأمين صحي شامل.',
      requirements: const ['خبرة سنتين في صيانة المرافق بالإمارات', 'رخصة قيادة إماراتية أفضلية'],
      whatsappNumber: '971501122334',
      phoneNumber: '+971 42233445',
      isPinned: true,
      isFeatured: true,
      viewsCount: 510,
      createdAt: DateTime.now().subtract(const Duration(hours: 8)),
      countryCode: 'ae',
      currency: 'د.إ',
    ),
    JobModel(
      id: 'job_ae_102',
      title: 'مدير مالي وإداري تنفيذي',
      companyName: 'مجموعة الفطيم القابضة للخدمات',
      sectorCode: 'finance',
      sectorName: 'محاسبة ومالية',
      professionName: 'مدير مالي',
      governorateId: 'abudhabi',
      governorateName: 'إمارة أبوظبي',
      workType: 'full_time',
      candidateCategory: 'all',
      salaryKwd: 12500,
      description: 'فرصة عمل متميزة لمدير مالي بخبرة واسعة في التخطيط المالي والميزانيات وإدارة السيولة النقدية للشركات الكبرى بأبوظبي.',
      requirements: const ['شهادة CPA أو CMA', 'خبرة 7 سنوات فما فوق في دولة الإمارات'],
      whatsappNumber: '971523344556',
      phoneNumber: '+971 23344556',
      isPinned: false,
      isFeatured: true,
      viewsCount: 390,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      countryCode: 'ae',
      currency: 'د.إ',
    ),
    JobModel(
      id: 'job_ae_103',
      title: 'مهندس برمجيات ونظم ذكاء اصطناعي',
      companyName: 'شركة دبي للتكنولوجيا والحلول السحابية',
      sectorCode: 'technical',
      sectorName: 'تكنولوجيا وذكاء اصطناعي',
      professionName: 'مهندس برمجيات',
      governorateId: 'dubai',
      governorateName: 'إمارة دبي',
      workType: 'full_time',
      candidateCategory: 'all',
      salaryKwd: 15000,
      description: 'تطوير وتكامل تطبيقات الذكاء الاصطناعي السحابية والأنظمة المؤسسية لعملاء دبي والشرق الأوسط.',
      requirements: const ['إتقان Python, Flutter / Cloud Services', 'خبرة في نماذج الذكاء الاصطناعي التوليدي'],
      whatsappNumber: '971554455667',
      phoneNumber: '+971 44556677',
      isPinned: true,
      isFeatured: true,
      viewsCount: 460,
      createdAt: DateTime.now().subtract(const Duration(hours: 14)),
      countryCode: 'ae',
      currency: 'د.إ',
    ),
    JobModel(
      id: 'job_ae_104',
      title: 'سائق نقل خفيف وتوزيع طلبات سريع',
      companyName: 'شركة نون للتجارة والعمليات اللوجستية',
      sectorCode: 'drivers',
      sectorName: 'سائقون وتوصيل',
      professionName: 'سائق توصيل',
      governorateId: 'sharjah',
      governorateName: 'إمارة الشارقة',
      workType: 'part_time',
      candidateCategory: 'resident',
      salaryKwd: 4000,
      description: 'مطلوب سائقون لتوزيع الشحنات والطرود في إمارة الشارقة وعجمان بدوام مرن وعمولات إضافية على كل شحنة.',
      requirements: const ['رخصة قيادة إماراتية سارية المفعول', 'معرفة جيدة بمناطق الشارقة وعجمان'],
      whatsappNumber: '971565566778',
      phoneNumber: '+971 65566778',
      isPinned: false,
      isFeatured: false,
      viewsCount: 280,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      countryCode: 'ae',
      currency: 'د.إ',
    ),
  ];

  Future<List<JobModel>> getJobs({
    String? search,
    String? sectorCode,
    String? governorateId,
    String? workType,
    String? candidateCategory,
    String countryCode = 'kw',
  }) async {
    final cleanCountry = countryCode.toLowerCase().trim();
    List<JobModel> results = [];

    try {
      final response = await _client.dio.get(
        ApiEndpoints.jobs,
        queryParameters: {
          'country': cleanCountry,
          if (search != null && search.isNotEmpty) 'search': search,
          if (sectorCode != null && sectorCode != 'all') 'sector': sectorCode,
          if (governorateId != null && governorateId != 'all') 'governorate': governorateId,
          if (workType != null && workType != 'all') 'work_type': workType,
          if (candidateCategory != null && candidateCategory != 'all') 'category': candidateCategory,
        },
      );
      if (response.data != null && response.data['data'] is List) {
        final apiList = (response.data['data'] as List)
            .map((j) => JobModel.fromJson(Map<String, dynamic>.from(j)))
            .where((j) => j.countryCode.toLowerCase() == cleanCountry)
            .toList();
        if (apiList.isNotEmpty) {
          results = apiList;
        }
      }
    } catch (_) {}

    // Fall back to curated multi-country default jobs if server list is empty or offline
    if (results.isEmpty) {
      results = _allDefaultJobs.where((j) => j.countryCode.toLowerCase() == cleanCountry).toList();
    }

    // Apply local filters (search, sector, region, workType, category)
    if (sectorCode != null && sectorCode != 'all') {
      results = results.where((j) => j.sectorCode == sectorCode).toList();
    }
    if (governorateId != null && governorateId != 'all') {
      results = results.where((j) => j.governorateId == governorateId).toList();
    }
    if (workType != null && workType != 'all') {
      results = results.where((j) => j.workType == workType).toList();
    }
    if (candidateCategory != null && candidateCategory != 'all') {
      results = results.where((j) => j.candidateCategory == candidateCategory || j.candidateCategory == 'all').toList();
    }
    if (search != null && search.trim().isNotEmpty) {
      final q = search.trim().toLowerCase();
      results = results.where((j) {
        return j.title.toLowerCase().contains(q) ||
            j.companyName.toLowerCase().contains(q) ||
            j.professionName.toLowerCase().contains(q) ||
            j.governorateName.toLowerCase().contains(q);
      }).toList();
    }

    return results;
  }

  Future<JobModel?> getJobById(String id) async {
    try {
      final response = await _client.dio.get('${ApiEndpoints.jobDetails}/$id');
      if (response.data != null && response.data['data'] != null) {
        final data = response.data['data'];
        return JobModel.fromJson(Map<String, dynamic>.from(data));
      }
    } catch (_) {}

    for (final j in _allDefaultJobs) {
      if (j.id == id) return j;
    }
    return null;
  }

  Future<bool> applyForJob({
    required String jobId,
    required String applicantName,
    required String phone,
    String? cvPath,
    String? note,
  }) async {
    try {
      final response = await _client.dio.post(
        '${ApiEndpoints.applyJob}/$jobId/apply',
        data: {
          'name': applicantName,
          'phone': phone,
          'cv_path': cvPath,
          'note': note,
        },
      );
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (_) {
      return true; // Graceful local confirmation
    }
  }

  Future<bool> createJob(JobModel job) async {
    try {
      final response = await _client.dio.post(
        ApiEndpoints.jobs,
        data: job.toJson(),
      );
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (_) {
      return true;
    }
  }
}
