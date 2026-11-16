import '../core/network/api_client.dart';
import '../core/network/api_endpoints.dart';
import '../models/applicant_model.dart';

class ApplicantsService {
  final ApiClient _client = ApiClient();

  static final List<ApplicantModel> defaultApplicants = [
    const ApplicantModel(
      id: 'app_kw_c1',
      name: 'Mohamed Abass Kamara',
      profession: 'Construction Worker',
      sector: 'construction',
      subSector: 'Concrete & Structure',
      nationality: 'Sierra Leone',
      governorate: 'Hawalli',
      experience: '8 yrs exp.',
      experienceYears: 8,
      age: 29,
      email: 'mabasskamara@gmail.com',
      locationType: 'outside',
      photoUrl: 'assets/images/candidate_kamara_hero.jpg',
      heroImage: 'assets/images/candidate_kamara_hero.jpg',
      views: 13,
      phone: '96560356945',
      whatsapp: '96560356945',
      bio: 'Hard working and quick to adapt',
      attachmentImages: [
        'assets/images/candidate_kamara_hero.jpg',
        'assets/images/candidate_worker1.jpg',
      ],
      resumeFileName: 'Mohamed_Abass_Kamara_CV.pdf',
      resumePreviewImage: 'assets/images/candidate_cv_preview.jpg',
    ),
    const ApplicantModel(
      id: 'app_kw_c2',
      name: 'Meraj Ansari',
      profession: 'Construction Worker',
      sector: 'construction',
      subSector: 'Concrete & Structure',
      nationality: 'India',
      governorate: 'Al Farwaniyah',
      experience: '20 yrs exp.',
      locationType: 'inside',
      photoUrl: 'assets/images/candidate_worker2.jpg',
      views: 0,
      phone: '+965 97223344',
      whatsapp: '96597223344',
    ),
    const ApplicantModel(
      id: 'app_kw_c3',
      name: 'Mohan singh',
      profession: 'Doors Finish Carpenter',
      sector: 'construction',
      subSector: 'Finishing & Carpentry',
      nationality: 'Kuwait',
      governorate: 'Capital',
      experience: '5 yrs exp.',
      locationType: 'inside',
      photoUrl: 'assets/images/candidate_worker3.jpg',
      views: 0,
      phone: '+965 96334455',
      whatsapp: '96596334455',
    ),
    const ApplicantModel(
      id: 'app_kw_c4',
      name: 'Laxminarayana',
      profession: 'Building Electrician',
      sector: 'construction',
      subSector: 'Electrical & Plumbing',
      nationality: 'India',
      governorate: 'Al Ahmadi',
      experience: '4 yrs exp.',
      locationType: 'inside',
      photoUrl: 'assets/images/candidate_worker4.jpg',
      views: 1,
      phone: '+965 95445566',
      whatsapp: '96595445566',
    ),
    const ApplicantModel(
      id: 'app_kw_c5',
      name: 'Salman khan',
      profession: 'Concrete Structure Carpenter',
      sector: 'construction',
      subSector: 'Concrete & Structure',
      nationality: 'India',
      governorate: 'Jahra',
      experience: '6 yrs exp.',
      locationType: 'inside',
      photoUrl: null,
      views: 5,
      phone: '+965 94556677',
      whatsapp: '96594556677',
    ),
    const ApplicantModel(
      id: 'app_kw_c6',
      name: 'Ahmed yousef',
      profession: 'Exterior Painter',
      sector: 'construction',
      subSector: 'Finishing & Carpentry',
      nationality: 'Egypt',
      governorate: 'Hawalli',
      experience: '11 yrs exp.',
      locationType: 'inside',
      photoUrl: 'assets/images/candidate_worker3.jpg',
      views: 4,
      phone: '+965 93667788',
      whatsapp: '96593667788',
    ),
    const ApplicantModel(
      id: 'app_kw_c7',
      name: 'Kareem Al-Sayed',
      profession: 'Formwork Carpenter (Columns & Slabs)',
      sector: 'construction',
      subSector: 'Concrete & Structure',
      nationality: 'Egypt',
      governorate: 'Mubarak Al-Kabeer',
      experience: '9 yrs exp.',
      locationType: 'inside',
      photoUrl: null,
      views: 12,
      phone: '+965 92778899',
      whatsapp: '96592778899',
    ),
    const ApplicantModel(
      id: 'app_kw_c8',
      name: 'Rajesh Varma',
      profession: 'Rebar Steel Fixer (Columns & Slabs)',
      sector: 'construction',
      subSector: 'Rebar & Steel',
      nationality: 'India',
      governorate: 'Al Farwaniyah',
      experience: '7 yrs exp.',
      locationType: 'inside',
      photoUrl: 'assets/images/candidate_worker2.jpg',
      views: 8,
      phone: '+965 91889900',
      whatsapp: '96591889900',
    ),
    const ApplicantModel(
      id: 'app_out_c1',
      name: 'Zahid MD Alamgir',
      profession: 'Site Cleanliness Worker',
      sector: 'construction',
      subSector: 'Concrete & Structure',
      nationality: 'BGD',
      governorate: 'All',
      experience: '4-10 yrs exp.',
      locationType: 'outside',
      photoUrl: null,
      views: 13,
      phone: '+880 1712345678',
      whatsapp: '8801712345678',
    ),
    const ApplicantModel(
      id: 'app_out_c2',
      name: 'Sharafat Ali Shaikh',
      profession: 'Gypsum Board Installer',
      sector: 'construction',
      subSector: 'Finishing & Carpentry',
      nationality: 'Pakistan',
      governorate: 'All',
      experience: '8-10 yrs exp.',
      locationType: 'outside',
      photoUrl: null,
      views: 11,
      phone: '+92 3001234567',
      whatsapp: '923001234567',
    ),
    const ApplicantModel(
      id: 'app_out_c3',
      name: 'Hadi ansari',
      profession: 'Building Electrician',
      sector: 'construction',
      subSector: 'Electrical & Plumbing',
      nationality: 'India',
      governorate: 'All',
      experience: '6 yrs exp.',
      locationType: 'outside',
      photoUrl: null,
      views: 13,
      phone: '+91 9876543210',
      whatsapp: '919876543210',
    ),
    const ApplicantModel(
      id: 'app_out_c4',
      name: 'Tariq Mahmood',
      profession: 'Steel/Rebar Foreman',
      sector: 'construction',
      subSector: 'Rebar & Steel',
      nationality: 'Pakistan',
      governorate: 'All',
      experience: '12 yrs exp.',
      locationType: 'outside',
      photoUrl: 'assets/images/candidate_worker2.jpg',
      views: 19,
      phone: '+92 3123456789',
      whatsapp: '923123456789',
    ),
    const ApplicantModel(
      id: 'app_med_1',
      name: 'Shaymaa Ahmed',
      profession: 'Blood Bank Specialist',
      sector: 'medical',
      subSector: 'Labs & Imaging',
      nationality: 'Egypt',
      governorate: 'All',
      experience: '5 yrs exp.',
      locationType: 'outside',
      photoUrl: 'assets/images/candidate_nurse1.jpg',
      views: 1,
      phone: '+20 1012345678',
      whatsapp: '201012345678',
    ),
    const ApplicantModel(
      id: 'app_med_2',
      name: 'Haroon shamoun',
      profession: 'General Nurse',
      sector: 'medical',
      subSector: 'Nursing',
      nationality: 'Pakistan',
      governorate: 'All',
      experience: '1-2 yrs exp.',
      locationType: 'outside',
      photoUrl: null,
      views: 2,
      phone: '+92 3331234567',
      whatsapp: '923331234567',
    ),
    const ApplicantModel(
      id: 'app_med_3',
      name: 'Mohammed murad',
      profession: 'General Physiotherapist',
      sector: 'medical',
      subSector: 'Physiotherapy & Pharmacy',
      nationality: 'BGD',
      governorate: 'All',
      experience: '3 yrs exp.',
      locationType: 'outside',
      photoUrl: null,
      views: 1,
      phone: '+880 1812345678',
      whatsapp: '8801812345678',
    ),
    const ApplicantModel(
      id: 'app_med_4',
      name: 'Suleman wajid',
      profession: 'ICU Nurse',
      sector: 'medical',
      subSector: 'Nursing',
      nationality: 'Pakistan',
      governorate: 'All',
      experience: '4 yrs exp.',
      locationType: 'outside',
      photoUrl: 'assets/images/candidate_doctor1.jpg',
      views: 4,
      phone: '+92 3451234567',
      whatsapp: '923451234567',
    ),
    const ApplicantModel(
      id: 'app_med_5',
      name: 'Inas Abdullah',
      profession: 'OR Nurse',
      sector: 'medical',
      subSector: 'Nursing',
      nationality: 'Egypt',
      governorate: 'All',
      experience: '14 yrs exp.',
      locationType: 'outside',
      photoUrl: null,
      views: 14,
      phone: '+20 1112345678',
      whatsapp: '201112345678',
    ),
    const ApplicantModel(
      id: 'app_med_6',
      name: 'Dr. Fatima Al-Zahraa',
      profession: 'General Physician',
      sector: 'medical',
      subSector: 'Doctors',
      nationality: 'Egypt',
      governorate: 'Capital',
      experience: '8 yrs exp.',
      locationType: 'inside',
      photoUrl: 'assets/images/candidate_nurse1.jpg',
      views: 22,
      phone: '+965 99443322',
      whatsapp: '96599443322',
    ),
    const ApplicantModel(
      id: 'app_drv_1',
      name: 'Tariq Mehmood',
      profession: 'Heavy Duty Trailer Driver',
      sector: 'drivers',
      subSector: 'Heavy Drivers',
      nationality: 'Pakistan',
      governorate: 'Al Ahmadi',
      experience: '9 yrs exp.',
      locationType: 'inside',
      photoUrl: 'assets/images/candidate_worker2.jpg',
      views: 18,
      phone: '+965 99551122',
      whatsapp: '96599551122',
    ),
    const ApplicantModel(
      id: 'app_drv_2',
      name: 'Rajesh Kumar',
      profession: 'Light Vehicle Delivery Driver',
      sector: 'drivers',
      subSector: 'Light Drivers',
      nationality: 'India',
      governorate: 'Hawalli',
      experience: '4 yrs exp.',
      locationType: 'inside',
      photoUrl: null,
      views: 9,
      phone: '+965 99778844',
      whatsapp: '96599778844',
    ),
    const ApplicantModel(
      id: 'app_drv_3',
      name: 'Billal Hossain',
      profession: 'Motorcycle Delivery Courier',
      sector: 'drivers',
      subSector: 'Motorcycle Delivery',
      nationality: 'BGD',
      governorate: 'Al Farwaniyah',
      experience: '3 yrs exp.',
      locationType: 'inside',
      photoUrl: 'assets/images/candidate_worker4.jpg',
      views: 15,
      phone: '+965 99332211',
      whatsapp: '96599332211',
    ),
  ];

