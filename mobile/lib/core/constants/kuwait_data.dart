class KuwaitData {
  static const String countryNameAr = 'دولة الكويت';
  static const String countryNameEn = 'State of Kuwait';
  static const String currencyAr = 'د.ك';
  static const String currencyEn = 'KWD';
  static const String countryCode = '+965';

  // 6 Kuwait Governorates
  static const List<Map<String, String>> governorates = [
    {'id': 'capital', 'name_ar': 'محافظة العاصمة', 'name_en': 'Capital (Al Asimah)'},
    {'id': 'hawalli', 'name_ar': 'محافظة حولي', 'name_en': 'Hawalli'},
    {'id': 'farwaniya', 'name_ar': 'محافظة الفروانية', 'name_en': 'Farwaniya'},
    {'id': 'ahmadi', 'name_ar': 'محافظة الأحمدي', 'name_en': 'Ahmadi'},
    {'id': 'jahra', 'name_ar': 'محافظة الجهراء', 'name_en': 'Jahra'},
    {'id': 'mubarak', 'name_ar': 'محافظة مبارك الكبير', 'name_en': 'Mubarak Al-Kabeer'},
  ];

  // Nationalities commonly active in Kuwait labor market
  static const List<Map<String, String>> nationalities = [
    {'id': 'kw', 'name_ar': 'كويتي', 'name_en': 'Kuwaiti'},
    {'id': 'eg', 'name_ar': 'مصري', 'name_en': 'Egyptian'},
    {'id': 'in', 'name_ar': 'هندي', 'name_en': 'Indian'},
    {'id': 'pk', 'name_ar': 'باكستاني', 'name_en': 'Pakistani'},
    {'id': 'bd', 'name_ar': 'بنغلاديشي', 'name_en': 'Bangladeshi'},
    {'id': 'ph', 'name_ar': 'فلبيني', 'name_en': 'Filipino'},
    {'id': 'sy', 'name_ar': 'سوري', 'name_en': 'Syrian'},
    {'id': 'jo', 'name_ar': 'أردني', 'name_en': 'Jordanian'},
    {'id': 'lb', 'name_ar': 'لبناني', 'name_en': 'Lebanese'},
    {'id': 'np', 'name_ar': 'نيبالي', 'name_en': 'Nepali'},
    {'id': 'lk', 'name_ar': 'سريلانكي', 'name_en': 'Sri Lankan'},
    {'id': 'other', 'name_ar': 'أخرى', 'name_en': 'Other'},
  ];

  // ==========================================================================
  // Job Seeker Sectors (All 27 Kuwait Market Sectors)
  // ==========================================================================
  static const List<Map<String, dynamic>> jobSeekerSectors = [
    // 1. Construction Sector (المقاولات والإنشاءات)
    {
      'code': 'construction',
      'name_ar': 'قطاع المقاولات والإنشاءات',
      'name_en': 'Construction Sector',
      'image': 'assets/images/sector_construction.jpg',
      'subSectors': [
        'Concrete & Structure',
        'Rebar & Steel',
        'Interior Finishing',
        'Plumbing, Electrical & AC',
        'Facades, Aluminum & Glass',
        'Safety & Site Management',
        'Warehouses & Site Support',
        'Heavy Construction & Earthmoving Equipment Drivers',
        'Heavy Lifting & Cranes Drivers',
      ],
      'professions': [
        // Concrete & Structure
        {'id': 'cs_1', 'name_en': 'Formwork Carpenter (Columns & Slabs)', 'name_ar': 'نجار خشب مسلّح (أعمدة وأسقف)', 'subSector': 'Concrete & Structure'},
        {'id': 'cs_2', 'name_en': 'Concrete Pourer', 'name_ar': 'صباب خرسانة جاهزة', 'subSector': 'Concrete & Structure'},
        {'id': 'cs_3', 'name_en': 'Concrete Structure Carpenter', 'name_ar': 'نجار هياكل خرسانية', 'subSector': 'Concrete & Structure'},
        {'id': 'cs_4', 'name_en': 'Concrete Formwork Worker', 'name_ar': 'عامل نجارة وقوالب خرسانية', 'subSector': 'Concrete & Structure'},
        {'id': 'cs_5', 'name_en': 'Concrete Foreman', 'name_ar': 'مراقب وملاحظ خرسانة', 'subSector': 'Concrete & Structure'},
        {'id': 'cs_6', 'name_en': 'Foundations Worker', 'name_ar': 'عامل أساسات خرسانية', 'subSector': 'Concrete & Structure'},
        {'id': 'cs_7', 'name_en': 'Construction Worker', 'name_ar': 'عامل إنشاءات ومباني', 'subSector': 'Concrete & Structure'},

        // Rebar & Steel
        {'id': 'rs_1', 'name_en': 'Rebar Steel Fixer (Columns & Slabs)', 'name_ar': 'حداد تسليح (أعمدة وأسقف)', 'subSector': 'Rebar & Steel'},
        {'id': 'rs_2', 'name_en': 'Steel/Rebar Foreman', 'name_ar': 'مراقب وملاحظ حدادة مسلحة', 'subSector': 'Rebar & Steel'},
        {'id': 'rs_3', 'name_en': 'Rebar Tying Worker', 'name_ar': 'عامل تربيط وتجنيط حديد', 'subSector': 'Rebar & Steel'},
        {'id': 'rs_4', 'name_en': 'Rebar Steel Fixer (Foundations)', 'name_ar': 'حداد تسليح أساسات وقواعد', 'subSector': 'Rebar & Steel'},

        // Interior Finishing
        {'id': 'fin_1', 'name_en': 'Exterior Painter', 'name_ar': 'صباغ واجهات وخارجي', 'subSector': 'Interior Finishing'},
        {'id': 'fin_2', 'name_en': 'Wallpaper Technician', 'name_ar': 'فني تركيب ورق جدران', 'subSector': 'Interior Finishing'},
        {'id': 'fin_3', 'name_en': 'Interior Painter', 'name_ar': 'صباغ داخلي وديكورات', 'subSector': 'Interior Finishing'},
        {'id': 'fin_4', 'name_en': 'Gypsum Board Technician', 'name_ar': 'فني جبس بورد وأسقف معلقة', 'subSector': 'Interior Finishing'},
        {'id': 'fin_5', 'name_en': 'Doors Finish Carpenter', 'name_ar': 'نجار تركيب وتشطيب أبواب', 'subSector': 'Interior Finishing'},
        {'id': 'fin_6', 'name_en': 'Cabinets Carpenter', 'name_ar': 'نجار كبتات وخزائن ومطابخ', 'subSector': 'Interior Finishing'},
        {'id': 'fin_7', 'name_en': 'Floor Tiles Technician', 'name_ar': 'فني تركيب سيراميك وبورسلان وأرضيات', 'subSector': 'Interior Finishing'},

        // Plumbing, Electrical & AC
        {'id': 'mep_1', 'name_en': 'Building Electrician (Rough-in)', 'name_ar': 'كهربائي تأسيس وتمديدات مباني', 'subSector': 'Plumbing, Electrical & AC'},
        {'id': 'mep_2', 'name_en': 'Fire Alarm Technician', 'name_ar': 'فني أنظمة إنذار ومكافحة حريق', 'subSector': 'Plumbing, Electrical & AC'},
        {'id': 'mep_3', 'name_en': 'Central & Split AC Technician', 'name_ar': 'فني تكييف مركزي ووحدات سبليت', 'subSector': 'Plumbing, Electrical & AC'},
        {'id': 'mep_4', 'name_en': 'Elevator Installer', 'name_ar': 'فني تركيب مصاعد', 'subSector': 'Plumbing, Electrical & AC'},
        {'id': 'mep_5', 'name_en': 'Elevator Maintenance Technician', 'name_ar': 'فني صيانة مصاعد', 'subSector': 'Plumbing, Electrical & AC'},
        {'id': 'mep_6', 'name_en': 'Plumber (Rough-in)', 'name_ar': 'فني صحي تأسيس وتمديدات', 'subSector': 'Plumbing, Electrical & AC'},

        // Facades, Aluminum & Glass
        {'id': 'ag_1', 'name_en': 'Glass Facade Technician', 'name_ar': 'فني واجهات زجاجية واستركشر', 'subSector': 'Facades, Aluminum & Glass'},
        {'id': 'ag_2', 'name_en': 'Stainless Handrail Technician', 'name_ar': 'فني دربزينات وستانلس ستيل', 'subSector': 'Facades, Aluminum & Glass'},
        {'id': 'ag_3', 'name_en': 'Aluminum Windows & Doors Technician', 'name_ar': 'فني شبابيك وأبواب ألمنيوم', 'subSector': 'Facades, Aluminum & Glass'},

        // Safety & Site Management
        {'id': 'ssm_1', 'name_en': 'Site Cleanliness Supervisor', 'name_ar': 'مشرف نظافة وترتيب موقع', 'subSector': 'Safety & Site Management'},
        {'id': 'ssm_2', 'name_en': 'Construction Site Guard', 'name_ar': 'حارس موقع إنشائي', 'subSector': 'Safety & Site Management'},
        {'id': 'ssm_3', 'name_en': 'Debris Removal Supervisor', 'name_ar': 'مشرف ترحيل أنقاض ومخلفات', 'subSector': 'Safety & Site Management'},
        {'id': 'ssm_4', 'name_en': 'OHS Safety Officer', 'name_ar': 'ضابط صحة وسلامة مهنية (OHS)', 'subSector': 'Safety & Site Management'},

        // Warehouses & Site Support
        {'id': 'wss_1', 'name_en': 'Construction Materials Storekeeper', 'name_ar': 'أمين مستودع مواد بناء وإنشاءات', 'subSector': 'Warehouses & Site Support'},
        {'id': 'wss_2', 'name_en': 'Site Clerk', 'name_ar': 'كاتب موقع ومساعد إداري ميداني', 'subSector': 'Warehouses & Site Support'},
        {'id': 'wss_3', 'name_en': 'Assistant Site Supervisor', 'name_ar': 'مساعد مشرف موقع إنشائي', 'subSector': 'Warehouses & Site Support'},

        // Heavy Construction & Earthmoving Equipment Drivers
        {'id': 'hce_1', 'name_en': 'Excavator Operator', 'name_ar': 'سائق حفار (بوكلين)', 'subSector': 'Heavy Construction & Earthmoving Equipment Drivers'},
        {'id': 'hce_2', 'name_en': 'Wheel Loader (Shovel) Operator', 'name_ar': 'سائق لودر (شوفر)', 'subSector': 'Heavy Construction & Earthmoving Equipment Drivers'},
        {'id': 'hce_3', 'name_en': 'Bulldozer Operator', 'name_ar': 'سائق بولدوزر', 'subSector': 'Heavy Construction & Earthmoving Equipment Drivers'},
        {'id': 'hce_4', 'name_en': 'Motor Grader Operator', 'name_ar': 'سائق جريدر تسوية', 'subSector': 'Heavy Construction & Earthmoving Equipment Drivers'},
        {'id': 'hce_5', 'name_en': 'Road Roller / Compactor Operator', 'name_ar': 'سائق رصاصة ودكاك أسفلت', 'subSector': 'Heavy Construction & Earthmoving Equipment Drivers'},
        {'id': 'hce_6', 'name_en': 'Piling / Drilling Machine Operator', 'name_ar': 'سائق ماكينة حفر ودق خوازيق', 'subSector': 'Heavy Construction & Earthmoving Equipment Drivers'},

        // Heavy Lifting & Cranes Drivers
        {'id': 'hlc_1', 'name_en': 'Tower Crane Operator', 'name_ar': 'سائق رافعة برجية (تاور كرين)', 'subSector': 'Heavy Lifting & Cranes Drivers'},
        {'id': 'hlc_2', 'name_en': 'Boom Truck Operator', 'name_ar': 'سائق شاحنة بوم ونش', 'subSector': 'Heavy Lifting & Cranes Drivers'},
        {'id': 'hlc_3', 'name_en': 'Crawler Crane Operator', 'name_ar': 'سائق رافعة جنزير (كرين)', 'subSector': 'Heavy Lifting & Cranes Drivers'},
        {'id': 'hlc_4', 'name_en': 'Telescopic Handler Driver', 'name_ar': 'سائق رافعة تلسكوبية (مانيتو)', 'subSector': 'Heavy Lifting & Cranes Drivers'},
      ],
    },

    // 2. Transport, Delivery and Drivers Sector (النقل والتوصيل والسائقين)
    {
      'code': 'drivers',
      'name_ar': 'قطاع النقل والتوصيل والسائقين',
      'name_en': 'Transport, Delivery and Drivers Sector',
      'image': 'assets/images/sector_transport.jpg',
      'subSectors': [
        'Drivers & Delivery',
        'Fleet Operations',
        'Heavy & Medium Transport Trucks',
        'Light & Warehouse Equipment Drivers',
        'Warehouse & Sorting',
      ],
      'professions': [
        // Drivers & Delivery
        {'id': 'dr_1', 'name_en': 'Delivery Driver (Car)', 'name_ar': 'سائق توصيل طلبات (سيارة)', 'subSector': 'Drivers & Delivery'},
        {'id': 'dr_2', 'name_en': 'Delivery Driver (Bike)', 'name_ar': 'سائق دراجة نارية للتوصيل', 'subSector': 'Drivers & Delivery'},
        {'id': 'dr_3', 'name_en': 'Courier Van Driver', 'name_ar': 'سائق فان شحن وطرود سريعة', 'subSector': 'Drivers & Delivery'},
        {'id': 'dr_4', 'name_en': 'Staff Bus Driver', 'name_ar': 'سائق حافلة نقل موظفين', 'subSector': 'Drivers & Delivery'},
        {'id': 'dr_5', 'name_en': 'School Bus Driver', 'name_ar': 'سائق حافلة مدارس', 'subSector': 'Drivers & Delivery'},
        {'id': 'dr_6', 'name_en': 'Private Driver', 'name_ar': 'سائق خاص وعائلات وشخصيات', 'subSector': 'Drivers & Delivery'},

        // Fleet Operations
        {'id': 'fl_1', 'name_en': 'Fleet Supervisor', 'name_ar': 'مشرف أسطول ونقليات', 'subSector': 'Fleet Operations'},
        {'id': 'fl_2', 'name_en': 'Vehicle Tracking Officer', 'name_ar': 'مسؤول تتبع حركة المركبات GPS', 'subSector': 'Fleet Operations'},
        {'id': 'fl_3', 'name_en': 'Delivery Data Entry', 'name_ar': 'مدخل بيانات شحنات وتوصيل', 'subSector': 'Fleet Operations'},
        {'id': 'fl_4', 'name_en': 'Delivery Customer Service', 'name_ar': 'خدمة عملاء ومتابعة شحنات', 'subSector': 'Fleet Operations'},
        {'id': 'fl_5', 'name_en': 'Dispatcher', 'name_ar': 'موزع وموجه رحلات وسائقين', 'subSector': 'Fleet Operations'},

        // Heavy & Medium Transport Trucks
        {'id': 'ht_1', 'name_en': 'Heavy Trailer Driver', 'name_ar': 'سائق تريلا وقاطرة ومقطورة', 'subSector': 'Heavy & Medium Transport Trucks'},
        {'id': 'ht_2', 'name_en': 'Dump Truck Driver', 'name_ar': 'سائق شاحنة قلاب إنشائي', 'subSector': 'Heavy & Medium Transport Trucks'},
        {'id': 'ht_3', 'name_en': 'Tanker Driver (Water/Fuel/Sewage)', 'name_ar': 'سائق تناكر (مياه/وقود/صرف)', 'subSector': 'Heavy & Medium Transport Trucks'},
        {'id': 'ht_4', 'name_en': 'Concrete Mixer Driver', 'name_ar': 'سائق خلاطة خرسانة جاهزة', 'subSector': 'Heavy & Medium Transport Trucks'},
        {'id': 'ht_5', 'name_en': 'Concrete Pump Operator', 'name_ar': 'مشغل مضخة خرسانة', 'subSector': 'Heavy & Medium Transport Trucks'},
        {'id': 'ht_6', 'name_en': 'Flatbed / Car Carrier Driver', 'name_ar': 'سائق ونش سطحة وناقلة سيارات', 'subSector': 'Heavy & Medium Transport Trucks'},
        {'id': 'ht_7', 'name_en': 'Half-Lorry Driver', 'name_ar': 'سائق هاف لوري ونقل خفيف', 'subSector': 'Heavy & Medium Transport Trucks'},
        {'id': 'ht_8', 'name_en': 'Recovery Tow Truck Driver', 'name_ar': 'سائق شاحنة سحب وإنقاذ سيارات', 'subSector': 'Heavy & Medium Transport Trucks'},
        {'id': 'ht_9', 'name_en': 'Winch Driver', 'name_ar': 'سائق ونش ورافعة متحركة', 'subSector': 'Heavy & Medium Transport Trucks'},

        // Light & Warehouse Equipment Drivers
        {'id': 'le_1', 'name_en': 'Forklift Operator', 'name_ar': 'سائق رافعة شوكية فوركلفت', 'subSector': 'Light & Warehouse Equipment Drivers'},
        {'id': 'le_2', 'name_en': 'Reach Truck / Order Picker Operator', 'name_ar': 'سائق رافعة ريتش تراك وجامع طلبيات', 'subSector': 'Light & Warehouse Equipment Drivers'},
        {'id': 'le_3', 'name_en': 'Skid Steer (Bobcat) Operator', 'name_ar': 'سائق بوبكات وجرافة صغيرة', 'subSector': 'Light & Warehouse Equipment Drivers'},
        {'id': 'le_4', 'name_en': 'Manlift / Boom Lift Operator', 'name_ar': 'مشغل مان لفت وبوم لفت', 'subSector': 'Light & Warehouse Equipment Drivers'},
        {'id': 'le_5', 'name_en': 'Scissor Lift Operator', 'name_ar': 'مشغل رافعة مقصية سيزر لفت', 'subSector': 'Light & Warehouse Equipment Drivers'},
        {'id': 'le_6', 'name_en': 'Road Sweeper Machine Operator', 'name_ar': 'سائق مكنسة شوارع آلية', 'subSector': 'Light & Warehouse Equipment Drivers'},
        {'id': 'le_7', 'name_en': 'Agricultural Tractor Operator', 'name_ar': 'سائق جرار زراعي', 'subSector': 'Light & Warehouse Equipment Drivers'},

        // Warehouse & Sorting
        {'id': 'ws_1', 'name_en': 'Loader / Unloader', 'name_ar': 'عامل شحن وتفريغ', 'subSector': 'Warehouse & Sorting'},
        {'id': 'ws_2', 'name_en': 'Shipping Storekeeper', 'name_ar': 'أمين مستودع وشحن', 'subSector': 'Warehouse & Sorting'},
        {'id': 'ws_3', 'name_en': 'Forklift Operator', 'name_ar': 'مشغل رافعة شوكية مستودعات', 'subSector': 'Warehouse & Sorting'},
        {'id': 'ws_4', 'name_en': 'Returns Officer', 'name_ar': 'مسؤول مرتجعات واسترجاع', 'subSector': 'Warehouse & Sorting'},
        {'id': 'ws_5', 'name_en': 'Parcel Sorter', 'name_ar': 'فارز طرود وشحنات', 'subSector': 'Warehouse & Sorting'},
      ],
    },

    // 3. Medical and Healthcare Sector (القطاع الطبي والرعاية الصحية)
    {
      'code': 'medical',
      'name_ar': 'القطاع الطبي والرعاية الصحية',
      'name_en': 'Medical and Healthcare Sector',
      'image': 'assets/images/sector_medical.jpg',
      'subSectors': [
        'Doctors',
        'Nursing',
        'Labs & Imaging',
        'Pharmacy',
        'Rehabilitation & Physical Therapy',
        'Medical Administration',
      ],
      'professions': [
        // Doctors
        {'id': 'doc_1', 'name_en': 'Internal Medicine Doctor', 'name_ar': 'طبيب باطنية', 'subSector': 'Doctors'},
        {'id': 'doc_2', 'name_en': 'Pediatric Doctor', 'name_ar': 'طبيب أطفال', 'subSector': 'Doctors'},
        {'id': 'doc_3', 'name_en': 'OB/GYN Doctor', 'name_ar': 'طبيب نساء وتوليد', 'subSector': 'Doctors'},
        {'id': 'doc_4', 'name_en': 'Dentist', 'name_ar': 'طبيب أسنان', 'subSector': 'Doctors'},
        {'id': 'doc_5', 'name_en': 'Dermatologist', 'name_ar': 'طبيب جلدية', 'subSector': 'Doctors'},
        {'id': 'doc_6', 'name_en': 'Emergency Doctor', 'name_ar': 'طبيب طوارئ', 'subSector': 'Doctors'},
        {'id': 'doc_7', 'name_en': 'ICU Doctor', 'name_ar': 'طبيب عناية مركزة', 'subSector': 'Doctors'},
        {'id': 'doc_8', 'name_en': 'Anesthesiologist', 'name_ar': 'طبيب تخدير', 'subSector': 'Doctors'},
        {'id': 'doc_9', 'name_en': 'Radiologist', 'name_ar': 'طبيب أشعة تشخيصية', 'subSector': 'Doctors'},
        {'id': 'doc_10', 'name_en': 'Cosmetic Surgeon', 'name_ar': 'جراح تجميل', 'subSector': 'Doctors'},
        {'id': 'doc_11', 'name_en': 'Urologist', 'name_ar': 'طبيب مسالك بولية', 'subSector': 'Doctors'},
        {'id': 'doc_12', 'name_en': 'Ear, Nose, and Throat (ENT) Specialist', 'name_ar': 'طبيب أنف وأذن وحنجرة', 'subSector': 'Doctors'},

        // Nursing
        {'id': 'nur_1', 'name_en': 'General Nurse', 'name_ar': 'ممرض عام', 'subSector': 'Nursing'},
        {'id': 'nur_2', 'name_en': 'ICU Nurse', 'name_ar': 'ممرض عناية مركزة', 'subSector': 'Nursing'},
        {'id': 'nur_3', 'name_en': 'ER Nurse', 'name_ar': 'ممرض طوارئ', 'subSector': 'Nursing'},
        {'id': 'nur_4', 'name_en': 'OR Nurse', 'name_ar': 'ممرض غرف عمليات', 'subSector': 'Nursing'},
        {'id': 'nur_5', 'name_en': 'Pediatric Nurse', 'name_ar': 'ممرض أطفال', 'subSector': 'Nursing'},
        {'id': 'nur_6', 'name_en': 'Nursing Assistant', 'name_ar': 'مساعد تمريض', 'subSector': 'Nursing'},
        {'id': 'nur_7', 'name_en': 'Elderly Care Assistant', 'name_ar': 'مساعد رعاية مسنين', 'subSector': 'Nursing'},
        {'id': 'nur_8', 'name_en': 'Maternity & Child Nursing Assistant', 'name_ar': 'مساعد تمريض أمومة وطفولة', 'subSector': 'Nursing'},
        {'id': 'nur_9', 'name_en': 'Home Care Assistant', 'name_ar': 'مساعد رعاية منزلية', 'subSector': 'Nursing'},
        {'id': 'nur_10', 'name_en': 'Health Care Assistant', 'name_ar': 'مساعد رعاية صحية', 'subSector': 'Nursing'},
        {'id': 'nur_11', 'name_en': 'Nanny / Child Caregiver', 'name_ar': 'مربية أطفال وممرضة رعاية', 'subSector': 'Nursing'},

        // Labs & Imaging
        {'id': 'lab_1', 'name_en': 'Blood Bank Specialist', 'name_ar': 'أخصائي بنك الدم', 'subSector': 'Labs & Imaging'},
        {'id': 'lab_2', 'name_en': 'Radiology Technician', 'name_ar': 'فني أشعة تشخيصية', 'subSector': 'Labs & Imaging'},
        {'id': 'lab_3', 'name_en': 'MRI Technician', 'name_ar': 'فني رنين مغناطيسي MRI', 'subSector': 'Labs & Imaging'},
        {'id': 'lab_4', 'name_en': 'Ultrasound Technician', 'name_ar': 'فني سونار وموجات فوق صوتية', 'subSector': 'Labs & Imaging'},
        {'id': 'lab_5', 'name_en': 'Medical Sterilization Technician', 'name_ar': 'فني تعقيم طبي', 'subSector': 'Labs & Imaging'},
        {'id': 'lab_6', 'name_en': 'Lab Technician', 'name_ar': 'فني مختبرات وتحاليل', 'subSector': 'Labs & Imaging'},

        // Pharmacy
        {'id': 'phr_1', 'name_en': 'Pharmacy Assistant', 'name_ar': 'مساعد صيدلي', 'subSector': 'Pharmacy'},
        {'id': 'phr_2', 'name_en': 'Pharmacy Warehouse Technician', 'name_ar': 'فني مستودع أدوية وصيدلة', 'subSector': 'Pharmacy'},
        {'id': 'phr_3', 'name_en': 'Pharmacist', 'name_ar': 'صيدلي قانوني مرخص', 'subSector': 'Pharmacy'},

        // Rehabilitation & Physical Therapy
        {'id': 'pt_1', 'name_en': 'General Physiotherapist', 'name_ar': 'أخصائي علاج طبيعي عام', 'subSector': 'Rehabilitation & Physical Therapy'},
        {'id': 'pt_2', 'name_en': 'Physiotherapy Assistant', 'name_ar': 'مساعد علاج طبيعي', 'subSector': 'Rehabilitation & Physical Therapy'},
        {'id': 'pt_3', 'name_en': 'Speech & Language Therapist', 'name_ar': 'أخصائي علاج نطق وتخاطب', 'subSector': 'Rehabilitation & Physical Therapy'},
        {'id': 'pt_4', 'name_en': 'Pediatric Physiotherapist / Early Intervention', 'name_ar': 'أخصائي علاج طبيعي للأطفال وتدخل مبكر', 'subSector': 'Rehabilitation & Physical Therapy'},
        {'id': 'pt_5', 'name_en': 'Sports & Movement Rehabilitation Specialist', 'name_ar': 'أخصائي تأهيل حركي وإصابات ملاعب', 'subSector': 'Rehabilitation & Physical Therapy'},
        {'id': 'pt_6', 'name_en': 'Behavioral Therapist', 'name_ar': 'أخصائي علاج سلوكي وتعديل سلوك', 'subSector': 'Rehabilitation & Physical Therapy'},
        {'id': 'pt_7', 'name_en': 'Pelvic Floor Physiotherapist', 'name_ar': 'أخصائي علاج طبيعي لقاع الحوض', 'subSector': 'Rehabilitation & Physical Therapy'},
        {'id': 'pt_8', 'name_en': 'Chiropractor', 'name_ar': 'أخصائي كايروبراكتيك وتقويم عظام', 'subSector': 'Rehabilitation & Physical Therapy'},
        {'id': 'pt_9', 'name_en': 'Prosthetics & Orthotics Technician', 'name_ar': 'فني أطراف صناعية وأجهزة تعويضية', 'subSector': 'Rehabilitation & Physical Therapy'},

        // Medical Administration
        {'id': 'adm_1', 'name_en': 'Appointment Coordinator', 'name_ar': 'منسق مواعيد طبية', 'subSector': 'Medical Administration'},
        {'id': 'adm_2', 'name_en': 'Medical Records Clerk', 'name_ar': 'كاتب سجلات وملفات طبية', 'subSector': 'Medical Administration'},
        {'id': 'adm_3', 'name_en': 'Medical Secretary', 'name_ar': 'سكرتير طبي وإداري', 'subSector': 'Medical Administration'},
        {'id': 'adm_4', 'name_en': 'Medical Center Manager', 'name_ar': 'مدير مركز طبي وعيادات', 'subSector': 'Medical Administration'},
        {'id': 'adm_5', 'name_en': 'Clinic Receptionist', 'name_ar': 'موظف استقبال عيادات', 'subSector': 'Medical Administration'},
      ],
    },

    // 4. Technical and Maintenance Sector (الفنيين والصيانة العامة)
    {
      'code': 'technical',
      'name_ar': 'قطاع الفنيين والصيانة العامة',
      'name_en': 'Technical and Maintenance Sector',
      'image': 'assets/images/sector_technical.jpg',
      'subSectors': [
        'HVAC & Cooling',
        'Plumbing',
        'Elevators',
        'Aluminum & Glass',
        'General Maintenance',
      ],
      'professions': [
        {'id': 'tech_1', 'name_en': 'Central AC Technician', 'name_ar': 'فني تكييف مركزي ووحدات', 'subSector': 'HVAC & Cooling'},
        {'id': 'tech_2', 'name_en': 'Installation & Repair Plumber', 'name_ar': 'فني صحي وسباكة ومضخات', 'subSector': 'Plumbing'},
        {'id': 'tech_3', 'name_en': 'Elevator Installation & Repair Tech', 'name_ar': 'فني صيانة وتركيب مصاعد', 'subSector': 'Elevators'},
        {'id': 'tech_4', 'name_en': 'Aluminum & Windows Tech', 'name_ar': 'فني ألمنيوم وشبابيك وشتر', 'subSector': 'Aluminum & Glass'},
        {'id': 'tech_5', 'name_en': 'Home Appliances Technician', 'name_ar': 'فني أجهزة منزلية وغسالات', 'subSector': 'General Maintenance'},
        {'id': 'tech_6', 'name_en': 'Fire Alarm & Safety Tech', 'name_ar': 'فني إنذار حريق ومكافحة', 'subSector': 'General Maintenance'},
      ],
    },

    // 5. Restaurants and Hospitality Sector (المطاعم والضيافة)
    {
      'code': 'restaurants',
      'name_ar': 'قطاع المطاعم والضيافة والفنادق',
      'name_en': 'Restaurants, Hotels & Cafes Sector',
      'image': 'assets/images/sector_restaurants.jpg',
      'subSectors': [
        'Restaurants',
        'Hotels',
        'Cafes',
        'Qahwa',
      ],
      'professions': [
        // Restaurants
        {'id': 'res_1', 'name_en': 'Restaurant Manager', 'name_ar': 'مدير مطعم', 'subSector': 'Restaurants'},
        {'id': 'res_2', 'name_en': 'Chef de Partie (CDP)', 'name_ar': 'شيف دي بارتي', 'subSector': 'Restaurants'},
        {'id': 'res_3', 'name_en': 'Head Chef', 'name_ar': 'شيف عمومي / رئيس طهاة', 'subSector': 'Restaurants'},
        {'id': 'res_4', 'name_en': 'Sous Chef', 'name_ar': 'سوس شيف / مساعد رئيس طهاة', 'subSector': 'Restaurants'},
        {'id': 'res_5', 'name_en': 'Pastry Chef', 'name_ar': 'شيف معجنات ومخبوزات', 'subSector': 'Restaurants'},
        {'id': 'res_6', 'name_en': 'Dessert Chef', 'name_ar': 'شيف حلويات شرقية وغربية', 'subSector': 'Restaurants'},
        {'id': 'res_7', 'name_en': 'Grill Chef', 'name_ar': 'شيف مشويات وشواية', 'subSector': 'Restaurants'},
        {'id': 'res_8', 'name_en': 'Prep Worker', 'name_ar': 'عامل تجهيز وتحضير', 'subSector': 'Restaurants'},
        {'id': 'res_9', 'name_en': 'Restaurant Floor Supervisor', 'name_ar': 'مشرف صالة وضيافة', 'subSector': 'Restaurants'},
        {'id': 'res_10', 'name_en': 'Waiter / Waitress', 'name_ar': 'ويتر / مضيف صالة', 'subSector': 'Restaurants'},
        {'id': 'res_11', 'name_en': 'Restaurant Cashier', 'name_ar': 'كاشير مطعم', 'subSector': 'Restaurants'},
        {'id': 'res_12', 'name_en': 'Dishwasher / Steward', 'name_ar': 'غاسل صحون واستيوارد', 'subSector': 'Restaurants'},

        // Hotels
        {'id': 'hot_1', 'name_en': 'Hotel General Manager', 'name_ar': 'مدير عام فندق', 'subSector': 'Hotels'},
        {'id': 'hot_2', 'name_en': 'Front Office Manager', 'name_ar': 'مدير المكاتب الأمامية', 'subSector': 'Hotels'},
        {'id': 'hot_3', 'name_en': 'Hotel Receptionist', 'name_ar': 'موظف استقبال فندق', 'subSector': 'Hotels'},
        {'id': 'hot_4', 'name_en': 'Hotel Reservations Agent', 'name_ar': 'موظف حجوزات فندقية', 'subSector': 'Hotels'},
        {'id': 'hot_5', 'name_en': 'Concierge / Bellboy', 'name_ar': 'كونسيرج وحامل حقائب', 'subSector': 'Hotels'},
        {'id': 'hot_6', 'name_en': 'Housekeeping Supervisor', 'name_ar': 'مشرف نظافة وغرف (إشراف داخلي)', 'subSector': 'Hotels'},
        {'id': 'hot_7', 'name_en': 'Room Attendant / Housekeeper', 'name_ar': 'عامل نظافة وترتيب غرف', 'subSector': 'Hotels'},
        {'id': 'hot_8', 'name_en': 'Room Service Attendant', 'name_ar': 'مقدم خدمة الغرف', 'subSector': 'Hotels'},
        {'id': 'hot_9', 'name_en': 'Banquet & Events Coordinator', 'name_ar': 'منسق حفلات ومؤتمرات فندقية', 'subSector': 'Hotels'},

        // Cafes
        {'id': 'caf_1', 'name_en': 'Cafe / Branch Manager', 'name_ar': 'مدير مقهى / فرع كافيه', 'subSector': 'Cafes'},
        {'id': 'caf_2', 'name_en': 'Barista', 'name_ar': 'باريستا محترف مشروبات مختصة', 'subSector': 'Cafes'},
        {'id': 'caf_3', 'name_en': 'Pastry & Bakery Chef', 'name_ar': 'شيف مخبوزات وحلويات مقاهي', 'subSector': 'Cafes'},
        {'id': 'caf_4', 'name_en': 'Cafe Service Crew', 'name_ar': 'طاقم خدمة مقهى', 'subSector': 'Cafes'},
        {'id': 'caf_5', 'name_en': 'Cashier', 'name_ar': 'كاشير مقهى', 'subSector': 'Cafes'},

        // Qahwa
        {'id': 'qah_1', 'name_en': 'Qahwa Supervisor', 'name_ar': 'مشرف مقهى شعبي وقهاوي', 'subSector': 'Qahwa'},
        {'id': 'qah_2', 'name_en': 'Shisha Maker / Preparer', 'name_ar': 'معلم ومحضر شيشة', 'subSector': 'Qahwa'},
        {'id': 'qah_3', 'name_en': 'Traditional Beverage Maker (Buffet)', 'name_ar': 'محضر مشروبات شعبية وبوفيه', 'subSector': 'Qahwa'},
        {'id': 'qah_4', 'name_en': 'Qahwa Floor Server', 'name_ar': 'مباشر قهوة وصالة', 'subSector': 'Qahwa'},
      ],
    },

    // 6. Education Sector (التعليم والتدريس)
    {
      'code': 'education',
      'name_ar': 'قطاع التعليم والتدريس',
      'name_en': 'Education Sector',
      'image': 'assets/images/sector_education.jpg',
      'subSectors': [
        'Schools & Teaching',
        'Kindergarten & Nursery',
        'Special Education',
        'Training & Institutes',
      ],
      'professions': [
        {'id': 'edu_1', 'name_en': 'Math & Science Teacher', 'name_ar': 'معلم رياضيات وعلوم', 'subSector': 'Schools & Teaching'},
        {'id': 'edu_2', 'name_en': 'English Language Teacher', 'name_ar': 'معلم لغة إنجليزية', 'subSector': 'Schools & Teaching'},
        {'id': 'edu_3', 'name_en': 'Arabic & Islamic Studies Teacher', 'name_ar': 'معلم لغة عربية وتربية إسلامية', 'subSector': 'Schools & Teaching'},
        {'id': 'edu_4', 'name_en': 'Kindergarten / Nursery Teacher', 'name_ar': 'معلمة رياض أطفال وحضانة', 'subSector': 'Kindergarten & Nursery'},
        {'id': 'edu_5', 'name_en': 'Special Education Specialist', 'name_ar': 'أخصائي تربية خاصة وصعوبات تعلم', 'subSector': 'Special Education'},
        {'id': 'edu_6', 'name_en': 'Training Center Instructor', 'name_ar': 'مدرب معتمد بمراكز تدريب مهني', 'subSector': 'Training & Institutes'},
      ],
    },

    // 7. Engineering Sector (القطاع الهندسي)
    {
      'code': 'engineering',
      'name_ar': 'القطاع الهندسي',
      'name_en': 'Engineering Sector',
      'image': 'assets/images/sector_engineering.jpg',
      'subSectors': [
        'Civil & Structural',
        'Mechanical & MEP',
        'Electrical & Power',
        'Architecture & Design',
        'Surveying & Quantity',
      ],
      'professions': [
        {'id': 'eng_1', 'name_en': 'Civil Site Engineer', 'name_ar': 'مهندس مدني موقع ومشاريع', 'subSector': 'Civil & Structural'},
        {'id': 'eng_2', 'name_en': 'Structural Design Engineer', 'name_ar': 'مهندس إنشائي وتصميم مخططات', 'subSector': 'Civil & Structural'},
        {'id': 'eng_3', 'name_en': 'MEP Mechanical Engineer', 'name_ar': 'مهندس ميكانيك تكييف وصحي MEP', 'subSector': 'Mechanical & MEP'},
        {'id': 'eng_4', 'name_en': 'Electrical Project Engineer', 'name_ar': 'مهندس كهرباء قوى ومشاريع', 'subSector': 'Electrical & Power'},
        {'id': 'eng_5', 'name_en': 'Architectural & Interior Designer', 'name_ar': 'مهندس معماري وتصميم داخلي', 'subSector': 'Architecture & Design'},
        {'id': 'eng_6', 'name_en': 'Quantity Surveyor & Estimator', 'name_ar': 'مهندس حصر كميات وتسعير مناقصات', 'subSector': 'Surveying & Quantity'},
      ],
    },

    // 8. Accounting, Banking and Money Exchange Sector (المحاسبة والمالية والبنوك والصرافة)
    {
      'code': 'accounting',
      'name_ar': 'قطاع المحاسبة والبنوك والصرافة والمالية',
      'name_en': 'Accounting, Banking and Money Exchange Sector',
      'image': 'assets/images/sector_accounting.jpg',
      'subSectors': [
        'Retail & Branch Banking Service',
        'Exchange House & Remittance',
        'Credit, Operations & Support',
        'General Accounting & Auditing',
      ],
      'professions': [
        // Retail & Branch Banking Service
        {'id': 'bnk_1', 'name_en': 'Banking Manager', 'name_ar': 'مدير فرع بنكي', 'subSector': 'Retail & Branch Banking Service'},
        {'id': 'bnk_2', 'name_en': 'Bank Customer Service Officer', 'name_ar': 'موظف خدمة عملاء بنك', 'subSector': 'Retail & Branch Banking Service'},
        {'id': 'bnk_3', 'name_en': 'Branch Sales Officer', 'name_ar': 'مسؤول مبيعات مصرفية', 'subSector': 'Retail & Branch Banking Service'},
        {'id': 'bnk_4', 'name_en': 'Branch Operations Officer', 'name_ar': 'مسؤول عمليات الفرع', 'subSector': 'Retail & Branch Banking Service'},
        {'id': 'bnk_5', 'name_en': 'Cash / Wallet Assistant', 'name_ar': 'مساعد نقدية ومحافظ مالية', 'subSector': 'Retail & Branch Banking Service'},
        {'id': 'bnk_6', 'name_en': 'ATM Replenishment Team', 'name_ar': 'فريق تغذية وصيانة أجهزة السحب الآلي', 'subSector': 'Retail & Branch Banking Service'},
        {'id': 'bnk_7', 'name_en': 'Bank Teller', 'name_ar': 'صراف بنكي', 'subSector': 'Retail & Branch Banking Service'},
        {'id': 'bnk_8', 'name_en': 'Bank Receptionist', 'name_ar': 'موظف استقبال البنك', 'subSector': 'Retail & Branch Banking Service'},

        // Exchange House & Remittance
        {'id': 'ex_1', 'name_en': 'Currency Exchange Manager', 'name_ar': 'مدير فرع صرافة', 'subSector': 'Exchange House & Remittance'},
        {'id': 'ex_2', 'name_en': 'Exchange House Cashier / Teller', 'name_ar': 'كاشير وصراف شركة صرافة', 'subSector': 'Exchange House & Remittance'},
        {'id': 'ex_3', 'name_en': 'Remittance Clerk', 'name_ar': 'موظف حوالات مالية', 'subSector': 'Exchange House & Remittance'},
        {'id': 'ex_4', 'name_en': 'Exchange Branch Supervisor', 'name_ar': 'مشرف فرع صرافة', 'subSector': 'Exchange House & Remittance'},

        // Credit, Operations & Support
        {'id': 'crd_1', 'name_en': 'Credit / Loan Officer', 'name_ar': 'مسؤول قروض وائتمان', 'subSector': 'Credit, Operations & Support'},
        {'id': 'crd_2', 'name_en': 'Collection Officer', 'name_ar': 'مسؤول تحصيل ديون ومستحقات', 'subSector': 'Credit, Operations & Support'},
        {'id': 'crd_3', 'name_en': 'Banking Operations Officer', 'name_ar': 'ضابط عمليات مصرفية', 'subSector': 'Credit, Operations & Support'},
        {'id': 'crd_4', 'name_en': 'Data Entry Clerk (Banking)', 'name_ar': 'مدخل بيانات مصرفية', 'subSector': 'Credit, Operations & Support'},
        {'id': 'crd_5', 'name_en': 'Documentation & KYC Verification Officer', 'name_ar': 'مسؤول توثيق ومطابقة واعرف عميلك (KYC)', 'subSector': 'Credit, Operations & Support'},

        // General Accounting & Auditing
        {'id': 'acc_1', 'name_en': 'General Senior Accountant', 'name_ar': 'محاسب عام أول', 'subSector': 'General Accounting & Auditing'},
        {'id': 'acc_2', 'name_en': 'Internal Auditor', 'name_ar': 'مدقق ومراجع حسابات داخلي', 'subSector': 'General Accounting & Auditing'},
        {'id': 'acc_3', 'name_en': 'Accounts Payable & Receivable', 'name_ar': 'محاسب مدفوعات ومقبوضات', 'subSector': 'General Accounting & Auditing'},
        {'id': 'acc_4', 'name_en': 'Cost & Inventory Accountant', 'name_ar': 'محاسب تكاليف ومستودعات', 'subSector': 'General Accounting & Auditing'},
        {'id': 'acc_5', 'name_en': 'Financial Analyst & Budgeting', 'name_ar': 'محلل مالي وميزانيات', 'subSector': 'General Accounting & Auditing'},
        {'id': 'acc_6', 'name_en': 'Payroll & HR Accountant', 'name_ar': 'محاسب رواتب وشؤون موظفين', 'subSector': 'General Accounting & Auditing'},
      ],
    },

    // 9. Legal Sector (القانوني والمحاماة)
    {
      'code': 'legal',
      'name_ar': 'القطاع القانوني والمحاماة',
      'name_en': 'Legal Sector',
      'image': 'assets/images/sector_legal.jpg',
      'subSectors': [
        'Corporate Legal',
        'Litigation & Court',
        'Contracts & Drafting',
        'Labor Law Compliance',
      ],
      'professions': [
        {'id': 'leg_1', 'name_en': 'Legal Consultant & Corporate Advisor', 'name_ar': 'مستشار قانوني للشركات', 'subSector': 'Corporate Legal'},
        {'id': 'leg_2', 'name_en': 'Litigation Lawyer', 'name_ar': 'محامي ترافع ومحاكم وقضايا', 'subSector': 'Litigation & Court'},
        {'id': 'leg_3', 'name_en': 'Commercial Contracts Drafter', 'name_ar': 'صائغ عقود واتفاقيات تجارية', 'subSector': 'Contracts & Drafting'},
        {'id': 'leg_4', 'name_en': 'Kuwait Labor Law Specialist', 'name_ar': 'أخصائي شؤون قانون العمل الكويتي', 'subSector': 'Labor Law Compliance'},
        {'id': 'leg_5', 'name_en': 'Legal Researcher & Paralegal', 'name_ar': 'باحث قانوني ومساعد محاماة', 'subSector': 'Litigation & Court'},
      ],
    },

    // 10. Beauty & Salon Sector (التجميل والصالونات)
    {
      'code': 'beauty_salon',
      'name_ar': 'قطاع التجميل والصالونات',
      'name_en': 'Beauty & Salon Sector',
      'image': 'assets/images/sector_beauty_salon.jpg',
      'subSectors': [
        'Hair Styling & Color',
        'Makeup & Lashes',
        'Nail Care & Spa',
        'Skincare & Barber',
      ],
      'professions': [
        {'id': 'bs_1', 'name_en': 'Professional Hair Stylist', 'name_ar': 'كوافير / مصفف شعر وتساريح', 'subSector': 'Hair Styling & Color'},
        {'id': 'bs_2', 'name_en': 'Certified Makeup Artist', 'name_ar': 'خبيرة مكياج وتجميل سينمائي وعرائس', 'subSector': 'Makeup & Lashes'},
        {'id': 'bs_3', 'name_en': 'Nail Artist & Manicure/Pedicure', 'name_ar': 'أخصائية أظافر وبديكير ومنيكير', 'subSector': 'Nail Care & Spa'},
        {'id': 'bs_4', 'name_en': 'Skincare & Facial Specialist', 'name_ar': 'أخصائية عناية بالبشرة وتنظيف', 'subSector': 'Skincare & Barber'},
        {'id': 'bs_5', 'name_en': 'Men Professional Barber', 'name_ar': 'حلاق رجالي متمكن قص وسشوار', 'subSector': 'Skincare & Barber'},
        {'id': 'bs_6', 'name_en': 'Beauty Salon Manager', 'name_ar': 'مديرة صالون ومركز تجميل', 'subSector': 'Nail Care & Spa'},
      ],
    },

    // 11. Car & Bike Technicians Sector (فنيي السيارات والدراجات)
    {
      'code': 'car_bike_tech',
      'name_ar': 'قطاع فنيي السيارات والدراجات',
      'name_en': 'Car & Bike Technicians Sector',
      'image': 'assets/images/sector_car_bike_tech.jpg',
      'subSectors': [
        'Auto Mechanics',
        'Auto Electric & Diagnostics',
        'Motorcycle Mechanics',
        'Bodywork & Paint',
      ],
      'professions': [
        {'id': 'cbt_1', 'name_en': 'Auto Mechanic Engine Specialist', 'name_ar': 'ميكانيكي سيارات محركات وجير', 'subSector': 'Auto Mechanics'},
        {'id': 'cbt_2', 'name_en': 'Auto Electrician & Computer Diagnostic', 'name_ar': 'كهربائي سيارات وفحص وبرمجة كمبيوتر', 'subSector': 'Auto Electric & Diagnostics'},
        {'id': 'cbt_3', 'name_en': 'Motorcycle & Delivery Bike Mechanic', 'name_ar': 'ميكانيكي دراجات توصيل وسكوتر', 'subSector': 'Motorcycle Mechanics'},
        {'id': 'cbt_4', 'name_en': 'Car AC & Cooling Specialist', 'name_ar': 'فني تكييف سيارات وكهرباء', 'subSector': 'Auto Electric & Diagnostics'},
        {'id': 'cbt_5', 'name_en': 'Denter & Auto Body Repair', 'name_ar': 'سمكري وحداد هياكل سيارات', 'subSector': 'Bodywork & Paint'},
        {'id': 'cbt_6', 'name_en': 'Car Painter & Polishing Tech', 'name_ar': 'صباغ سيارات وبولش وحماية نانو', 'subSector': 'Bodywork & Paint'},
      ],
    },

    // 12. Content Creation & Digital Marketing Sector (صناعة المحتوى والتسويق الرقمي)
    {
      'code': 'digital_marketing',
      'name_ar': 'قطاع صناعة المحتوى والتسويق الرقمي',
      'name_en': 'Content Creation & Digital Marketing Sector',
      'image': 'assets/images/sector_digital_marketing.jpg',
      'subSectors': [
        'Social Media & Content',
        'Paid Ads & Analytics',
        'Photo & Video Production',
        'Design & 3D',
      ],
      'professions': [
        // Social Media & Content
        {'id': 'dm_1', 'name_en': 'Social Media Specialist', 'name_ar': 'أخصائي إدارة منصات تواصل اجتماعي', 'subSector': 'Social Media & Content'},
        {'id': 'dm_2', 'name_en': 'Short Content Director', 'name_ar': 'مخرج ومصمم محتوى قصير وريلز', 'subSector': 'Social Media & Content'},
        {'id': 'dm_3', 'name_en': 'Marketing Copywriter', 'name_ar': 'كاتب محتوى تسويقي وإعلانات جذاب', 'subSector': 'Social Media & Content'},

        // Paid Ads & Analytics
        {'id': 'dm_4', 'name_en': 'Digital Marketing Expert', 'name_ar': 'خبير واستشاري تسويق رقمي', 'subSector': 'Paid Ads & Analytics'},
        {'id': 'dm_5', 'name_en': 'Paid Ads Expert', 'name_ar': 'خبير حملات إعلانية ممولة سناب وإنستغرام وغوغل', 'subSector': 'Paid Ads & Analytics'},
        {'id': 'dm_6', 'name_en': 'SEO Expert', 'name_ar': 'خبير تحسين محركات البحث SEO', 'subSector': 'Paid Ads & Analytics'},

        // Photo & Video Production
        {'id': 'dm_7', 'name_en': 'Social Videographer', 'name_ar': 'مصور فيديو لمنصات التواصل الاجتماعي', 'subSector': 'Photo & Video Production'},
        {'id': 'dm_8', 'name_en': 'Event Photographer', 'name_ar': 'مصور فعاليات وتغطيات ومناسبات', 'subSector': 'Photo & Video Production'},
        {'id': 'dm_9', 'name_en': 'Product Photographer', 'name_ar': 'مصور منتجات وإعلانات تجارية', 'subSector': 'Photo & Video Production'},
        {'id': 'dm_10', 'name_en': 'Light Assistant', 'name_ar': 'مساعد إضاءة وتصوير سينمائي', 'subSector': 'Photo & Video Production'},
        {'id': 'dm_11', 'name_en': 'Video Editor & Reels Creator', 'name_ar': 'مونتير ومصمم مقاطع ريلز وتيك توك', 'subSector': 'Photo & Video Production'},

        // Design & 3D
        {'id': 'dm_12', 'name_en': '3D Designer', 'name_ar': 'مصمم ثلاثي الأبعاد 3D ونمذجة', 'subSector': 'Design & 3D'},
        {'id': 'dm_13', 'name_en': 'Creative Graphic Designer', 'name_ar': 'مصمم جرافيك وهوية بصرية', 'subSector': 'Design & 3D'},
      ],
    },

    // 13. Insurance Sector (التأمين)
    {
      'code': 'insurance',
      'name_ar': 'قطاع التأمين',
      'name_en': 'Insurance Sector',
      'image': 'assets/images/sector_insurance.jpg',
      'subSectors': [
        'Health Insurance',
        'Vehicle Insurance',
        'Life Insurance',
        'Property Insurance',
        'Claims Management',
        'Insurance Sales',
      ],
      'professions': [
        // Health Insurance
        {'id': 'ins_1', 'name_en': 'Health Insurance Specialist', 'name_ar': 'أخصائي تأمين صحي وتغطيات طبية', 'subSector': 'Health Insurance'},
        {'id': 'ins_2', 'name_en': 'Medical Claims Reviewer', 'name_ar': 'مراجع وفاحص مطالبات طبية', 'subSector': 'Health Insurance'},
        {'id': 'ins_3', 'name_en': 'Health Network Coordinator', 'name_ar': 'منسق شبكة المستشفيات والمراكز الطبية', 'subSector': 'Health Insurance'},

        // Vehicle Insurance
        {'id': 'ins_4', 'name_en': 'Vehicle Insurance Specialist', 'name_ar': 'أخصائي تأمين سيارات وشامل وضد الغير', 'subSector': 'Vehicle Insurance'},
        {'id': 'ins_5', 'name_en': 'Accident Assessor', 'name_ar': 'خبير ومعاين حوادث مركبات', 'subSector': 'Vehicle Insurance'},
        {'id': 'ins_6', 'name_en': 'Vehicle Claim Handler', 'name_ar': 'مسؤول مطالبات وتسويات حوادث سيارات', 'subSector': 'Vehicle Insurance'},

        // Life Insurance
        {'id': 'ins_7', 'name_en': 'Life Insurance Consultant', 'name_ar': 'مستشار تأمين على الحياة والادخار', 'subSector': 'Life Insurance'},
        {'id': 'ins_8', 'name_en': 'Actuarial Analyst', 'name_ar': 'محلل اكتواري وتقدير مخاطر', 'subSector': 'Life Insurance'},
        {'id': 'ins_9', 'name_en': 'Policy Administrator', 'name_ar': 'مسؤول إصدار وإدارة وثائق تأمين', 'subSector': 'Life Insurance'},

        // Property Insurance
        {'id': 'ins_10', 'name_en': 'Property Underwriter', 'name_ar': 'مكتتب تأمين ممتلكات وحرائق ومنشآت', 'subSector': 'Property Insurance'},
        {'id': 'ins_11', 'name_en': 'Property Risk Assessor', 'name_ar': 'مقيم ومفتش مخاطر ممتلكات ومصانع', 'subSector': 'Property Insurance'},
        {'id': 'ins_12', 'name_en': 'Property Claim Adjuster', 'name_ar': 'مسوي مطالبات ممتلكات وخسائر تجارية', 'subSector': 'Property Insurance'},

        // Claims Management
        {'id': 'ins_13', 'name_en': 'Claims Manager', 'name_ar': 'مدير إدارة التعويضات والمطالبات', 'subSector': 'Claims Management'},
        {'id': 'ins_14', 'name_en': 'Claims Processor', 'name_ar': 'معالج ومسجل مطالبات تأمين', 'subSector': 'Claims Management'},
        {'id': 'ins_15', 'name_en': 'Fraud Investigator', 'name_ar': 'محقق احتيال تأميني ومكافحة التلاعب', 'subSector': 'Claims Management'},

        // Insurance Sales
        {'id': 'ins_16', 'name_en': 'Insurance Sales Agent', 'name_ar': 'وكيل ومندوب مبيعات وثائق تأمين', 'subSector': 'Insurance Sales'},
        {'id': 'ins_17', 'name_en': 'Corporate Insurance Broker', 'name_ar': 'وسيط تأمين شركات ومشاريع كبرى', 'subSector': 'Insurance Sales'},
        {'id': 'ins_18', 'name_en': 'Insurance Customer Support', 'name_ar': 'ممثل خدمة عملاء وإصدار وثائق', 'subSector': 'Insurance Sales'},
      ],
    },

    // 14. Aviation Sector (الطيران والخدمات الجوية)
    {
      'code': 'aviation',
      'name_ar': 'قطاع الطيران والخدمات الجوية',
      'name_en': 'Aviation Sector',
      'image': 'assets/images/sector_aviation.jpg',
      'subSectors': [
        'Flight Crew',
        'Cabin Crew',
        'Aviation Engineering',
        'Ground Operations',
        'Airport Services',
      ],
      'professions': [
        // Flight Crew
        {'id': 'av_1', 'name_en': 'Captain Pilot', 'name_ar': 'طيار كابتن خطوط جوية', 'subSector': 'Flight Crew'},
        {'id': 'av_2', 'name_en': 'Co-Pilot / First Officer', 'name_ar': 'مساعد طيار / ضابط أول', 'subSector': 'Flight Crew'},

        // Cabin Crew
        {'id': 'av_3', 'name_en': 'Male Flight Attendant', 'name_ar': 'مضيف طيران وضيافة جوية (رجال)', 'subSector': 'Cabin Crew'},
        {'id': 'av_4', 'name_en': 'Female Flight Attendant', 'name_ar': 'مضيفة طيران وضيافة جوية (سيدات)', 'subSector': 'Cabin Crew'},
        {'id': 'av_5', 'name_en': 'Cabin Crew Supervisor', 'name_ar': 'مشرف طاقم الضيافة الجوية', 'subSector': 'Cabin Crew'},

        // Aviation Engineering
        {'id': 'av_6', 'name_en': 'Aviation Engineer', 'name_ar': 'مهندس طيران وفضاء', 'subSector': 'Aviation Engineering'},
        {'id': 'av_7', 'name_en': 'Aircraft Maintenance Engineer (AME)', 'name_ar': 'مهندس صيانة وهياكل طائرات', 'subSector': 'Aviation Engineering'},
        {'id': 'av_8', 'name_en': 'Avionics Engineer', 'name_ar': 'مهندس إلكترونيات وأجهزة طيران', 'subSector': 'Aviation Engineering'},
        {'id': 'av_9', 'name_en': 'Aircraft Technician', 'name_ar': 'فني صيانة ميكانيك طائرات', 'subSector': 'Aviation Engineering'},

        // Ground Operations
        {'id': 'av_10', 'name_en': 'Ground Operations Manager', 'name_ar': 'مدير عمليات أرضية بالمطار', 'subSector': 'Ground Operations'},
        {'id': 'av_11', 'name_en': 'Ramp Agent', 'name_ar': 'موظف ساحة الطيران (رامب)', 'subSector': 'Ground Operations'},
        {'id': 'av_12', 'name_en': 'Baggage Handler', 'name_ar': 'مناول أمتعة وحقائب طيران', 'subSector': 'Ground Operations'},
        {'id': 'av_13', 'name_en': 'Aircraft Dispatcher', 'name_ar': 'مرحل جوي وجدول رحلات طيران', 'subSector': 'Ground Operations'},
        {'id': 'av_14', 'name_en': 'Load Controller', 'name_ar': 'ضابط حمولة ووزن وتوازن طائرات', 'subSector': 'Ground Operations'},
        {'id': 'av_15', 'name_en': 'Fuel Provider (Aircraft Refueler)', 'name_ar': 'فني ومسؤول تزويد الطائرات بالوقود', 'subSector': 'Ground Operations'},

        // Airport Services
        {'id': 'av_16', 'name_en': 'Check-in Agent', 'name_ar': 'موظف كاونتر إنهاء إجراءات السفر', 'subSector': 'Airport Services'},
        {'id': 'av_17', 'name_en': 'Gate Agent', 'name_ar': 'موظف بوابات الصعود للطائرة', 'subSector': 'Airport Services'},
        {'id': 'av_18', 'name_en': 'Airport Customer Service Agent', 'name_ar': 'ممثل خدمة عملاء واستعلامات المطار', 'subSector': 'Airport Services'},
        {'id': 'av_19', 'name_en': 'Lounge Attendant', 'name_ar': 'مضيف قاعات كبار الشخصيات بالمطار', 'subSector': 'Airport Services'},
        {'id': 'av_20', 'name_en': 'Air Traffic Controller (ATC)', 'name_ar': 'مراقب حركة وملاحة جوية', 'subSector': 'Airport Services'},
        {'id': 'av_21', 'name_en': 'Airport Security Officer', 'name_ar': 'ضابط أمن وسلامة المطار', 'subSector': 'Airport Services'},
      ],
    },

    // 15. Tailoring & Sewing Sector (الخياطة وتصميم الأزياء)
    {
      'code': 'tailoring',
      'name_ar': 'قطاع الخياطة وتصميم الأزياء',
      'name_en': 'Tailoring & Sewing Sector',
      'image': 'assets/images/sector_tailoring.jpg',
      'subSectors': [
        'Men Tailoring',
        'Women Tailoring',
        'Embroidery & Decoration',
        'Workshop Management',
      ],
      'professions': [
        // Men Tailoring
        {'id': 'tail_1', 'name_en': 'Men Tailor', 'name_ar': 'خياط رجالي عام', 'subSector': 'Men Tailoring'},
        {'id': 'tail_2', 'name_en': 'Kuwaiti Dishdasha / Thobe Tailor', 'name_ar': 'خياط دشاديش ومستلزمات رجالية كويتية', 'subSector': 'Men Tailoring'},
        {'id': 'tail_3', 'name_en': 'Suit Tailor', 'name_ar': 'خياط بدلات رسمية وسهرة رجالي', 'subSector': 'Men Tailoring'},
        {'id': 'tail_4', 'name_en': 'Men Fabric Cutter', 'name_ar': 'قاص وباترونيست أقمشة رجالية', 'subSector': 'Men Tailoring'},
        {'id': 'tail_5', 'name_en': 'Alteration Tailor (Men)', 'name_ar': 'خياط تصليح وتعديل مقاسات رجالي', 'subSector': 'Men Tailoring'},

        // Women Tailoring
        {'id': 'tail_6', 'name_en': 'Women Tailor', 'name_ar': 'خياطة / خياط نسائي عام', 'subSector': 'Women Tailoring'},
        {'id': 'tail_7', 'name_en': 'Dressmaker', 'name_ar': 'مصممة وخياطة فساتين', 'subSector': 'Women Tailoring'},
        {'id': 'tail_8', 'name_en': 'Abaya Tailor', 'name_ar': 'خياط عبايات ودراعات كويتية', 'subSector': 'Women Tailoring'},
        {'id': 'tail_9', 'name_en': 'Wedding Dress Tailor', 'name_ar': 'خياط فساتين أعراس وزفاف وسهرة', 'subSector': 'Women Tailoring'},
        {'id': 'tail_10', 'name_en': 'Women Fabric Cutter', 'name_ar': 'قاصة وباترونيست أقمشة نسائية', 'subSector': 'Women Tailoring'},
        {'id': 'tail_11', 'name_en': 'Alteration Tailor (Women)', 'name_ar': 'خياطة تصليح وتعديل فساتين نسائية', 'subSector': 'Women Tailoring'},

        // Embroidery & Decoration
        {'id': 'tail_12', 'name_en': 'Hand Embroiderer', 'name_ar': 'فني تطريز يدوي وشك وتشكيل خرز', 'subSector': 'Embroidery & Decoration'},
        {'id': 'tail_13', 'name_en': 'Machine Embroiderer', 'name_ar': 'فني تشغيل ماكينات تطريز كمبيوتر', 'subSector': 'Embroidery & Decoration'},

        // Workshop Management
        {'id': 'tail_14', 'name_en': 'Tailoring Workshop Manager', 'name_ar': 'مدير مشغل ومعمل خياطة', 'subSector': 'Workshop Management'},
        {'id': 'tail_15', 'name_en': 'Production Supervisor', 'name_ar': 'مشرف خط إنتاج تفصيل وخياطة', 'subSector': 'Workshop Management'},
        {'id': 'tail_16', 'name_en': 'Quality Inspector', 'name_ar': 'مفتش جودة ومطابقة تفصيل وتشطيب', 'subSector': 'Workshop Management'},
        {'id': 'tail_17', 'name_en': 'Tailoring Receptionist', 'name_ar': 'موظف استقبال وأخذ قياسات عملاء', 'subSector': 'Workshop Management'},
      ],
    },

    // 16. Car Showrooms & Rental Sector (معارض وتأجير السيارات)
    {
      'code': 'car_rental',
      'name_ar': 'قطاع معارض وتأجير وغسيل السيارات',
      'name_en': 'Car Wash, Showroom and Rental Sector',
      'image': 'assets/images/sector_car_rental.jpg',
      'subSectors': [
        'Showroom Management',
        'Sales Team',
        'Rental Operations',
        'Customer Service',
        'Administrative Support',
      ],
      'professions': [
        // Showroom Management
        {'id': 'cr_1', 'name_en': 'Showroom Manager', 'name_ar': 'مدير معرض سيارات', 'subSector': 'Showroom Management'},
        {'id': 'cr_2', 'name_en': 'Showroom Supervisor', 'name_ar': 'مشرف صالة عرض سيارات', 'subSector': 'Showroom Management'},
        {'id': 'cr_3', 'name_en': 'Branch Manager', 'name_ar': 'مدير فرع تأجير ومعارض', 'subSector': 'Showroom Management'},
        {'id': 'cr_4', 'name_en': 'Operations Manager', 'name_ar': 'مدير عمليات وتشغيل أسطول سيارات', 'subSector': 'Showroom Management'},

        // Sales Team
        {'id': 'cr_5', 'name_en': 'Car Sales Representative', 'name_ar': 'مندوب مبيعات سيارات جديدة', 'subSector': 'Sales Team'},
        {'id': 'cr_6', 'name_en': 'Sales Executive', 'name_ar': 'تنفيذي مبيعات سيارات', 'subSector': 'Sales Team'},
        {'id': 'cr_7', 'name_en': 'Sales Consultant', 'name_ar': 'مستشار مبيعات وتمويل سيارات', 'subSector': 'Sales Team'},
        {'id': 'cr_8', 'name_en': 'Used Car Specialist', 'name_ar': 'أخصائي تقييم ومبيعات سيارات مستعملة', 'subSector': 'Sales Team'},
        {'id': 'cr_9', 'name_en': 'Fleet Sales Officer', 'name_ar': 'مسؤول مبيعات أساطيل وشركات', 'subSector': 'Sales Team'},

        // Rental Operations
        {'id': 'cr_10', 'name_en': 'Rental Manager', 'name_ar': 'مدير عمليات تأجير سيارات', 'subSector': 'Rental Operations'},
        {'id': 'cr_11', 'name_en': 'Car Rental Agent', 'name_ar': 'موظف تأجير واستقبال عملاء', 'subSector': 'Rental Operations'},
        {'id': 'cr_12', 'name_en': 'Vehicle Delivery Driver', 'name_ar': 'سائق تسليم واستلام سيارات التأجير', 'subSector': 'Rental Operations'},

        // Customer Service
        {'id': 'cr_13', 'name_en': 'Customer Receptionist', 'name_ar': 'موظف استقبال واستعلامات عملاء المعرض', 'subSector': 'Customer Service'},
        {'id': 'cr_14', 'name_en': 'Customer Service Representative', 'name_ar': 'ممثل خدمة عملاء ومتابعة عقود', 'subSector': 'Customer Service'},
        {'id': 'cr_15', 'name_en': 'Call Center Agent', 'name_ar': 'موظف كول سنتر وحجوزات سيارات', 'subSector': 'Customer Service'},

        // Administrative Support
        {'id': 'cr_16', 'name_en': 'Showroom Accountant', 'name_ar': 'محاسب معرض وتأجير سيارات', 'subSector': 'Administrative Support'},
        {'id': 'cr_17', 'name_en': 'Contracts Officer', 'name_ar': 'مسؤول عقود واتفاقيات تأجير', 'subSector': 'Administrative Support'},
        {'id': 'cr_18', 'name_en': 'Vehicle Inspector', 'name_ar': 'فاحص ومفتش حالة المركبات قبل التسليم', 'subSector': 'Administrative Support'},
        {'id': 'cr_19', 'name_en': 'Car Washer', 'name_ar': 'عامل غسيل وتنظيف وتلميع سيارات', 'subSector': 'Administrative Support'},
        {'id': 'cr_20', 'name_en': 'Vehicle Preparation Technician', 'name_ar': 'فني تجهيز وتلميع وبولش سيارات', 'subSector': 'Administrative Support'},
        {'id': 'cr_21', 'name_en': 'Vehicle Insurance Coordinator', 'name_ar': 'منسق تأمين ورخص سيارات', 'subSector': 'Administrative Support'},
        {'id': 'cr_22', 'name_en': 'Vehicle Registration Officer', 'name_ar': 'مندوب تسجيل ونقل ملكية مرور', 'subSector': 'Administrative Support'},
      ],
    },

    // 17. Security & Guarding Sector (الأمن والحراسة)
    {
      'code': 'security',
      'name_ar': 'قطاع الأمن والحراسة',
      'name_en': 'Security & Guarding Sector',
      'image': 'assets/images/sector_security.jpg',
      'subSectors': [
        'Static Site Security (Facilities)',
        'Cash in Transit & Valuable Custody',
        'Electronic Security & Control Room',
        'Supervision & Training',
      ],
      'professions': [
        // Static Site Security (Facilities)
        {'id': 'sec_1', 'name_en': 'Building Security Guard', 'name_ar': 'حارس أمن مباني وأبراج سكنية وإدارية', 'subSector': 'Static Site Security (Facilities)'},
        {'id': 'sec_2', 'name_en': 'Shopping Mall / Complex Guard', 'name_ar': 'حارس أمن مجمعات وأسواق تجارية', 'subSector': 'Static Site Security (Facilities)'},
        {'id': 'sec_3', 'name_en': 'Hospital Security Guard', 'name_ar': 'حارس أمن مستشفيات ومراكز صحية', 'subSector': 'Static Site Security (Facilities)'},
        {'id': 'sec_4', 'name_en': 'School Security Guard', 'name_ar': 'حارس أمن مدارس وجامعات ومعاهد', 'subSector': 'Static Site Security (Facilities)'},
        {'id': 'sec_5', 'name_en': 'Bank Security Guard', 'name_ar': 'حارس أمن بنوك ومصارف وفروع', 'subSector': 'Static Site Security (Facilities)'},
        {'id': 'sec_6', 'name_en': 'Residential Compound Guard', 'name_ar': 'حارس أمن كمباوند ومجمعات سكنية', 'subSector': 'Static Site Security (Facilities)'},
        {'id': 'sec_7', 'name_en': 'Gate / Entrance Guard', 'name_ar': 'حارس بوابات ومداخل ومنشآت', 'subSector': 'Static Site Security (Facilities)'},

        // Cash in Transit & Valuable Custody
        {'id': 'sec_8', 'name_en': 'Cash in Transit Crew Member', 'name_ar': 'فرد طاقم حراسة ونقل أموال', 'subSector': 'Cash in Transit & Valuable Custody'},
        {'id': 'sec_9', 'name_en': 'Valuable Escort', 'name_ar': 'مرافق وحارس شحنات ومعادن ثمينة', 'subSector': 'Cash in Transit & Valuable Custody'},
        {'id': 'sec_10', 'name_en': 'Strong Room / Vault Guard', 'name_ar': 'حارس خزائن وغرف محصنة', 'subSector': 'Cash in Transit & Valuable Custody'},

        // Electronic Security & Control Room
        {'id': 'sec_11', 'name_en': 'Cybersecurity Expert', 'name_ar': 'خبير أمن سيبراني ومعلومات', 'subSector': 'Electronic Security & Control Room'},
        {'id': 'sec_12', 'name_en': 'CCTV Technician', 'name_ar': 'فني صيانة وتركيب كاميرات مراقبة CCTV', 'subSector': 'Electronic Security & Control Room'},
        {'id': 'sec_13', 'name_en': 'CCTV Operator', 'name_ar': 'مشغل ومراقب كاميرات وشاشات أمنية', 'subSector': 'Electronic Security & Control Room'},
        {'id': 'sec_14', 'name_en': 'Control Room Operator', 'name_ar': 'مشغل غرف تحكم وسيطرة مركزية', 'subSector': 'Electronic Security & Control Room'},
        {'id': 'sec_15', 'name_en': 'Access Control & Alarm Monitoring Officer', 'name_ar': 'ضابط مراقبة بوابات ذكية وإنذار أمني', 'subSector': 'Electronic Security & Control Room'},

        // Supervision & Training
        {'id': 'sec_16', 'name_en': 'Security Shift Supervisor', 'name_ar': 'مشرف وردية ونوبات أمنية', 'subSector': 'Supervision & Training'},
        {'id': 'sec_17', 'name_en': 'Site Security Lead / Head', 'name_ar': 'قائد ومسؤول أمن الموقع الميداني', 'subSector': 'Supervision & Training'},
        {'id': 'sec_18', 'name_en': 'Security & Protection Trainer', 'name_ar': 'مدرب معتمد في الأمن والحماية الشخصية', 'subSector': 'Supervision & Training'},
        {'id': 'sec_19', 'name_en': 'Security Roster & Scheduling Coordinator', 'name_ar': 'منسق جداول وتوزيع نوبات الحراسة', 'subSector': 'Supervision & Training'},
      ],
    },

    // 18. Medical Engineering Sector (الهندسة الطبية والأجهزة)
    {
      'code': 'medical_engineering',
      'name_ar': 'قطاع الهندسة الطبية والأجهزة',
      'name_en': 'Medical Engineering Sector',
      'image': 'assets/images/sector_medical_engineering.jpg',
      'subSectors': [
        'Clinical Engineering & Hospital Equipment',
        'Medical Device Manufacturing',
        'Field Services & Technical Support',
        'Medical Imaging & Diagnostics',
        'Rehabilitation & Assistive Technology',
        'Research & Development (R&D)',
        'Healthcare Systems & Informatics',
      ],
      'professions': [
        // Clinical Engineering & Hospital Equipment
        {'id': 'me_1', 'name_en': 'Biomedical Engineer', 'name_ar': 'مهندس أجهزة ومعدات طبية حيوية', 'subSector': 'Clinical Engineering & Hospital Equipment'},
        {'id': 'me_2', 'name_en': 'Clinical Engineer', 'name_ar': 'مهندس إكلينيكي مستشفيات', 'subSector': 'Clinical Engineering & Hospital Equipment'},
        {'id': 'me_3', 'name_en': 'Biomedical Equipment Technician (BMET)', 'name_ar': 'فني أجهزة طبية حيوية BMET', 'subSector': 'Clinical Engineering & Hospital Equipment'},
        {'id': 'me_4', 'name_en': 'Medical Equipment Maintenance Tech', 'name_ar': 'فني صيانة تجهيزات ومعدات طبية', 'subSector': 'Clinical Engineering & Hospital Equipment'},
        {'id': 'me_5', 'name_en': 'Hospital Equipment Supervisor', 'name_ar': 'مشرف تجهيزات ومعدات مستشفيات', 'subSector': 'Clinical Engineering & Hospital Equipment'},
        {'id': 'me_6', 'name_en': 'Biomedical Engineering Supervisor', 'name_ar': 'مشرف قسم هندسة طبية', 'subSector': 'Clinical Engineering & Hospital Equipment'},
        {'id': 'me_7', 'name_en': 'Medical Equipment Inventory Controller', 'name_ar': 'مراقب مخزون وقطع غيار أجهزة طبية', 'subSector': 'Clinical Engineering & Hospital Equipment'},

        // Medical Device Manufacturing
        {'id': 'me_8', 'name_en': 'Medical Device Engineer', 'name_ar': 'مهندس تصنيع أجهزة ومستلزمات طبية', 'subSector': 'Medical Device Manufacturing'},
        {'id': 'me_9', 'name_en': 'Biomedical Design Engineer', 'name_ar': 'مهندس تصميم وتطوير أجهزة طبية', 'subSector': 'Medical Device Manufacturing'},
        {'id': 'me_10', 'name_en': 'Product Development Engineer (Medical Devices)', 'name_ar': 'مهندس تطوير منتجات وأجهزة طبية', 'subSector': 'Medical Device Manufacturing'},
        {'id': 'me_11', 'name_en': 'Medical Device Assembly Technician', 'name_ar': 'فني تجميع وتركيب أجهزة طبية', 'subSector': 'Medical Device Manufacturing'},
        {'id': 'me_12', 'name_en': 'Production Technician (Medical Devices)', 'name_ar': 'فني خط إنتاج أجهزة طبية', 'subSector': 'Medical Device Manufacturing'},
        {'id': 'me_13', 'name_en': 'Quality Control Engineer (Medical Devices)', 'name_ar': 'مهندس جودة وتفتيش أجهزة طبية', 'subSector': 'Medical Device Manufacturing'},
        {'id': 'me_14', 'name_en': 'Regulatory Affairs Specialist (Medical Devices)', 'name_ar': 'أخصائي تسجيل ورقابة أجهزة طبية', 'subSector': 'Medical Device Manufacturing'},

        // Field Services & Technical Support
        {'id': 'me_15', 'name_en': 'Field Service Engineer (Medical Equipment)', 'name_ar': 'مهندس صيانة وخدمة ميدانية أجهزة طبية', 'subSector': 'Field Services & Technical Support'},
        {'id': 'me_16', 'name_en': 'Medical Equipment Installation Engineer', 'name_ar': 'مهندس تركيب وتشغيل أجهزة طبية', 'subSector': 'Field Services & Technical Support'},
        {'id': 'me_17', 'name_en': 'Technical Support Engineer (Healthcare Devices)', 'name_ar': 'مهندس دعم فني ومساندة أجهزة طبية', 'subSector': 'Field Services & Technical Support'},

        // Medical Imaging & Diagnostics
        {'id': 'me_18', 'name_en': 'Medical Image Engineer', 'name_ar': 'مهندس أنظمة تصوير طبي', 'subSector': 'Medical Imaging & Diagnostics'},
        {'id': 'me_19', 'name_en': 'Radiology Equipment Engineer', 'name_ar': 'مهندس أجهزة أشعة وسكانر', 'subSector': 'Medical Imaging & Diagnostics'},
        {'id': 'me_20', 'name_en': 'MRI Equipment Specialist', 'name_ar': 'أخصائي صيانة أجهزة رنين مغناطيسي MRI', 'subSector': 'Medical Imaging & Diagnostics'},
        {'id': 'me_21', 'name_en': 'CT Scan Equipment Specialist', 'name_ar': 'أخصائي أجهزة أشعة مقطعية CT', 'subSector': 'Medical Imaging & Diagnostics'},
        {'id': 'me_22', 'name_en': 'Ultrasound Equipment Specialist', 'name_ar': 'أخصائي أجهزة سونار وتصوير بالموجات', 'subSector': 'Medical Imaging & Diagnostics'},

        // Rehabilitation & Assistive Technology
        {'id': 'me_23', 'name_en': 'Prosthetic Engineer', 'name_ar': 'مهندس أطراف صناعية وبدائل حركية', 'subSector': 'Rehabilitation & Assistive Technology'},
        {'id': 'me_24', 'name_en': 'Orthotic Engineer', 'name_ar': 'مهندس أجهزة تقويم العظام والجبائر', 'subSector': 'Rehabilitation & Assistive Technology'},
        {'id': 'me_25', 'name_en': 'Rehabilitation Engineer', 'name_ar': 'مهندس أجهزة ومعدات تأهيل طبي', 'subSector': 'Rehabilitation & Assistive Technology'},
        {'id': 'me_26', 'name_en': 'Assistive Device Technician', 'name_ar': 'فني أجهزة وتقنيات مساعدة', 'subSector': 'Rehabilitation & Assistive Technology'},
        {'id': 'me_27', 'name_en': 'Wheelchair & Mobility Equipment Tech', 'name_ar': 'فني كراسي متحركة ومعدات حركة', 'subSector': 'Rehabilitation & Assistive Technology'},

        // Research & Development (R&D)
        {'id': 'me_28', 'name_en': 'Biomedical R&D Engineer', 'name_ar': 'مهندس أبحاث وتطوير أجهزة حيوية R&D', 'subSector': 'Research & Development (R&D)'},
        {'id': 'me_29', 'name_en': 'Biomaterial Engineer', 'name_ar': 'مهندس مواد حيوية وتوافق نسيجي', 'subSector': 'Research & Development (R&D)'},
        {'id': 'me_30', 'name_en': 'Tissue Engineering Specialist', 'name_ar': 'أخصائي هندسة أنسجة حيوية', 'subSector': 'Research & Development (R&D)'},
        {'id': 'me_31', 'name_en': 'Medical Innovative Researcher', 'name_ar': 'باحث ابتكارات واختراعات طبية', 'subSector': 'Research & Development (R&D)'},
        {'id': 'me_32', 'name_en': 'Laboratory Research Engineer', 'name_ar': 'مهندس أبحاث مختبرات طبية حيوية', 'subSector': 'Research & Development (R&D)'},

        // Healthcare Systems & Informatics
        {'id': 'me_33', 'name_en': 'Health Informatics Specialist', 'name_ar': 'أخصائي معلوماتية صحية وسجلات طبية', 'subSector': 'Healthcare Systems & Informatics'},
        {'id': 'me_34', 'name_en': 'Clinical Systems Integration Engineer', 'name_ar': 'مهندس تكامل وربط أنظمة إكلينيكية', 'subSector': 'Healthcare Systems & Informatics'},
        {'id': 'me_35', 'name_en': 'Medical Software Engineer', 'name_ar': 'مهندس برمجيات وتطبيقات طبية', 'subSector': 'Healthcare Systems & Informatics'},
        {'id': 'me_36', 'name_en': 'Hospital Systems Engineer', 'name_ar': 'مهندس أنظمة ومعلومات مستشفيات HIS', 'subSector': 'Healthcare Systems & Informatics'},
        {'id': 'me_37', 'name_en': 'PACS / RIS Systems Specialist', 'name_ar': 'أخصائي أنظمة حفظ وتداول الصور والأشعة PACS/RIS', 'subSector': 'Healthcare Systems & Informatics'},
      ],
    },

    // 19. Sport and Health Institutes Sector (المعاهد الرياضية والصحية)
    {
      'code': 'sports_health',
      'name_ar': 'قطاع المعاهد الرياضية والصحية',
      'name_en': 'Sport and Health Institutes Sector',
      'image': 'assets/images/sector_sports_health.jpg',
      'subSectors': [
        'Fitness & Professional Training',
        'Spa, Recovery & Wellness',
        'Gym Management & Operations',
      ],
      'professions': [
        // Fitness & Professional Training
        {'id': 'sh_1', 'name_en': 'Personal Trainer (PT)', 'name_ar': 'مدرب لياقة شخصي معتمد (PT)', 'subSector': 'Fitness & Professional Training'},
        {'id': 'sh_2', 'name_en': 'Gym Trainer (PT)', 'name_ar': 'مدرب صالة وبناء أجسام وأثقال', 'subSector': 'Fitness & Professional Training'},
        {'id': 'sh_3', 'name_en': 'General Fitness Instructor', 'name_ar': 'مدرب لياقة بدنية ورشاقة عام', 'subSector': 'Fitness & Professional Training'},
        {'id': 'sh_4', 'name_en': 'Group Exercise Instructor (Zumba / Aerobics)', 'name_ar': 'مدرب تمارين جماعية (زومبا / أيروبيكس)', 'subSector': 'Fitness & Professional Training'},
        {'id': 'sh_5', 'name_en': 'CrossFit & Strength Coach', 'name_ar': 'مدرب كروس فيت وقوة بدنية وتحمل', 'subSector': 'Fitness & Professional Training'},
        {'id': 'sh_6', 'name_en': 'Yoga & Pilates Instructor', 'name_ar': 'مدربة يوغا وبيلاتس واستطالة', 'subSector': 'Fitness & Professional Training'},
        {'id': 'sh_7', 'name_en': 'Martial Arts & Boxing Coach', 'name_ar': 'مدرب فنون قتالية وملاكمة ودفاع عن النفس', 'subSector': 'Fitness & Professional Training'},
        {'id': 'sh_8', 'name_en': 'Football Coach', 'name_ar': 'مدرب كرة قدم وتكتيك رياضي', 'subSector': 'Fitness & Professional Training'},

        // Spa, Recovery & Wellness
        {'id': 'sh_9', 'name_en': 'Massage Therapist / Masseur', 'name_ar': 'أخصائي وأخصائية مساج وتدليك علاجي واسترخائي', 'subSector': 'Spa, Recovery & Wellness'},
        {'id': 'sh_10', 'name_en': 'Sports Recovery Specialist', 'name_ar': 'أخصائي استشفاء وإصابات وتأهيل رياضي', 'subSector': 'Spa, Recovery & Wellness'},
        {'id': 'sh_11', 'name_en': 'Spa, Sauna & Jacuzzi Attendant', 'name_ar': 'مشرف ومسؤول سبا وساونا وجاكوزي', 'subSector': 'Spa, Recovery & Wellness'},
        {'id': 'sh_12', 'name_en': 'Sports Nutritionist', 'name_ar': 'أخصائي تغذية رياضيين ومكملات غذائية', 'subSector': 'Spa, Recovery & Wellness'},
        {'id': 'sh_13', 'name_en': 'Moroccan Bath Specialist', 'name_ar': 'أخصائي حمام مغربي وعناية بالجسم', 'subSector': 'Spa, Recovery & Wellness'},

        // Gym Management & Operations
        {'id': 'sh_14', 'name_en': 'Health Club / Gym Manager', 'name_ar': 'مدير معهد صحي ونادي رياضي', 'subSector': 'Gym Management & Operations'},
        {'id': 'sh_15', 'name_en': 'Gym Receptionist', 'name_ar': 'موظف استقبال واستعلامات نادي رياضي', 'subSector': 'Gym Management & Operations'},
        {'id': 'sh_16', 'name_en': 'Membership & Sales Consultant', 'name_ar': 'مستشار مبيعات واشتراكات عضوية النادي', 'subSector': 'Gym Management & Operations'},
        {'id': 'sh_17', 'name_en': 'Certified Lifeguard', 'name_ar': 'منقذ سباحة ومسعف معتمد أحواض', 'subSector': 'Gym Management & Operations'},
        {'id': 'sh_18', 'name_en': 'Gym Equipment Maintenance Tech', 'name_ar': 'فني صيانة وإصلاح أجهزة ومكائن رياضية', 'subSector': 'Gym Management & Operations'},
        {'id': 'sh_19', 'name_en': 'Locker Room & Facility Attendant', 'name_ar': 'عامل نظافة وتنظيم غرف تبديل ومرافق النادي', 'subSector': 'Gym Management & Operations'},
      ],
    },

    // 20. Deputies and Secretary Sector (السكرتارية وإدارة المكاتب)
    {
      'code': 'secretarial',
      'name_ar': 'قطاع السكرتارية وإدارة المكاتب',
      'name_en': 'Deputies and Secretary Sector',
      'image': 'assets/images/sector_secretarial.jpg',
      'subSectors': [
        'Executive Secretarial',
        'Office Administration',
        'Front Desk & Reception',
        'Data Entry & Archiving',
      ],
      'professions': [
        {'id': 'secr_1', 'name_en': 'Executive Secretary', 'name_ar': 'سكرتير تنفيذي ومكتب إدارة عليا', 'subSector': 'Executive Secretarial'},
        {'id': 'secr_2', 'name_en': 'Bilingual Office Administrator', 'name_ar': 'مدير مكتب وإداري ثنائي اللغة', 'subSector': 'Office Administration'},
        {'id': 'secr_3', 'name_en': 'Receptionist & Front Desk Officer', 'name_ar': 'موظف استقبال واستعلامات شركات', 'subSector': 'Front Desk & Reception'},
        {'id': 'secr_4', 'name_en': 'Data Entry & Digital Archiving Clerk', 'name_ar': 'مدخل بيانات وأرشفة إلكترونية سريعة', 'subSector': 'Data Entry & Archiving'},
        {'id': 'secr_5', 'name_en': 'Administrative Correspondence Assistant', 'name_ar': 'مساعد إداري وتنسيق مراسلات رسمية', 'subSector': 'Office Administration'},
      ],
    },

    // 21. Agricultural and Livestock Sector (القطاع الزراعي والثروة الحيوانية)
    {
      'code': 'agriculture',
      'name_ar': 'القطاع الزراعي والثروة الحيوانية',
      'name_en': 'Agricultural and Livestock Sector',
      'image': 'assets/images/sector_agriculture.jpg',
      'subSectors': [
        'Agriculture & Crops Farming',
        'Animal Husbandry & Livestock',
      ],
      'professions': [
        // Agriculture & Crops Farming
        {'id': 'agr_1', 'name_en': 'Agricultural Engineer', 'name_ar': 'مهندس زراعي محاصيل ومحميات', 'subSector': 'Agriculture & Crops Farming'},
        {'id': 'agr_2', 'name_en': 'Farm Manager', 'name_ar': 'مدير مزرعة وجاخور', 'subSector': 'Agriculture & Crops Farming'},
        {'id': 'agr_3', 'name_en': 'General Agricultural Worker', 'name_ar': 'عامل زراعي ومزارع عام', 'subSector': 'Agriculture & Crops Farming'},
        {'id': 'agr_4', 'name_en': 'Irrigation System Technician', 'name_ar': 'فني شبكات وأنظمة ري زراعي', 'subSector': 'Agriculture & Crops Farming'},
        {'id': 'agr_5', 'name_en': 'Agricultural Pest Controller', 'name_ar': 'فني مكافحة آفات ورش زراعي', 'subSector': 'Agriculture & Crops Farming'},
        {'id': 'agr_6', 'name_en': 'Farm Equipment Operator', 'name_ar': 'سائق ومشغل جرار ومعدات زراعية', 'subSector': 'Agriculture & Crops Farming'},

        // Animal Husbandry & Livestock
        {'id': 'agr_7', 'name_en': 'Veterinary Doctor', 'name_ar': 'طبيب بيطري ثروة حيوانية ودواجن', 'subSector': 'Animal Husbandry & Livestock'},
        {'id': 'agr_8', 'name_en': 'Animal Production Engineer', 'name_ar': 'مهندس إنتاج حيواني وأعلاف', 'subSector': 'Animal Husbandry & Livestock'},
        {'id': 'agr_9', 'name_en': 'Poultry Farm Supervisor', 'name_ar': 'مشرف مزارع دواجن وفقاسات', 'subSector': 'Animal Husbandry & Livestock'},
        {'id': 'agr_10', 'name_en': 'Livestock Breeder / Herder', 'name_ar': 'مربي مواشي وأغنام وراعي حلال', 'subSector': 'Animal Husbandry & Livestock'},
        {'id': 'agr_11', 'name_en': 'Dairy Production Worker', 'name_ar': 'عامل إنتاج وتصنيع ألبان وحليب', 'subSector': 'Animal Husbandry & Livestock'},
        {'id': 'agr_12', 'name_en': 'Fish Farming (Aquaculture) Tech', 'name_ar': 'فني استزراع سمكي ومزارع أسماك', 'subSector': 'Animal Husbandry & Livestock'},
      ],
    },

    // 22. Factories Sector (المصانع والإنتاج الصناعي)
    {
      'code': 'factories',
      'name_ar': 'قطاع المصانع والإنتاج الصناعي',
      'name_en': 'Factories Sector',
      'image': 'assets/images/sector_factories.jpg',
      'subSectors': [
        'Factory Management & QA',
        'Factory Production & Lines',
        'Industrial Maintenance & Engineering',
        'Warehouse, Logistics & Inventory',
        'Industrial Support & Facilities',
      ],
      'professions': [
        // Factory Management & QA
        {'id': 'fac_1', 'name_en': 'Factory General Manager', 'name_ar': 'مدير عام مصنع', 'subSector': 'Factory Management & QA'},
        {'id': 'fac_2', 'name_en': 'Production Manager', 'name_ar': 'مدير إنتاج وتشغيل مصانع', 'subSector': 'Factory Management & QA'},
        {'id': 'fac_3', 'name_en': 'Quality Control (QC) Inspector', 'name_ar': 'مفتش ومراقب جودة صناعية QC', 'subSector': 'Factory Management & QA'},
        {'id': 'fac_4', 'name_en': 'Health, Safety & Environment (HSE) Officer', 'name_ar': 'ضابط صحة وسلامة وبيئة HSE', 'subSector': 'Factory Management & QA'},

        // Factory Production & Lines
        {'id': 'fac_5', 'name_en': 'Factory Manager', 'name_ar': 'مدير تشغيل مصنع', 'subSector': 'Factory Production & Lines'},
        {'id': 'fac_6', 'name_en': 'Production Engineer', 'name_ar': 'مهندس إنتاج وتصنيع', 'subSector': 'Factory Production & Lines'},
        {'id': 'fac_7', 'name_en': 'Production Line Supervisor', 'name_ar': 'مشرف خط إنتاج وتجميع', 'subSector': 'Factory Production & Lines'},
        {'id': 'fac_8', 'name_en': 'CNC Machine Operator', 'name_ar': 'مشغل ماكينات CNC ومخارط', 'subSector': 'Factory Production & Lines'},
        {'id': 'fac_9', 'name_en': 'Heavy Industrial Machinery Operator', 'name_ar': 'مشغل ماكينات صناعية ثقيلة ومكابس', 'subSector': 'Factory Production & Lines'},
        {'id': 'fac_10', 'name_en': 'Assembly Line Worker', 'name_ar': 'عامل خط تجميع وتصنيع', 'subSector': 'Factory Production & Lines'},
        {'id': 'fac_11', 'name_en': 'Packing Worker', 'name_ar': 'عامل تغليف وتعبئة بضائع', 'subSector': 'Factory Production & Lines'},
        {'id': 'fac_12', 'name_en': 'Metal Fabricator & Welder', 'name_ar': 'فني تشكيل ولحام معادن وحدادة صناعية', 'subSector': 'Factory Production & Lines'},
        {'id': 'fac_13', 'name_en': 'Factory Facility Worker', 'name_ar': 'عامل خدمات ومساندة منشآت المصنع', 'subSector': 'Factory Production & Lines'},

        // Industrial Maintenance & Engineering
        {'id': 'fac_14', 'name_en': 'Industrial Maintenance Engineer', 'name_ar': 'مهندس صيانة صناعية وماكينات', 'subSector': 'Industrial Maintenance & Engineering'},
        {'id': 'fac_15', 'name_en': 'Industrial Welder (TIG/MIG)', 'name_ar': 'لحام صناعي محترف TIG/MIG', 'subSector': 'Industrial Maintenance & Engineering'},
        {'id': 'fac_16', 'name_en': 'Industrial Electrician', 'name_ar': 'فني كهرباء صناعية ولوحات تحكم', 'subSector': 'Industrial Maintenance & Engineering'},
        {'id': 'fac_17', 'name_en': 'Industrial Mechanic', 'name_ar': 'فني ميكانيك صناعي وصيانة هيدروليك', 'subSector': 'Industrial Maintenance & Engineering'},
        {'id': 'fac_18', 'name_en': 'QA / QC Inspector', 'name_ar': 'مفتش جودة وتفتيش صناعي QA/QC', 'subSector': 'Industrial Maintenance & Engineering'},

        // Warehouse, Logistics & Inventory
        {'id': 'fac_19', 'name_en': 'Forklift Operator', 'name_ar': 'سائق رافعة شوكية وتشوين مستودعات', 'subSector': 'Warehouse, Logistics & Inventory'},
        {'id': 'fac_20', 'name_en': 'Factory Loader / Unloader', 'name_ar': 'عامل تحميل وتنزيل بضائع بالمصنع', 'subSector': 'Warehouse, Logistics & Inventory'},

        // Industrial Support & Facilities
        {'id': 'fac_21', 'name_en': 'Industrial Storekeeper', 'name_ar': 'أمين مستودع مواد وقطع غيار صناعية', 'subSector': 'Industrial Support & Facilities'},
        {'id': 'fac_22', 'name_en': 'Water Treatment Technician', 'name_ar': 'فني محطات معالجة مياه صناعية', 'subSector': 'Industrial Support & Facilities'},
        {'id': 'fac_23', 'name_en': 'Ice & Cooling Plant Operator', 'name_ar': 'مشغل محطات ومصانع ثلج وتبريد', 'subSector': 'Industrial Support & Facilities'},
        {'id': 'fac_24', 'name_en': 'Industrial Heavy Cleaner', 'name_ar': 'عامل نظافة منشآت ومصانع ثقيلة', 'subSector': 'Industrial Support & Facilities'},
      ],
    },

    // 23. Sales, Retail & Commercial Markets Sector (المبيعات والتجزئة والأسواق التجارية)
    {
      'code': 'sales_retail',
      'name_ar': 'قطاع المبيعات والتجزئة والأسواق التجارية',
      'name_en': 'Sales, Retail & Commercial Markets Sector',
      'image': 'assets/images/sector_sales_retail.jpg',
      'subSectors': [
        'Neighborhood & Specialized Shops',
        'Malls, Essentials & Apparel',
        'Cooperative Societies',
        'Mobiles, Tech & Electronics',
        'Digital, E-Commerce & Tele-Sales',
        'Fragrances, Oud & Tobacco',
        'Roasteries, Spices & Dates',
        'Fabrics, Tailoring & Traditional Wear',
        'Fish, Meat & Poultry Markets',
        'Gifts, Flowers & Events',
        'Hardware, Plumbing & Auto Parts',
        'Stationery, Printing & Services',
        'Corporate & B2B Sales',
        'Outdoor & Field Distribution',
      ],
      'professions': [
        // Neighborhood & Specialized Shops
        {'id': 'sr_1', 'name_en': 'Grocery / Supermarket Salesman', 'name_ar': 'بائع بقالة وسوبرماركت ومواد غذائية', 'subSector': 'Neighborhood & Specialized Shops'},
        {'id': 'sr_2', 'name_en': 'Shoe & Bag Repair Technician', 'name_ar': 'فني تصليح أحذية وحقائب وجلود', 'subSector': 'Neighborhood & Specialized Shops'},
        {'id': 'sr_3', 'name_en': 'Home Appliances Repair Tech', 'name_ar': 'فني تصليح وصيانة أجهزة منزلية', 'subSector': 'Neighborhood & Specialized Shops'},
        {'id': 'sr_4', 'name_en': 'Veterinary Pharmacy Salesperson', 'name_ar': 'بائع صيدلية ومستلزمات وأدوية بيطرية', 'subSector': 'Neighborhood & Specialized Shops'},
        {'id': 'sr_5', 'name_en': 'Pet & Aquarium Shop Salesperson', 'name_ar': 'بائع أسماك زينة وأحواض وحيوانات أليفة', 'subSector': 'Neighborhood & Specialized Shops'},
        {'id': 'sr_6', 'name_en': 'Juice Shop / Bar Salesperson', 'name_ar': 'عامل وبائع محل عصائر طازجة وآيسكريم', 'subSector': 'Neighborhood & Specialized Shops'},
        {'id': 'sr_7', 'name_en': 'Laundry & Dry Clean Staff', 'name_ar': 'موظف مصبغة وغسيل وكوي ملابس', 'subSector': 'Neighborhood & Specialized Shops'},

        // Malls, Essentials & Apparel
        {'id': 'sr_8', 'name_en': 'Electronics & Appliances Sales', 'name_ar': 'بائع أجهزة كهربائية وإلكترونيات معارض', 'subSector': 'Malls, Essentials & Apparel'},
        {'id': 'sr_9', 'name_en': 'Fashion & Apparel Sales Associate', 'name_ar': 'بائع أزياء وملابس وماركات تجارية', 'subSector': 'Malls, Essentials & Apparel'},
        {'id': 'sr_10', 'name_en': 'Watches & Jewelry Sales Specialist', 'name_ar': 'بائع ساعات ومجوهرات وذهب ومصوغات', 'subSector': 'Malls, Essentials & Apparel'},
        {'id': 'sr_11', 'name_en': 'Retail Cashier', 'name_ar': 'كاشير ومحاسب معارض ومحلات تجارية', 'subSector': 'Malls, Essentials & Apparel'},
        {'id': 'sr_12', 'name_en': 'Showroom / Store Manager', 'name_ar': 'مدير متجر ومعرض تجاري', 'subSector': 'Malls, Essentials & Apparel'},
        {'id': 'sr_13', 'name_en': 'Perfumes & Cosmetics Sales', 'name_ar': 'بائع عطور ومستحضرات تجميل ومكياج', 'subSector': 'Malls, Essentials & Apparel'},

        // Cooperative Societies
        {'id': 'sr_14', 'name_en': 'Merchandiser / Shelf Stocker', 'name_ar': 'منسق أرفف ومسؤول ترتيب بضائع بالجمعية', 'subSector': 'Cooperative Societies'},
        {'id': 'sr_15', 'name_en': 'Supermarket Section Supervisor', 'name_ar': 'مشرف قسم جمعية وسوبرماركت مركزي', 'subSector': 'Cooperative Societies'},
        {'id': 'sr_16', 'name_en': 'Co-op Cashier', 'name_ar': 'كاشير نقاط بيع جمعيات تعاونية', 'subSector': 'Cooperative Societies'},

        // Mobiles, Tech & Electronics
        {'id': 'sr_17', 'name_en': 'Mobile & Accessories Salesman', 'name_ar': 'بائع هواتف ذكية واكسسوارات', 'subSector': 'Mobiles, Tech & Electronics'},
        {'id': 'sr_18', 'name_en': 'Mobile Phone Repair Technician', 'name_ar': 'فني صيانة وبرمجة وشاشات هواتف', 'subSector': 'Mobiles, Tech & Electronics'},
        {'id': 'sr_19', 'name_en': 'Computer & Tech Retail Sales', 'name_ar': 'بائع حواسيب ولابتوبات ومستلزمات تقنية', 'subSector': 'Mobiles, Tech & Electronics'},
        {'id': 'sr_20', 'name_en': 'Video Game Store Sales', 'name_ar': 'بائع ألعاب فيديو وبلايستيشن واكسسوارات', 'subSector': 'Mobiles, Tech & Electronics'},
        {'id': 'sr_21', 'name_en': 'Used Electronics & Trade-in Sales', 'name_ar': 'بائع ومثمن أجهزة وإلكترونيات مستعملة', 'subSector': 'Mobiles, Tech & Electronics'},

        // Digital, E-Commerce & Tele-Sales
        {'id': 'sr_22', 'name_en': 'E-Commerce / WhatsApp Sales Agent', 'name_ar': 'مسوق ومندوب مبيعات إلكترونية وواتساب', 'subSector': 'Digital, E-Commerce & Tele-Sales'},
        {'id': 'sr_23', 'name_en': 'Tele-Sales / Call Center Agent', 'name_ar': 'موظف مبيعات هاتفية وتيلي سيلز وكول سنتر', 'subSector': 'Digital, E-Commerce & Tele-Sales'},

        // Fragrances, Oud & Tobacco
        {'id': 'sr_24', 'name_en': 'Oud & Bakhoor Salesman', 'name_ar': 'بائع عود وبخور وطيب وعطورات شرقية', 'subSector': 'Fragrances, Oud & Tobacco'},
        {'id': 'sr_25', 'name_en': 'Perfume Kiosk / Booth Sales', 'name_ar': 'بائع كشك وبوث عطور بالمجمعات', 'subSector': 'Fragrances, Oud & Tobacco'},
        {'id': 'sr_26', 'name_en': 'Vape & E-Cigarette Shop Sales', 'name_ar': 'بائع سجائر إلكترونية ونكهات فيب', 'subSector': 'Fragrances, Oud & Tobacco'},
        {'id': 'sr_27', 'name_en': 'Tobacco & Hookah Supplies Sales', 'name_ar': 'بائع تبغ ومعسل ومستلزمات الشيشة واللوازم', 'subSector': 'Fragrances, Oud & Tobacco'},

        // Roasteries, Spices & Dates
        {'id': 'sr_28', 'name_en': 'Roastery & Nuts Salesman', 'name_ar': 'بائع محمص ومطحنة ومكسرات', 'subSector': 'Roasteries, Spices & Dates'},
        {'id': 'sr_29', 'name_en': 'Traditional Spices Salesman', 'name_ar': 'بائع بهارات وتوابل وعطارة تقليدية', 'subSector': 'Roasteries, Spices & Dates'},
        {'id': 'sr_30', 'name_en': 'Dates & Sweets Salesman', 'name_ar': 'بائع تمور وحلويات كويتية وشعبية', 'subSector': 'Roasteries, Spices & Dates'},
        {'id': 'sr_31', 'name_en': 'Honey & Natural Products Seller', 'name_ar': 'بائع عسل طبيعي ومنتجات غذائية عضوية', 'subSector': 'Roasteries, Spices & Dates'},
        {'id': 'sr_32', 'name_en': 'Coffee Bean & Coffee Seller', 'name_ar': 'بائع بن وحبوب قهوة مختصة ولوازم القهوة', 'subSector': 'Roasteries, Spices & Dates'},

        // Fabrics, Tailoring & Traditional Wear
        {'id': 'sr_33', 'name_en': 'Fabric & Textile Salesman', 'name_ar': 'بائع أقمشة وخامات رجالي ونسائي', 'subSector': 'Fabrics, Tailoring & Traditional Wear'},
        {'id': 'sr_34', 'name_en': 'Haberdashery & Sewing Supply Sales', 'name_ar': 'بائع كلف ولوازم خياطة وأزرار وخيوط', 'subSector': 'Fabrics, Tailoring & Traditional Wear'},
        {'id': 'sr_35', 'name_en': 'Abaya & Traditional Wear Salesman', 'name_ar': 'بائع عبايات وشيلات ودراعات كويتية', 'subSector': 'Fabrics, Tailoring & Traditional Wear'},
        {'id': 'sr_36', 'name_en': 'Dishdasha Fabrics Salesman', 'name_ar': 'بائع أقمشة دشاديش شتوية وصيفية', 'subSector': 'Fabrics, Tailoring & Traditional Wear'},

        // Fish, Meat & Poultry Markets
        {'id': 'sr_37', 'name_en': 'Butcher / Meat Shop Sales', 'name_ar': 'قصاب وبائع لحوم ملاحم طازجة', 'subSector': 'Fish, Meat & Poultry Markets'},
        {'id': 'sr_38', 'name_en': 'Fishmonger / Seafood Sales', 'name_ar': 'سماك وبائع أسماك وروبيان ومأكولات بحرية', 'subSector': 'Fish, Meat & Poultry Markets'},
        {'id': 'sr_39', 'name_en': 'Fresh Poultry Sales', 'name_ar': 'بائع دواجن وطيور طازجة ومجمدة', 'subSector': 'Fish, Meat & Poultry Markets'},
        {'id': 'sr_40', 'name_en': 'Vegetables & Fruits Stall Sales', 'name_ar': 'بائع خضار وفواكه بسوق الفرضة والمحلات', 'subSector': 'Fish, Meat & Poultry Markets'},

        // Gifts, Flowers & Events
        {'id': 'sr_41', 'name_en': 'Florist / Flower Shop Sales', 'name_ar': 'منسق وبائع زهور وباقات ومسكات', 'subSector': 'Gifts, Flowers & Events'},
        {'id': 'sr_42', 'name_en': 'Chocolate & Event Favors Sales', 'name_ar': 'بائع شوكولاتة وتوزيعات مناسبات وأعراس', 'subSector': 'Gifts, Flowers & Events'},
        {'id': 'sr_43', 'name_en': 'Gift Wrapping & Party Supplies Sales', 'name_ar': 'فني تغليف هدايا ومستلزمات حفلات وزينة', 'subSector': 'Gifts, Flowers & Events'},

        // Hardware, Plumbing & Auto Parts
        {'id': 'sr_44', 'name_en': 'Sanitary Ware & Plumbing Sales', 'name_ar': 'بائع مواد صحية وتمديدات سباكة ومضخات', 'subSector': 'Hardware, Plumbing & Auto Parts'},
        {'id': 'sr_45', 'name_en': 'Hardware & Tools Shop Sales', 'name_ar': 'بائع عدد يدوية وكهربائية ومواد بناء هاردوير', 'subSector': 'Hardware, Plumbing & Auto Parts'},
        {'id': 'sr_46', 'name_en': 'Electrical Supplies & Lighting Sales', 'name_ar': 'بائع مواد كهربائية ووحدات إضاءة وإنارة', 'subSector': 'Hardware, Plumbing & Auto Parts'},
        {'id': 'sr_47', 'name_en': 'Tires & Batteries Shop Sales', 'name_ar': 'بائع ومبدل إطارات وبطاريات سيارات', 'subSector': 'Hardware, Plumbing & Auto Parts'},
        {'id': 'sr_48', 'name_en': 'Car Wash & Detailing Products Sales', 'name_ar': 'بائع مواد ومستلزمات غسيل وبولش وتلميع السيارات', 'subSector': 'Hardware, Plumbing & Auto Parts'},

        // Stationery, Printing & Services
        {'id': 'sr_49', 'name_en': 'Stationery & School Supply Sales', 'name_ar': 'بائع قرطاسية وأدوات مكتبية ومدرسية', 'subSector': 'Stationery, Printing & Services'},
        {'id': 'sr_50', 'name_en': 'Copy Center & Printing Sales', 'name_ar': 'موظف مركز تصوير وطباعة ومخططات', 'subSector': 'Stationery, Printing & Services'},
        {'id': 'sr_51', 'name_en': 'Optics & Eyewear Shop Sales', 'name_ar': 'بائع نظارات وبصريات وعدسات طبية', 'subSector': 'Stationery, Printing & Services'},
        {'id': 'sr_52', 'name_en': 'Kitchenware & Utensils Sales', 'name_ar': 'بائع أواني منزلية وأدوات مطابخ وضيافة', 'subSector': 'Stationery, Printing & Services'},

        // Corporate & B2B Sales
        {'id': 'sr_53', 'name_en': 'B2B Corporate Sales Executive', 'name_ar': 'تنفيذي مبيعات شركات ومناقصات B2B', 'subSector': 'Corporate & B2B Sales'},
        {'id': 'sr_54', 'name_en': 'Building Materials Sales Rep', 'name_ar': 'مندوب مبيعات مواد بناء ومقاولات كبرى', 'subSector': 'Corporate & B2B Sales'},
        {'id': 'sr_55', 'name_en': 'Medical & Education Sales Rep', 'name_ar': 'مندوب مبيعات قطاع طبي ومستشفيات ومدارس', 'subSector': 'Corporate & B2B Sales'},
        {'id': 'sr_56', 'name_en': 'IT & Software Sales Engineer', 'name_ar': 'مهندس مبيعات برمجيات وأنظمة وتكنولوجيا IT', 'subSector': 'Corporate & B2B Sales'},
        {'id': 'sr_57', 'name_en': 'Sales Project Manager', 'name_ar': 'مدير مشاريع مبيعات وتوريد عقود', 'subSector': 'Corporate & B2B Sales'},

        // Outdoor & Field Distribution
        {'id': 'sr_58', 'name_en': 'Wholesale Salesman', 'name_ar': 'مندوب مبيعات جملة وتوزيع خارجي', 'subSector': 'Outdoor & Field Distribution'},
        {'id': 'sr_59', 'name_en': 'HORECA Sales Representative', 'name_ar': 'مندوب توريد قطاع هوريكا فنادق ومطاعم HORECA', 'subSector': 'Outdoor & Field Distribution'},
        {'id': 'sr_60', 'name_en': 'Catering Sales Manager', 'name_ar': 'مدير مبيعات شركات إعاشة وتموين وضيافة', 'subSector': 'Outdoor & Field Distribution'},
      ],
    },

    // 24. Oil, Gas & Petrochemicals Sector (النفط والغاز والبتروكيماويات)
    {
      'code': 'oil_gas',
      'name_ar': 'قطاع النفط والغاز والبتروكيماويات',
      'name_en': 'Oil, Gas & Petrochemicals Sector',
      'image': 'assets/images/sector_oil_gas.jpg',
      'subSectors': [
        'Upstream, Exploration & Drilling',
        'Downstream, Refining & Petrochemicals',
        'Engineering & EPC Projects',
        'Plant Maintenance & Turnaround',
        'Quality Assurance & HSE',
      ],
      'professions': [
        // Upstream, Exploration & Drilling
        {'id': 'og_1', 'name_en': 'Petroleum Engineer', 'name_ar': 'مهندس بترول وإنتاج حقول', 'subSector': 'Upstream, Exploration & Drilling'},
        {'id': 'og_2', 'name_en': 'Drilling Engineer', 'name_ar': 'مهندس حفر آبار نفط وغاز', 'subSector': 'Upstream, Exploration & Drilling'},
        {'id': 'og_3', 'name_en': 'Reservoir Engineer', 'name_ar': 'مهندس مكامن ومحاكاة نفطية', 'subSector': 'Upstream, Exploration & Drilling'},
        {'id': 'og_4', 'name_en': 'Geologist / Geophysicist', 'name_ar': 'جيولوجي / جيوفيزيائي استكشاف طبقات', 'subSector': 'Upstream, Exploration & Drilling'},
        {'id': 'og_5', 'name_en': 'Drilling Fluid / Mud Engineer', 'name_ar': 'مهندس سوائل حفر ومود (Mud Engineer)', 'subSector': 'Upstream, Exploration & Drilling'},
        {'id': 'og_6', 'name_en': 'Rig Manager / Toolpusher', 'name_ar': 'مدير برج حفر / تلبوشر (Toolpusher)', 'subSector': 'Upstream, Exploration & Drilling'},
        {'id': 'og_7', 'name_en': 'Driller / Assistant Driller', 'name_ar': 'حفار رئيسي / مساعد حفار على البرج', 'subSector': 'Upstream, Exploration & Drilling'},
        {'id': 'og_8', 'name_en': 'Derrickman', 'name_ar': 'فني برج الحفر العلوي (ديريك مان)', 'subSector': 'Upstream, Exploration & Drilling'},
        {'id': 'og_9', 'name_en': 'Wireline / Slickline Operator', 'name_ar': 'مشغل معدات وايرلاين وسليك لاين للآبار', 'subSector': 'Upstream, Exploration & Drilling'},

        // Downstream, Refining & Petrochemicals
        {'id': 'og_10', 'name_en': 'Chemical / Process Engineer', 'name_ar': 'مهندس كيميائي وعمليات تشغيل مصافي', 'subSector': 'Downstream, Refining & Petrochemicals'},
        {'id': 'og_11', 'name_en': 'Panel Board Operator (Refinery)', 'name_ar': 'مشغل لوحات تحكم غرف العمليات المركزية (Boardman)', 'subSector': 'Downstream, Refining & Petrochemicals'},
        {'id': 'og_12', 'name_en': 'Field Operator / Plant Operator', 'name_ar': 'مشغل موقع ومحطات تكرير وبتروكيماويات', 'subSector': 'Downstream, Refining & Petrochemicals'},
        {'id': 'og_13', 'name_en': 'Pipeline Operator', 'name_ar': 'مشغل خطوط أنابيب ومحطات ضخ نفط وغاز', 'subSector': 'Downstream, Refining & Petrochemicals'},
        {'id': 'og_14', 'name_en': 'Marine Terminal & Export Operator', 'name_ar': 'مشغل موانئ تصدير نفط وأرصفة بحرية', 'subSector': 'Downstream, Refining & Petrochemicals'},
        {'id': 'og_15', 'name_en': 'Petroleum Chemist / Lab Assistant', 'name_ar': 'كيميائي بترول وفاحص مختبرات جودة النفط', 'subSector': 'Downstream, Refining & Petrochemicals'},

        // Engineering & EPC Projects
        {'id': 'og_16', 'name_en': 'Project Manager (Oil & Gas)', 'name_ar': 'مدير مشاريع نفط وغاز ومقاولات EPC', 'subSector': 'Engineering & EPC Projects'},
        {'id': 'og_17', 'name_en': 'Pipeline Engineer', 'name_ar': 'مهندس خطوط أنابيب وتمديدات نفطية', 'subSector': 'Engineering & EPC Projects'},
        {'id': 'og_18', 'name_en': 'Instrumentation & Control Engineer', 'name_ar': 'مهندس أجهزة دقيقة وتحكم آلي بمحطات النفط', 'subSector': 'Engineering & EPC Projects'},
        {'id': 'og_19', 'name_en': 'Planning & Scheduling Engineer', 'name_ar': 'مهندس تخطيط وجداول زمنية لمشاريع الطاقة', 'subSector': 'Engineering & EPC Projects'},
        {'id': 'og_20', 'name_en': 'Cost Estimation Engineer', 'name_ar': 'مهندس تسعير وحساب كميات مشاريع نفطية', 'subSector': 'Engineering & EPC Projects'},
        {'id': 'og_21', 'name_en': 'Contracts Administrator (Oil & Gas)', 'name_ar': 'مسؤول إدارة وتدقيق عقود ومناقصات نفطية', 'subSector': 'Engineering & EPC Projects'},

        // Plant Maintenance & Turnaround
        {'id': 'og_22', 'name_en': 'Rotating Equipment Engineer', 'name_ar': 'مهندس معدات دوارة وتوربينات ومضخات', 'subSector': 'Plant Maintenance & Turnaround'},
        {'id': 'og_23', 'name_en': 'Static Equipment Engineer', 'name_ar': 'مهندس معدات ثابتة وأوعية ضغط ومبادلات', 'subSector': 'Plant Maintenance & Turnaround'},
        {'id': 'og_24', 'name_en': 'Millwright Technician', 'name_ar': 'فني ميكانيك دقيق وضبط محاذاة (ميلرايت)', 'subSector': 'Plant Maintenance & Turnaround'},
        {'id': 'og_25', 'name_en': 'Instrument & Analyzer Technician', 'name_ar': 'فني أجهزة وتحاليل دقيقة بالمصفاة', 'subSector': 'Plant Maintenance & Turnaround'},
        {'id': 'og_26', 'name_en': 'Valve Maintenance Technician', 'name_ar': 'فني صيانة وتجديد واختبار صمامات أمان PSV', 'subSector': 'Plant Maintenance & Turnaround'},
        {'id': 'og_27', 'name_en': 'Certified Welder (TIG/SMAW)', 'name_ar': 'لحام بترول معتمد ضغط عالي TIG/SMAW', 'subSector': 'Plant Maintenance & Turnaround'},
        {'id': 'og_28', 'name_en': 'Pipe Fabricator & Fitter', 'name_ar': 'براد وفني تشكيل وتركيب أنابيب بترول', 'subSector': 'Plant Maintenance & Turnaround'},
        {'id': 'og_29', 'name_en': 'Scaffolding Inspector / Supervisor', 'name_ar': 'مفتش ومشرف سقالات معتمد بمواقع النفط', 'subSector': 'Plant Maintenance & Turnaround'},

        // Quality Assurance & HSE
        {'id': 'og_30', 'name_en': 'HSE Manager', 'name_ar': 'مدير صحة وسلامة وبيئة HSE بحقول النفط', 'subSector': 'Quality Assurance & HSE'},
        {'id': 'og_31', 'name_en': 'Safety Engineer / Officer', 'name_ar': 'مهندس / ضابط سلامة وأمان مهني نفطي', 'subSector': 'Quality Assurance & HSE'},
        {'id': 'og_32', 'name_en': 'QA/QC Manager', 'name_ar': 'مدير توكيد وضمان ومراقبة جودة QA/QC', 'subSector': 'Quality Assurance & HSE'},
        {'id': 'og_33', 'name_en': 'QA/QC Inspector (Welding & Piping)', 'name_ar': 'مفتش جودة أعمال لحام وأنابيب بترولية', 'subSector': 'Quality Assurance & HSE'},
        {'id': 'og_34', 'name_en': 'QA/QC Inspector (Electrical & INST)', 'name_ar': 'مفتش جودة أعمال كهرباء وأجهزة دقيقة', 'subSector': 'Quality Assurance & HSE'},
        {'id': 'og_35', 'name_en': 'NDT Technician', 'name_ar': 'فني فحوصات غير إتلافية بالأشعة والموجات NDT', 'subSector': 'Quality Assurance & HSE'},
        {'id': 'og_36', 'name_en': 'Environmental Specialist', 'name_ar': 'أخصائي شؤون واستدامة بيئية بحقول النفط', 'subSector': 'Quality Assurance & HSE'},
      ],
    },

    // 25. Technology Software & AI Sector (البرمجيات والذكاء الاصطناعي والتكنولوجيا)
    {
      'code': 'tech_ai',
      'name_ar': 'قطاع البرمجيات والذكاء الاصطناعي والتكنولوجيا',
      'name_en': 'Technology Software & AI Sector',
      'image': 'assets/images/sector_tech_ai.jpg',
      'subSectors': [
        'Mobile & Web Apps',
        'AI & Machine Learning',
        'Cloud & DevOps',
        'Cybersecurity & Networks',
        'IT Support & Infrastructure',
      ],
      'professions': [
        {'id': 'tai_1', 'name_en': 'Flutter & Mobile App Developer', 'name_ar': 'مطور تطبيقات جوال وفلاتر Flutter', 'subSector': 'Mobile & Web Apps'},
        {'id': 'tai_2', 'name_en': 'Full-Stack Web Developer', 'name_ar': 'مطور مواقع وأنظمة سحابية Full-Stack', 'subSector': 'Mobile & Web Apps'},
        {'id': 'tai_3', 'name_en': 'AI & Machine Learning Engineer', 'name_ar': 'مهندس ذكاء اصطناعي وتعلم آلة AI', 'subSector': 'AI & Machine Learning'},
        {'id': 'tai_4', 'name_en': 'Data Analyst & BI Specialist', 'name_ar': 'محلل بيانات وذكاء أعمال PowerBI', 'subSector': 'AI & Machine Learning'},
        {'id': 'tai_5', 'name_en': 'Cybersecurity & Network Engineer', 'name_ar': 'مهندس أمن سيبراني وحماية شبكات', 'subSector': 'Cybersecurity & Networks'},
        {'id': 'tai_6', 'name_en': 'Cloud & DevOps Engineer', 'name_ar': 'مهندس بنية سحابية وعمليات DevOps', 'subSector': 'Cloud & DevOps'},
        {'id': 'tai_7', 'name_en': 'IT Support & Systems Admin', 'name_ar': 'أخصائي دعم فني وإدارة سيرفرات IT', 'subSector': 'IT Support & Infrastructure'},
      ],
    },

    // 26. Cleaning & Facility Services Sector (خدمات التنظيف وإدارة المرافق)
    {
      'code': 'cleaning_facility',
      'name_ar': 'قطاع خدمات التنظيف وإدارة المرافق',
      'name_en': 'Cleaning & Facility Services Sector',
      'image': 'assets/images/sector_cleaning_facility.jpg',
      'subSectors': [
        'Commercial & General Cleaning',
        'Facade & High-Rise Cleaning',
        'Pest Control & Sterilization',
        'Housekeeping & Hospitality',
        'Project Supervisors',
      ],
      'professions': [
        {'id': 'cln_1', 'name_en': 'General Cleaning Staff', 'name_ar': 'عامل وعاملة نظافة عامة ومجمعات', 'subSector': 'Commercial & General Cleaning'},
        {'id': 'cln_2', 'name_en': 'Cleaning Services Project Supervisor', 'name_ar': 'مشرف مشاريع وعقود خدمات نظافة', 'subSector': 'Project Supervisors'},
        {'id': 'cln_3', 'name_en': 'Glass Facade Rope Access Technician', 'name_ar': 'فني تنظيف واجهات زجاجية وأبراج بالحبال', 'subSector': 'Facade & High-Rise Cleaning'},
        {'id': 'cln_4', 'name_en': 'Pest Control & Disinfection Tech', 'name_ar': 'فني مكافحة حشرات وقوارض وتعقيم', 'subSector': 'Pest Control & Sterilization'},
        {'id': 'cln_5', 'name_en': 'Carpet & Upholstery Deep Cleaning Tech', 'name_ar': 'فني غسيل سجاد وكنب بالبخار والمكائن', 'subSector': 'Commercial & General Cleaning'},
        {'id': 'cln_6', 'name_en': 'Hotel Housekeeping Attendant', 'name_ar': 'موظف خدمات غرف وتنظيف فندقي', 'subSector': 'Housekeeping & Hospitality'},
      ],
    },

    // 27. Online Sales Lady Sector (مسوقات المبيعات الإلكترونية أونلاين)
    {
      'code': 'online_sales_lady',
      'name_ar': 'قطاع مسوقات المبيعات الإلكترونية (أونلاين)',
      'name_en': 'Online Sales Lady Sector',
      'image': 'assets/images/sector_online_sales_lady.jpg',
      'subSectors': [
        'Live Commerce & Streaming',
        'WhatsApp Orders & Chat Sales',
        'E-Commerce Store Coordination',
        'Online Tele-Sales & Follow-up',
      ],
      'professions': [
        {'id': 'osl_1', 'name_en': 'Live Commerce Sales Presenter', 'name_ar': 'مذيعة ومقدمة بثوث مبيعات لايف وتيك توك', 'subSector': 'Live Commerce & Streaming'},
        {'id': 'osl_2', 'name_en': 'WhatsApp & Chat Commerce Sales Lady', 'name_ar': 'مسوقة مبيعات ومحادثات واتساب أونلاين', 'subSector': 'WhatsApp Orders & Chat Sales'},
        {'id': 'osl_3', 'name_en': 'E-Commerce Store Order Coordinator', 'name_ar': 'منسقة طلبات ومتاجر إلكترونية وسلات', 'subSector': 'E-Commerce Store Coordination'},
        {'id': 'osl_4', 'name_en': 'Online Tele-Sales & Deal Closer', 'name_ar': 'مسوقة هاتفية وإتمام صفقات منتجات', 'subSector': 'Online Tele-Sales & Follow-up'},
        {'id': 'osl_5', 'name_en': 'Online Customer Care Specialist', 'name_ar': 'أخصائية خدمة ومتابعة عملاء المتاجر', 'subSector': 'WhatsApp Orders & Chat Sales'},
      ],
    },
  ];

  // Kuwait Work Types
  static const List<Map<String, String>> workTypes = [
    {'id': 'all', 'name_ar': 'الكل', 'name_en': 'All Types'},
    {'id': 'full_time', 'name_ar': 'دوام كامل', 'name_en': 'Full-Time'},
    {'id': 'part_time', 'name_ar': 'دوام جزئي داخل الكويت', 'name_en': 'Part-Time in Kuwait'},
    {'id': 'freelance', 'name_ar': 'عمل حر / مؤقت', 'name_en': 'Freelance / Temporary'},
  ];

  // Kuwait Applicant Categories
  static const List<Map<String, String>> candidateCategories = [
    {'id': 'all', 'name_ar': 'جميع المرشحين', 'name_en': 'All Candidates'},
    {'id': 'gcc_citizen', 'name_ar': 'مواطنو دول مجلس التعاون (الكوادر السعودية)', 'name_en': 'GCC Nationals (Saudi Talents)'},
    {'id': 'bedoun', 'name_ar': 'غير محددي الجنسية (البدون)', 'name_en': 'Non-ID Residents'},
    {'id': 'resident', 'name_ar': 'مقيمون داخل الكويت', 'name_en': 'Kuwait Residents'},
    {'id': 'overseas', 'name_ar': 'باحثون عن عمل من الخارج', 'name_en': 'Overseas Applicants'},
  ];

  // ==========================================================================
  // Sectors & Key Professions for Post-Job & Job Filters (All 27 Sectors)
  // ==========================================================================
  static const List<Map<String, dynamic>> sectors = [
    {
      'code': 'construction',
      'name_ar': 'قطاع المقاولات والإنشاءات',
      'name_en': 'Construction Sector',
      'icon': 'architecture_rounded',
      'professions': [
        {'id': 'p_cs1', 'name_ar': 'نجار خشب مسلّح (أعمدة وأسقف)', 'name_en': 'Formwork Carpenter (Columns & Slabs)'},
        {'id': 'p_cs2', 'name_ar': 'صباب خرسانة جاهزة', 'name_en': 'Concrete Pourer'},
        {'id': 'p_cs3', 'name_ar': 'نجار هياكل خرسانية', 'name_en': 'Concrete Structure Carpenter'},
        {'id': 'p_cs4', 'name_ar': 'حداد تسليح ومخططات إنشائية', 'name_en': 'Steel Fixer / Rebar Worker'},
        {'id': 'p_cs5', 'name_ar': 'فني جبس بورد وديكور أسقف', 'name_en': 'Gypsum Board & Ceiling Tech'},
        {'id': 'p_cs6', 'name_ar': 'كهربائي تمديدات ومباني', 'name_en': 'Building Electrician'},
        {'id': 'p_cs7', 'name_ar': 'فني صحي وتمديدات مباني', 'name_en': 'Sanitary Installation Plumber'},
        {'id': 'p_cs8', 'name_ar': 'مراقب وملاحظ مواقع إنشائية', 'name_en': 'Construction Foreman'},
        {'id': 'p_cs9', 'name_ar': 'عامل نظافة وتنظيم مواقع', 'name_en': 'Site Cleanliness Worker'},
      ],
    },
    {
      'code': 'drivers',
      'name_ar': 'قطاع النقل والتوصيل والسائقين',
      'name_en': 'Transport, Delivery and Drivers Sector',
      'icon': 'directions_car_rounded',
      'professions': [
        {'id': 'p_dr1', 'name_ar': 'سائق توصيل طلبات (سيارة)', 'name_en': 'Courier Car Delivery Driver'},
        {'id': 'p_dr2', 'name_ar': 'سائق دراجة توصيل سريعة', 'name_en': 'Motorbike Delivery Driver'},
        {'id': 'p_dr3', 'name_ar': 'سائق تريلا ومعدات ثقيلة', 'name_en': 'Heavy Equipment & Truck Driver'},
        {'id': 'p_dr4', 'name_ar': 'سائق باص وحافلات نقل', 'name_en': 'Bus Driver'},
        {'id': 'p_dr5', 'name_ar': 'مشرف عمليات وتشغيل أسطول', 'name_en': 'Fleet & Operations Supervisor'},
        {'id': 'p_dr6', 'name_ar': 'سائق خاص وعائلات وشخصيات', 'name_en': 'Personal / VIP Driver'},
        {'id': 'p_dr7', 'name_ar': 'سائق رافعة شوكية وتشوين', 'name_en': 'Forklift Operator'},
      ],
    },
    {
      'code': 'medical',
      'name_ar': 'القطاع الطبي والرعاية الصحية',
      'name_en': 'Medical and Healthcare Sector',
      'icon': 'local_hospital_rounded',
      'professions': [
        {'id': 'p_med1', 'name_ar': 'ممرض / ممرضة عامة', 'name_en': 'Staff Nurse'},
        {'id': 'p_med2', 'name_ar': 'صيدلي مرخص مزاولة مهنة', 'name_en': 'Licensed Pharmacist'},
        {'id': 'p_med3', 'name_ar': 'مساعد صيدلي', 'name_en': 'Pharmacy Assistant'},
        {'id': 'p_med4', 'name_ar': 'فني أجهزة ومعدات طبية', 'name_en': 'Medical Devices Technician'},
        {'id': 'p_med5', 'name_ar': 'فني أشعة ومختبرات', 'name_en': 'Radiology & Lab Technician'},
        {'id': 'p_med6', 'name_ar': 'طبيب ممارس عام', 'name_en': 'General Practitioner'},
        {'id': 'p_med7', 'name_ar': 'أخصائي علاج طبيعي وتأهيلي', 'name_en': 'Physiotherapist / Psychotherapist'},
      ],
    },
    {
      'code': 'technical',
      'name_ar': 'قطاع الفنيين والصيانة العامة',
      'name_en': 'Technical and Maintenance Sector',
      'icon': 'build_rounded',
      'professions': [
        {'id': 'p_tech1', 'name_ar': 'فني تكييف مركزي ووحدات', 'name_en': 'Central AC Technician'},
        {'id': 'p_tech2', 'name_ar': 'فني صحي وسباكة ومضخات', 'name_en': 'Installation & Repair Plumber'},
        {'id': 'p_tech3', 'name_ar': 'فني صيانة وتركيب مصاعد', 'name_en': 'Elevator Installation & Repair Tech'},
        {'id': 'p_tech4', 'name_ar': 'فني ألمنيوم وشبابيك وشتر', 'name_en': 'Aluminum & Windows Tech'},
        {'id': 'p_tech5', 'name_ar': 'فني أجهزة منزلية وغسالات', 'name_en': 'Home Appliances Technician'},
        {'id': 'p_tech6', 'name_ar': 'فني إنذار حريق ومكافحة', 'name_en': 'Fire Alarm & Safety Tech'},
      ],
    },
    {
      'code': 'restaurants',
      'name_ar': 'قطاع المطاعم والضيافة',
      'name_en': 'Restaurants and Hospitality Sector',
      'icon': 'restaurant_rounded',
      'professions': [
        {'id': 'p_res1', 'name_ar': 'شيف عام / طباخ أكلات', 'name_en': 'Executive Chef / Cook'},
        {'id': 'p_res2', 'name_ar': 'باريستا محترف مشروبات', 'name_en': 'Professional Barista'},
        {'id': 'p_res3', 'name_ar': 'كابتن صالة وضيافة', 'name_en': 'Floor Captain / Head Waiter'},
        {'id': 'p_res4', 'name_ar': 'شيف حلويات ومعجنات', 'name_en': 'Pastry & Dessert Chef'},
        {'id': 'p_res5', 'name_ar': 'مساعد مطبخ ونظافة وسويبر', 'name_en': 'Kitchen Helper / Sweeper'},
        {'id': 'p_res6', 'name_ar': 'مشرف فرع وصالة مطاعم', 'name_en': 'Restaurant Supervisor'},
      ],
    },
    {
      'code': 'education',
      'name_ar': 'قطاع التعليم والتدريس',
      'name_en': 'Education Sector',
      'icon': 'school_rounded',
      'professions': [
        {'id': 'p_edu1', 'name_ar': 'معلم رياضيات وعلوم', 'name_en': 'Math & Science Teacher'},
        {'id': 'p_edu2', 'name_ar': 'معلم لغة إنجليزية', 'name_en': 'English Language Teacher'},
        {'id': 'p_edu3', 'name_ar': 'معلم لغة عربية وتربية إسلامية', 'name_en': 'Arabic & Islamic Studies Teacher'},
        {'id': 'p_edu4', 'name_ar': 'معلمة رياض أطفال وحضانة', 'name_en': 'Kindergarten / Nursery Teacher'},
        {'id': 'p_edu5', 'name_ar': 'أخصائي تربية خاصة وصعوبات تعلم', 'name_en': 'Special Education Specialist'},
        {'id': 'p_edu6', 'name_ar': 'مدرب معتمد بمراكز تدريب مهني', 'name_en': 'Training Center Instructor'},
      ],
    },
    {
      'code': 'engineering',
      'name_ar': 'القطاع الهندسي',
      'name_en': 'Engineering Sector',
      'icon': 'engineering_rounded',
      'professions': [
        {'id': 'p_eng1', 'name_ar': 'مهندس مدني موقع ومشاريع', 'name_en': 'Civil Site Engineer'},
        {'id': 'p_eng2', 'name_ar': 'مهندس إنشائي وتصميم', 'name_en': 'Structural Design Engineer'},
        {'id': 'p_eng3', 'name_ar': 'مهندس ميكانيك تكييف وصحي MEP', 'name_en': 'MEP Mechanical Engineer'},
        {'id': 'p_eng4', 'name_ar': 'مهندس كهرباء قوى', 'name_en': 'Electrical Project Engineer'},
        {'id': 'p_eng5', 'name_ar': 'مهندس معماري وتصميم داخلي', 'name_en': 'Architectural & Interior Designer'},
      ],
    },
    {
      'code': 'accounting',
      'name_ar': 'قطاع المحاسبة والمالية',
      'name_en': 'Accounting Sector',
      'icon': 'account_balance_wallet_rounded',
      'professions': [
        {'id': 'p_acc1', 'name_ar': 'محاسب عام أول', 'name_en': 'General Senior Accountant'},
        {'id': 'p_acc2', 'name_ar': 'مدقق ومراجع حسابات', 'name_en': 'Internal Auditor'},
        {'id': 'p_acc3', 'name_ar': 'محاسب مدفوعات ومقبوضات', 'name_en': 'Accounts Payable & Receivable'},
        {'id': 'p_acc4', 'name_ar': 'محاسب تكاليف ومستودعات', 'name_en': 'Cost & Inventory Accountant'},
        {'id': 'p_acc5', 'name_ar': 'محلل مالي وميزانيات', 'name_en': 'Financial Analyst'},
      ],
    },
    {
      'code': 'legal',
      'name_ar': 'القطاع القانوني والمحاماة',
      'name_en': 'Legal Sector',
      'icon': 'gavel_rounded',
      'professions': [
        {'id': 'p_leg1', 'name_ar': 'مستشار قانوني للشركات', 'name_en': 'Legal Consultant & Corporate Advisor'},
        {'id': 'p_leg2', 'name_ar': 'محامي ترافع ومحاكم وقضايا', 'name_en': 'Litigation Lawyer'},
        {'id': 'p_leg3', 'name_ar': 'صائغ عقود واتفاقيات تجارية', 'name_en': 'Commercial Contracts Drafter'},
        {'id': 'p_leg4', 'name_ar': 'أخصائي شؤون قانون العمل الكويتي', 'name_en': 'Kuwait Labor Law Specialist'},
        {'id': 'p_leg5', 'name_ar': 'باحث قانوني ومساعد محاماة', 'name_en': 'Legal Researcher & Paralegal'},
      ],
    },
    {
      'code': 'beauty_salon',
      'name_ar': 'قطاع التجميل والصالونات',
      'name_en': 'Beauty & Salon Sector',
      'icon': 'face_rounded',
      'professions': [
        {'id': 'p_bs1', 'name_ar': 'كوافير / مصفف شعر وتساريح', 'name_en': 'Professional Hair Stylist'},
        {'id': 'p_bs2', 'name_ar': 'خبيرة مكياج وتجميل', 'name_en': 'Certified Makeup Artist'},
        {'id': 'p_bs3', 'name_ar': 'أخصائية أظافر وبديكير ومنيكير', 'name_en': 'Nail Art Specialist'},
        {'id': 'p_bs4', 'name_ar': 'أخصائية عناية بالبشرة', 'name_en': 'Skincare & Facial Specialist'},
        {'id': 'p_bs5', 'name_ar': 'حلاق رجالي متمكن', 'name_en': 'Men Professional Barber'},
      ],
    },
    {
      'code': 'car_bike_tech',
      'name_ar': 'قطاع فنيي السيارات والدراجات',
      'name_en': 'Car & Bike Technicians Sector',
      'icon': 'car_repair_rounded',
      'professions': [
        {'id': 'p_cbt1', 'name_ar': 'ميكانيكي سيارات محركات وجير', 'name_en': 'Auto Mechanic Engine Specialist'},
        {'id': 'p_cbt2', 'name_ar': 'كهربائي سيارات وفحص كمبيوتر', 'name_en': 'Auto Electrician & Diagnostic'},
        {'id': 'p_cbt3', 'name_ar': 'ميكانيكي دراجات وسكوتر', 'name_en': 'Motorcycle Mechanic'},
        {'id': 'p_cbt4', 'name_ar': 'فني تكييف سيارات وكهرباء', 'name_en': 'Car AC Specialist'},
        {'id': 'p_cbt5', 'name_ar': 'سمكري وحداد هياكل سيارات', 'name_en': 'Auto Body Denter'},
      ],
    },
    {
      'code': 'digital_marketing',
      'name_ar': 'قطاع صناعة المحتوى والتسويق الرقمي',
      'name_en': 'Content Creation & Digital Marketing Sector',
      'icon': 'campaign_rounded',
      'professions': [
        {'id': 'p_dm1', 'name_ar': 'أخصائي إدارة منصات تواصل اجتماعي', 'name_en': 'Social Media Specialist'},
        {'id': 'p_dm2', 'name_ar': 'مدير حملات إعلانية ممولة', 'name_en': 'Digital Marketing & Ads Manager'},
        {'id': 'p_dm3', 'name_ar': 'مونتير ومصمم مقاطع ريلز وفيديو', 'name_en': 'Video Editor & Reels Creator'},
        {'id': 'p_dm4', 'name_ar': 'مصمم جرافيك وهوية بصرية', 'name_en': 'Creative Graphic Designer'},
        {'id': 'p_dm5', 'name_ar': 'كاتب محتوى تسويقي وإعلانات', 'name_en': 'Marketing Copywriter'},
      ],
    },
    {
      'code': 'insurance',
      'name_ar': 'قطاع التأمين',
      'name_en': 'Insurance Sector',
      'icon': 'security_rounded',
      'professions': [
        {'id': 'p_ins1', 'name_ar': 'تنفيذي مبيعات وتسويق تأمين', 'name_en': 'Insurance Sales Executive'},
        {'id': 'p_ins2', 'name_ar': 'مسؤول تقدير وتسوية مطالبات', 'name_en': 'Claims Assessment Officer'},
        {'id': 'p_ins3', 'name_ar': 'مكتتب تأمين صحي ومركبات', 'name_en': 'Insurance Underwriter'},
        {'id': 'p_ins4', 'name_ar': 'وسيط تأمين شركات ومشاريع', 'name_en': 'Corporate Insurance Broker'},
      ],
    },
    {
      'code': 'aviation',
      'name_ar': 'قطاع الطيران والخدمات الجوية',
      'name_en': 'Aviation Sector',
      'icon': 'flight_takeoff_rounded',
      'professions': [
        {'id': 'p_av1', 'name_ar': 'مضيف / مضيفة طيران', 'name_en': 'Flight Attendant / Cabin Crew'},
        {'id': 'p_av2', 'name_ar': 'موظف خدمات أرضية بالمطار', 'name_en': 'Airport Ground Handling Agent'},
        {'id': 'p_av3', 'name_ar': 'مهندس صيانة وهياكل طائرات', 'name_en': 'Aircraft Maintenance Engineer'},
        {'id': 'p_av4', 'name_ar': 'موظف حجز وتذاكر طيران', 'name_en': 'Airline Ticketing Agent'},
      ],
    },
    {
      'code': 'tailoring',
      'name_ar': 'قطاع الخياطة وتصميم الأزياء',
      'name_en': 'Tailoring & Sewing Sector',
      'icon': 'content_cut_rounded',
      'professions': [
        {'id': 'p_tail1', 'name_ar': 'خياط وخياطة نسائي وعبايات', 'name_en': 'Women Dressmaker & Abaya Tailor'},
        {'id': 'p_tail2', 'name_ar': 'خياط دشاديش كويتية', 'name_en': 'Kuwaiti Dishdasha Tailor'},
        {'id': 'p_tail3', 'name_ar': 'مصمم / مصممة أزياء وموديلات', 'name_en': 'Fashion Designer'},
        {'id': 'p_tail4', 'name_ar': 'باترونيست وقاص أقمشة', 'name_en': 'Pattern Cutter'},
      ],
    },
    {
      'code': 'car_rental',
      'name_ar': 'قطاع معارض وتأجير السيارات',
      'name_en': 'Car Showrooms & Rental Sector',
      'icon': 'key_rounded',
      'professions': [
        {'id': 'p_cr1', 'name_ar': 'مستشار مبيعات سيارات معارض', 'name_en': 'Showroom Car Sales Consultant'},
        {'id': 'p_cr2', 'name_ar': 'موظف استقبال وتأجير سيارات', 'name_en': 'Car Rental Branch Agent'},
        {'id': 'p_cr3', 'name_ar': 'مسؤول فحص وتسليم أسطول سيارات', 'name_en': 'Fleet Inspection Officer'},
        {'id': 'p_cr4', 'name_ar': 'مدير فرع تأجير ومعارض', 'name_en': 'Rental Branch Manager'},
      ],
    },
    {
      'code': 'security',
      'name_ar': 'قطاع الأمن والحراسة',
      'name_en': 'Security & Guarding Sector',
      'icon': 'shield_rounded',
      'professions': [
        {'id': 'p_sec1', 'name_ar': 'حارس أمن منشآت ومجمعات', 'name_en': 'Facility Security Guard'},
        {'id': 'p_sec2', 'name_ar': 'مشرف أمن وحراسات ميداني', 'name_en': 'Security Field Supervisor'},
        {'id': 'p_sec3', 'name_ar': 'مشغل كاميرات وغرف تحكم مراقبة', 'name_en': 'CCTV Control Operator'},
        {'id': 'p_sec4', 'name_ar': 'حارس حماية شخصية ومواكب', 'name_en': 'Close Protection Bodyguard'},
      ],
    },
    {
      'code': 'medical_engineering',
      'name_ar': 'قطاع الهندسة الطبية والأجهزة',
      'name_en': 'Medical Engineering Sector',
      'icon': 'medical_services_rounded',
      'professions': [
        {'id': 'p_me1', 'name_ar': 'مهندس أجهزة ومعدات طبية', 'name_en': 'Biomedical Equipment Engineer'},
        {'id': 'p_me2', 'name_ar': 'فني صيانة تجهيزات مستشفيات', 'name_en': 'Hospital Medical Tech'},
        {'id': 'p_me3', 'name_ar': 'فني أجهزة رنين وأشعة طبية', 'name_en': 'Medical Imaging Tech'},
        {'id': 'p_me4', 'name_ar': 'مهندس مبيعات أجهزة ومستلزمات', 'name_en': 'Medical Devices Sales Engineer'},
      ],
    },
    {
      'code': 'sports_health',
      'name_ar': 'قطاع المعاهد الرياضية والصحية',
      'name_en': 'Sport and Health Institutes Sector',
      'icon': 'fitness_center_rounded',
      'professions': [
        {'id': 'p_sh1', 'name_ar': 'مدرب لياقة بدنية وبناء أجسام', 'name_en': 'Certified Fitness Trainer'},
        {'id': 'p_sh2', 'name_ar': 'أخصائي تغذية رياضية وعلاجية', 'name_en': 'Clinical Nutritionist'},
        {'id': 'p_sh3', 'name_ar': 'مدرب سباحة ومنقذ معتمد', 'name_en': 'Swimming Coach & Lifeguard'},
        {'id': 'p_sh4', 'name_ar': 'أخصائي مساج وتدليك علاجي', 'name_en': 'Massage Therapist'},
      ],
    },
    {
      'code': 'secretarial',
      'name_ar': 'قطاع السكرتارية وإدارة المكاتب',
      'name_en': 'Deputies and Secretary Sector',
      'icon': 'desk_rounded',
      'professions': [
        {'id': 'p_secr1', 'name_ar': 'سكرتير تنفيذي ومكتب إدارة عليا', 'name_en': 'Executive Secretary'},
        {'id': 'p_secr2', 'name_ar': 'مدير مكتب وإداري ثنائي اللغة', 'name_en': 'Bilingual Office Administrator'},
        {'id': 'p_secr3', 'name_ar': 'موظف استقبال واستعلامات', 'name_en': 'Receptionist & Front Desk'},
        {'id': 'p_secr4', 'name_ar': 'مدخل بيانات وأرشفة إلكترونية', 'name_en': 'Data Entry Specialist'},
      ],
    },
    {
      'code': 'agriculture',
      'name_ar': 'القطاع الزراعي والثروة الحيوانية',
      'name_en': 'Agricultural and Livestock Sector',
      'icon': 'yard_rounded',
      'professions': [
        {'id': 'p_agr1', 'name_ar': 'مهندس زراعي محاصيل ومحميات', 'name_en': 'Agricultural Crops Engineer'},
        {'id': 'p_agr2', 'name_ar': 'عامل مزارع وجواخير كويتية', 'name_en': 'Kuwait Farm Worker'},
        {'id': 'p_agr3', 'name_ar': 'فني شبكات ري وتنسيق حدائق', 'name_en': 'Irrigation & Landscape Tech'},
        {'id': 'p_agr4', 'name_ar': 'طبيب بيطري ثروة حيوانية', 'name_en': 'Veterinary Doctor'},
      ],
    },
    {
      'code': 'factories',
      'name_ar': 'قطاع المصانع والإنتاج الصناعي',
      'name_en': 'Factories Sector',
      'icon': 'factory_rounded',
      'professions': [
        {'id': 'p_fac1', 'name_ar': 'عامل خط إنتاج وتجميع مصانع', 'name_en': 'Production Line Worker'},
        {'id': 'p_fac2', 'name_ar': 'مشرف إنتاج وتشغيل مصانع', 'name_en': 'Factory Production Supervisor'},
        {'id': 'p_fac3', 'name_ar': 'فني ميكانيك وصيانة آلات صناعية', 'name_en': 'Industrial Machinery Tech'},
        {'id': 'p_fac4', 'name_ar': 'مفتش جودة تصنيع QC', 'name_en': 'Quality Control Inspector'},
      ],
    },
    {
      'code': 'sales_retail',
      'name_ar': 'قطاع المبيعات والتجزئة والأسواق التجارية',
      'name_en': 'Sales, Retail & Commercial Markets Sector',
      'icon': 'storefront_rounded',
      'professions': [
        {'id': 'p_sr1', 'name_ar': 'بائع معارض وأسواق تجارية', 'name_en': 'Retail Showroom Sales Associate'},
        {'id': 'p_sr2', 'name_ar': 'كاشير ومحاسب نقاط بيع', 'name_en': 'Cashier / POS Operator'},
        {'id': 'p_sr3', 'name_ar': 'مندوب مبيعات وتسويق خارجي B2B', 'name_en': 'Outdoor B2B Sales Representative'},
        {'id': 'p_sr4', 'name_ar': 'مدير فرع ومتجر وسوق تجاري', 'name_en': 'Store & Branch Manager'},
        {'id': 'p_sr5', 'name_ar': 'منسق أرفف وعارض بضائع', 'name_en': 'Shelf Merchandiser'},
      ],
    },
    {
      'code': 'oil_gas',
      'name_ar': 'قطاع النفط والغاز والبتروكيماويات',
      'name_en': 'Oil, Gas & Petrochemicals Sector',
      'icon': 'oil_barrel_rounded',
      'professions': [
        {'id': 'p_og1', 'name_ar': 'مهندس بترول وحفر آبار', 'name_en': 'Petroleum / Drilling Engineer'},
        {'id': 'p_og2', 'name_ar': 'فني تشغيل مصافي وبتروكيماويات', 'name_en': 'Refinery Operations Tech'},
        {'id': 'p_og3', 'name_ar': 'فني أبراج ومنصات حفر نفطية', 'name_en': 'Oil Rig Operator'},
        {'id': 'p_og4', 'name_ar': 'لحام أنابيب ضغط عالي 6G/TIG', 'name_en': 'Piping Welder 6G/TIG'},
        {'id': 'p_og5', 'name_ar': 'ضابط سلامة وصحة بيئية نفطية HSE', 'name_en': 'Oilfield Safety HSE Officer'},
      ],
    },
    {
      'code': 'tech_ai',
      'name_ar': 'قطاع البرمجيات والذكاء الاصطناعي والتكنولوجيا',
      'name_en': 'Technology Software & AI Sector',
      'icon': 'memory_rounded',
      'professions': [
        {'id': 'p_tai1', 'name_ar': 'مطور تطبيقات جوال وفلاتر Flutter', 'name_en': 'Flutter Mobile App Developer'},
        {'id': 'p_tai2', 'name_ar': 'مطور مواقع وأنظمة Full-Stack', 'name_en': 'Full-Stack Web Developer'},
        {'id': 'p_tai3', 'name_ar': 'مهندس ذكاء اصطناعي وتعلم آلة AI', 'name_en': 'AI & Machine Learning Engineer'},
        {'id': 'p_tai4', 'name_ar': 'محلل بيانات وذكاء أعمال PowerBI', 'name_en': 'Data Analyst & BI Specialist'},
        {'id': 'p_tai5', 'name_ar': 'مهندس أمن سيبراني وشبكات', 'name_en': 'Cybersecurity & Network Engineer'},
        {'id': 'p_tai6', 'name_ar': 'أخصائي دعم فني وسيرفرات IT', 'name_en': 'IT Support Specialist'},
      ],
    },
    {
      'code': 'cleaning_facility',
      'name_ar': 'قطاع خدمات التنظيف وإدارة المرافق',
      'name_en': 'Cleaning & Facility Services Sector',
      'icon': 'cleaning_services_rounded',
      'professions': [
        {'id': 'p_cln1', 'name_ar': 'عامل وعاملة نظافة عامة ومجمعات', 'name_en': 'General Cleaning Staff'},
        {'id': 'p_cln2', 'name_ar': 'مشرف مشاريع وعقود خدمات نظافة', 'name_en': 'Cleaning Project Supervisor'},
        {'id': 'p_cln3', 'name_ar': 'فني تنظيف واجهات بالحبال', 'name_en': 'Rope Access Facade Tech'},
        {'id': 'p_cln4', 'name_ar': 'فني مكافحة حشرات وقوارض وتعقيم', 'name_en': 'Pest Control & Disinfection Tech'},
      ],
    },
    {
      'code': 'online_sales_lady',
      'name_ar': 'قطاع مسوقات المبيعات الإلكترونية (أونلاين)',
      'name_en': 'Online Sales Lady Sector',
      'icon': 'support_agent_rounded',
      'professions': [
        {'id': 'p_osl1', 'name_ar': 'مذيعة ومقدمة بثوث مبيعات لايف', 'name_en': 'Live Commerce Sales Presenter'},
        {'id': 'p_osl2', 'name_ar': 'مسوقة مبيعات ومحادثات واتساب أونلاين', 'name_en': 'WhatsApp & Chat Sales Lady'},
        {'id': 'p_osl3', 'name_ar': 'منسقة طلبات ومتاجر إلكترونية', 'name_en': 'E-Commerce Store Coordinator'},
        {'id': 'p_osl4', 'name_ar': 'مسوقة هاتفية وإتمام صفقات أونلاين', 'name_en': 'Online Tele-Sales Specialist'},
        {'id': 'p_osl5', 'name_ar': 'أخصائية خدمة ومتابعة عملاء المتاجر', 'name_en': 'Online Customer Care Specialist'},
      ],
    },
  ];

  // Service Ad Categories in Kuwait
  static const List<Map<String, dynamic>> serviceCategories = [
    {
      'id': 's1',
      'name_ar': 'تصليح وصيانة منازل',
      'name_en': 'Home Repair & Maintenance',
      'icon': 'home_repair_service',
      'subcategories': [
        'تصليح تكييف ووحدات',
        'صيانة كهرباء وتمديدات',
        'صحي وسباكة ومضخات',
        'ألمنيوم وشتر وأبواب',
        'أصباغ وورق جدران',
      ],
    },
    {
      'id': 's2',
      'name_ar': 'تنظيف ومكافحة حشرات',
      'name_en': 'Cleaning & Pest Control',
      'icon': 'cleaning_services',
      'subcategories': [
        'تنظيف منازل ومباني',
        'غسيل سجاد وكنب بالبخار',
        'مكافحة قوارض وحشرات مع كفالة',
        'جلي وتلميع رخام',
      ],
    },
    {
      'id': 's3',
      'name_ar': 'نقل عفش وأثاث',
      'name_en': 'Furniture Moving & Packing',
      'icon': 'local_shipping',
      'subcategories': [
        'نقل عفش داخل الكويت مع فك وتركيب',
        'كراتين وتغليف وتخزين',
        'ونش رفع أثاث خارجي',
      ],
    },
    {
      'id': 's4',
      'name_ar': 'سيارات وكهرباء وميكانيك',
      'name_en': 'Auto Care & Roadside Assistance',
      'icon': 'car_repair',
      'subcategories': [
        'تبديل بطاريات وبنشر متنقل 24 ساعة',
        'فحص كمبيوتر وبرمجة سيارات',
        'سطحة ونش إنقاذ داخل محافظات الكويت',
      ],
    },
    {
      'id': 's5',
      'name_ar': 'دروس وتدريب',
      'name_en': 'Tutoring & Training',
      'icon': 'school',
      'subcategories': [
        'مدرسون خصوصيون لجميع المراحل',
        'دورات لغات وحاسوب',
        'تدريب قيادة سيارات بالكويت',
      ],
    },
  ];
}