  Future<List<ApplicantModel>> getApplicants({
    String? sector,
    String? subSector,
    String? profession,
    String? governorate,
    String? locationType,
    String? search,
  }) async {
    try {
      final queryParams = <String, String>{};
      if (sector != null && sector != 'all') queryParams['sector'] = sector;
      if (subSector != null && subSector != 'All') queryParams['sub_sector'] = subSector;
      if (profession != null && profession.isNotEmpty && profession != 'All professions') {
        queryParams['profession'] = profession;
      }
      if (governorate != null && governorate.isNotEmpty && governorate != 'All Governorates') {
        queryParams['governorate'] = governorate;
      }
      if (locationType != null && locationType.isNotEmpty) {
        queryParams['location_type'] = locationType;
      }
      if (search != null && search.trim().isNotEmpty) {
        queryParams['search'] = search.trim();
      }

      final res = await _client.dio.get(ApiEndpoints.applicants, queryParameters: queryParams);
      if (res.statusCode == 200 && res.data != null) {
        final data = res.data;
        List list = [];
        if (data is Map && data['data'] is List) {
          list = data['data'];
        } else if (data is List) {
          list = data;
        }
        if (list.isNotEmpty) {
          return list.map((item) => ApplicantModel.fromJson(Map<String, dynamic>.from(item))).toList();
        }
      }
    } catch (_) {}

    return [];
  }

  Future<ApplicantModel?> getApplicantById(String id) async {
    try {
      final response = await _client.dio.get('${ApiEndpoints.applicants}/$id');
      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;
        if (data is Map<String, dynamic>) {
          return ApplicantModel.fromJson(data);
        } else if (data is Map) {
          return ApplicantModel.fromJson(Map<String, dynamic>.from(data));
        }
      }
    } catch (_) {}
    return null;
  }

  List<ApplicantModel> _filterLocal({
    String? sector,
    String? subSector,
    String? profession,
    String? governorate,
    String? locationType,
    String? search,
  }) {
    return defaultApplicants.where((a) {
      if (sector != null && sector != 'all' && a.sector != sector) {
        return false;
      }
      if (subSector != null && subSector != 'All' && a.subSector != subSector) {
        return false;
      }
      if (profession != null && profession.isNotEmpty && profession != 'All professions' && a.profession != profession) {
        return false;
      }
      if (governorate != null && governorate.isNotEmpty && governorate != 'All Governorates' && a.governorate != governorate) {
        return false;
      }
      if (locationType != null && locationType.isNotEmpty && a.locationType != locationType) {
        return false;
      }
      if (search != null && search.trim().isNotEmpty) {
        final q = search.trim().toLowerCase();
        final inName = a.name.toLowerCase().contains(q);
        final inProf = a.profession.toLowerCase().contains(q);
        final inNat = a.nationality.toLowerCase().contains(q);
        if (!inName && !inProf && !inNat) return false;
      }
      return true;
    }).toList();
  }
}
