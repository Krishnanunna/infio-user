import 'package:flutter/material.dart';

import '../models/business.dart';
import '../models/quote.dart';
import '../models/quote_request.dart';
import '../models/service_category.dart';
import '../theme/app_colors.dart';

/// Static fixtures standing in for a backend during this build pass.
/// See design_reference/*/code.html for the source content each list mirrors.
/// Image URLs below are pulled directly from those Stitch exports (Google's
/// "aida" content host) — real photos, not placeholders. [RemoteImage] /
/// [RemoteAvatar] fall back to an icon if a URL ever stops resolving.
class MockData {
  MockData._();

  static const categories = <ServiceCategory>[
    ServiceCategory(
      id: 'ac',
      name: 'AC Repair',
      icon: Icons.ac_unit_outlined,
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBd_7YpHxMxFWFsJ49a-Mp1qiRP9oIrQ-ykFtWePrBVue-QqxOJBRBBNPuZHTOpGkL4rcT0NlRq-7KOlXm8WROukeJE5P3DH7tvnT0Wsgp5Rm1imwzS3b3aO9bKwkqJ3uSR5DJ23DLUdC4Wj196AaQp6uwyhKsIuvhzeCK7jVfeu01cqQovZQ07poIIdt_mx6A0HapFqHr3XSZ5bsEX-MdaRXmlus_25Crq5g4jINUDldkwsQ7UWulS',
      subCategories: [
        'Split AC Service',
        'Window AC Service',
        'Gas Refill',
        'Installation',
        'Uninstallation',
      ],
    ),
    ServiceCategory(
      id: 'plumbing',
      name: 'Plumber',
      icon: Icons.plumbing_outlined,
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAevCRpA-IfA6ZM2QaG9z6IekjwrrCykyGXZ5qEH-h8AEqNNpoumaqcslqQkdlQLUzgRntWIGaKTGLjBx2UpxdHO6c-NxGUdvkh8bR9PrkzPGDs-fc2q-FvNeksWuqMUqz14uB7WrVdUV6r0iaeGXOzsNaGMziEYJovlKQNEqSo8H7UWl3sI6Hz-feqLNfle8Ctcz1M45UwpX0gXl7jD7xvc4j1pA1AAcs-I0hpe2gpmaraTd1FB4B_',
      subCategories: [
        'Leakage Repair',
        'Tap Repair/Replacement',
        'Pipe Blockage',
        'Water Tank Cleaning',
      ],
    ),
    ServiceCategory(
      id: 'electrical',
      name: 'Electrician',
      icon: Icons.electrical_services_outlined,
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuB6w9U57krITrHsPNWL6lKCGvYYYqqyTlYj1W1aGsLqIn03QOM2S0kRG9v4Fbh9-o9POFc_LlQa6cAZcpYonhBecgWOWgyRQ_tDxMU4xpp4ql_UrHnKbvOJ63jGwcVGZfMyRGUgMBHllhv65qdJZCIoTAzyPur1Pe0eS7nxeoSS1dImdfBygTjfWu4oztcst9B6mmKe4CEyRxUVUPfGPDacFssVkGgYMayM71Nb678ENTyAMtADwlGf',
      subCategories: [
        'Switchboard Repair',
        'Fan Installation',
        'Wiring Issues',
        'MCB Tripping',
      ],
    ),
    ServiceCategory(
      id: 'salon',
      name: 'Salon',
      icon: Icons.content_cut_outlined,
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCS5nqnOq4M8UIpTLQskC6bMDFZEJBzDrUfyOlPI49jWqX_38ZKopt85UYAoULnFna3iZpesnaYCFG1t198CbmGmNTMavUDH5wJErxLuVq5rt0WV6ugm-8aOD8IQaKeWaFVDiodseyrIbVdiC3k3gizxYaQ0BnJejGWzJdDFyjG5Ob6JGF7h4Y1myxZSDsosccKP_Qr_uPTrCH9PvNl8bH47WVtGtTgQGIZrTZ7N68iP3NbMQ3TANcI',
      subCategories: ['Haircut', 'Facial', 'Spa', 'Bridal Makeup'],
    ),
    ServiceCategory(
      id: 'tutor',
      name: 'Tutor',
      icon: Icons.school_outlined,
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDunh77NaSMfgGiX3UNwAeuMCT5sYOfg5e6MGn-oRphSsN1JKkY2VC_ZXlJH9IXzlrVSmRST_vp3WJSnQTC0jGFtzEiqgk82DkXMTd-Izs90jOPj8jNkegQq9noQlCIV49AJCQoT1ENKWUZsu85kDZN4uV-SYXPJ4ZZb9uzQkvg8JBbDR-psi4RyQ2_YEl8zt8QKoGngk4cdKtRHUbbsbrv-s_GqEDsWWobsHoF9fgobopagYL3w1lD',
      subCategories: ['Math', 'Science', 'English', 'Music'],
    ),
    ServiceCategory(
      id: 'painter',
      name: 'Painter',
      icon: Icons.format_paint_outlined,
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBq8ttMBo3f4nHdIXPCVuIkMiaoxFjnAjqp14gn_Pghi1AqP9Ne-jBrshhlejF1FaR4nbS_7Mzloypz1ywS2UJhpWYeKLuBoWPC7qL8waSlNCp6YdFWIJS0vHtZ131fcVV70FwdRsCNF0dKjlSV9orVBGUbKi2cE_C_nM0vNYMJKgf3vSik9kYtBJy-H6HOqlWVP1DJBVqdsI7rBjm6Llz2Q7w7xsjdveT7epvSJGqHbJZ7px8xr0vx',
      subCategories: ['Interior Painting', 'Exterior Painting', 'Waterproofing'],
    ),
    ServiceCategory(
      id: 'carpenter',
      name: 'Carpenter',
      icon: Icons.carpenter_outlined,
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCkxI6felS8W-6gN1zeHjr-28CfJp9XLaRmorhn2lTc3q2l5vttTq3PosBwrPij4Az2Kw4z_fu0ME-_pbHynsz2-M0XyMPso-PdC9pPsOl6kCm--U7JKcjlmkLBWINcohv6YFAbDUdEdoFF_EpJ4fzSpTbFiCIJ-zn9Ow-vJSmkpxnOM4C13ZRszCtWV7UPrYr8MUnTqNUl77sidi7UDXeEItxO6K6jshqJjfJwdGmz6ohg0ATtebAC',
      subCategories: ['Furniture Repair', 'Custom Furniture', 'Door & Window'],
    ),
    ServiceCategory(
      id: 'catering',
      name: 'Catering',
      icon: Icons.restaurant_outlined,
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCV-y_rnLL_jfc4BoZqDKE1QdApSEANilCHGQBpeFPDnyUerGcEGUbOmNWdEBMmVdGxkmGHqQI1p9L25wYreETqLuO37kZB-iapARo5dScEBsW3f6vHnHEmuF3Bx-3vKUNDGCFn4HslKcKCd9dZ_0FroDkP7mNFX-A-Cf_PeDqCDxCO1k6AtAioLmmHJEdDCqiuxZjX_T8AusU2_FCjXMn-FKxmBujpMA9jXn_uWfssKoP-rVOaLS63',
      subCategories: ['Home Party', 'Wedding', 'Corporate Event'],
    ),
    ServiceCategory(
      id: 'decor',
      name: 'Decor',
      icon: Icons.chair_outlined,
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDLIAFd2MBWOUbpoMn-JL82wkZavithbUXDPyK2Vbwv6Pt_uATtyzHT9J5BV4bar-PbEazXddErej3OkHZiQv_TSqPnLPIrszeXbt9N0IVWJb1Ambb5T02vMSi_H1e60mTaCWR5o4b51rzjofBwo-_Rkt-xb1Tyv67vJ_73PTelr7k7NIuxIkhzHbQG4_UUOxpPSPBtcIrv4KcZF1OGNiw2Dsjy5H42fBGrORyM6rz_-qpqIURZhd8R',
      subCategories: ['Home Decor', 'Event Decor', 'Lighting'],
    ),
    ServiceCategory(
      id: 'cleaning',
      name: 'Cleaning',
      icon: Icons.cleaning_services_outlined,
      // The Stitch home screen's 10th tile is "Photos" rather than
      // "Cleaning" (its category set isn't fully consistent across
      // screens); reusing that tile's photo here since it's the closest
      // visual match and every other category already has its own photo.
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCeZQvUUJgZwFBQtNDr2YDf1MVGPg2Kz5-S3DrWD7XP0gzR1_H1YP_u1Ut7CA-tJ6nExBPFVtsL_-LapPXbkgb1OsLt446y8FNprYEB9zy3qIkTaPqSsPh8Fm9g246ivzfA5mOTctbP-D04eYOb6dCB0wUuotdrceTmWd0v8F8ofFTK4Kw3HhvWjEWu2QpyDDKXvcfoz7nObC1PrGUJ3S4KbcsuKVaGeofh1R9hlfh6uIGlV0C5hq_V',
      subCategories: [
        'Deep Cleaning',
        'Sofa Cleaning',
        'Bathroom Cleaning',
        'Kitchen Cleaning',
      ],
    ),
  ];

  static ServiceCategory categoryById(String id) =>
      categories.firstWhere((c) => c.id == id, orElse: () => categories.first);

  static const nearYouBusinesses = <Business>[
    Business(
      id: 'coolbreeze',
      name: 'CoolBreeze AC Repair',
      tagline: 'Residential & Commercial Cooling',
      icon: Icons.ac_unit_outlined,
      accentColor: AppColors.userAccentGreen,
      rating: 4.8,
      reviewCount: 210,
      distanceLabel: '3km away',
      experienceYears: 8,
      startingPrice: '\$49',
      photoUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBa9krfBKg_7Zog-Riw60rZYKKKEnSxkO_xJoyI-rbjXxFYXI2JulwYtTVLhkmmfTJQzQCrl_hNnmPgw5GqN01uzBdSQfp_eA8ZvQZ3dO5QXFUFw_aEaSj66aq2GWD2F_CF2Dm0Ja5q47EdejHlFJhXiE6Cj0PfzKRPETEz3riNJpq1ym2KPcKInYtrH92VJ_hvkiq30837e_9_18-AalAFEbElyF3HtlC6YBC4BSKSew61Dd2xvu0a',
    ),
    Business(
      id: 'proflow',
      name: 'ProFlow Plumbing',
      tagline: 'Fast, Reliable Plumbing',
      icon: Icons.plumbing_outlined,
      accentColor: AppColors.businessAccentBlue,
      rating: 4.9,
      reviewCount: 165,
      distanceLabel: '4.2km away',
      experienceYears: 10,
      startingPrice: '\$40',
      photoUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAIzKhwxpgTV_N9-6sxlZTyIKK2HbKwqfZKmndHBRKNRL17K5v7aO5lzYAP2c7so5Cyj5jWxFhQRQ1_NNYouiQKp24WnhV0Fg_PC_XR9HTAYXFCscekBt-6dA9s3cljAtv4e3WAJIClMrh3QTbl5GffM3PjG9Hs6NktRNYcfL-9ewa9mhUDZ2xA_U_PmMlLHaFrHisuVoFHKezUawGWDH0FyV-lnu3O5jXfVssE-QjCLWDyhGvtmrmR',
    ),
    Business(
      id: 'sparkelectric',
      name: 'Spark Electricals',
      tagline: 'Residential & Industrial Wiring',
      icon: Icons.electrical_services_outlined,
      accentColor: AppColors.tertiary,
      rating: 4.6,
      reviewCount: 98,
      distanceLabel: '5.1km away',
      experienceYears: 6,
      startingPrice: '\$35',
      photoUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuA2VDXwcaDKLqAlsOF_wS8rERZQW2T0e_Cj_uGTAxICTg80pI1QdXBbXPqS0JbIkmD7642yz2PJFELPzBNy8NIxRkRpPn96fK8kcKhsaFyEpvM-w_-WsyfCQN23MTpPZu6KUBhyUjzgL6Mk_59-6jFnDuqalty-pXIORcbCTJx96cpnRb4NxV6VCSMXC3iIfySYwUs5kiY-E1j_164Zzd5RBNQaCcWwlQ7WJZ6ibaZ0d5fK6DcoCogf',
    ),
  ];

  /// Search results for an "AC Repair" query
  /// (design_reference/user_search_results_ac_repair).
  static const searchResults = <Business>[
    Business(
      id: 'coolbreeze_experts',
      name: 'CoolBreeze AC Experts',
      tagline: 'Residential & Commercial Cooling',
      icon: Icons.ac_unit_outlined,
      accentColor: AppColors.userAccentGreen,
      rating: 4.9,
      reviewCount: 231,
      distanceLabel: '2.4 mi',
      experienceYears: 8,
      startingPrice: '\$49',
      photoUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBCN650YOG3uhYdfGBYsaCfkdKyFJR6OgPAcQXTzwa4ZOboCeOnx0mXXhyY68vOlozyGPDqs5fDslPS5BpArEqW8FN3pU8ow4VuWEmjpHcRVvlCrQ6x3d2um2eNP4lxiVq4W_qnlcTpoFSmZ220c2QDw-203JEivuUHUrhj4XAUncucUp3dIVbb4mrbH8UaQIu2OaNCIk2L-NH3BOLwwPn3H06DJ08_zwy_CSDO5vzaH1MYqRLIBBtx',
    ),
    Business(
      id: 'arctic_air',
      name: 'Arctic Air Solutions',
      tagline: 'Emergency Repair Services',
      icon: Icons.ac_unit_outlined,
      accentColor: AppColors.businessAccentBlue,
      rating: 4.7,
      reviewCount: 154,
      distanceLabel: '3.8 mi',
      experienceYears: 12,
      startingPrice: '\$65',
      photoUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAwz-Jisp8ODxKl_giv4-o0NH5rE2dh3wgneEM1J9kE0xhwQNB3JvI03W_mrzZm43lsFB044CMdzk9_60N8Ss6mYlq22gHfcXgj35Xes2mrD6HfL_MduBsOxxWxjw7UueuZvi45xbwCbc_Onr0j-g3t0we6VZTHl3m9X3dzUEOYtDcV-88-rHVbzI9mh8AKTh8c3cQbLyr9Njnmm-FJLt0mVKg-T2HftZX6RNysYelK65aiDZ4S8cGo',
    ),
    Business(
      id: 'rapid_frost',
      name: 'Rapid Frost HVAC',
      tagline: 'Maintenance & Install',
      icon: Icons.hvac_outlined,
      accentColor: AppColors.tertiary,
      rating: 4.5,
      reviewCount: 76,
      distanceLabel: '5.1 mi',
      experienceYears: 3,
      startingPrice: '\$45',
      // The Stitch export leaves this one without a photo (icon fallback
      // shown behind the broken `<img>` even in the source HTML).
    ),
  ];

  /// design_reference/business_profile_page ("Elite AC Services").
  static const eliteAcServices = Business(
    id: 'elite_ac',
    name: 'Elite AC Services',
    tagline: 'Koramangala, 2.4 km away',
    icon: Icons.ac_unit_outlined,
    accentColor: AppColors.userAccentGreen,
    rating: 4.8,
    reviewCount: 124,
    distanceLabel: 'Koramangala, 2.4 km away',
    about:
        'Premium air conditioning installation, repair, and maintenance '
        'services. We specialize in split, window, and central AC systems '
        'with a focus on energy efficiency and rapid response times. Our '
        'certified technicians ensure your comfort all year round.',
    hours: 'Mon-Sat: 9:00 AM - 8:00 PM',
    photoUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuA19kNwYDytzvvUrs91TW8MNJLQD6jBi0odBkFjtz29f0pngpNX6-DGyIFhmZPYnerAXyD-PbJU1yyaMM3Tizodxtp5DVhOVdOSQs5kC-YT9yWTi_D1mYzxHVIKs2awd332Z5WAJEGS3TxXlmNhM8PJTzEMkBvaik0JCcVNkAhNykpEg-g3fOu17mmWdZZAe8MaqcPJ0EQT24MAlFdPRtgDC-SF78I70guRBhr4TZbGuDubhVV9efQ4',
    portfolioUrls: [
      'https://lh3.googleusercontent.com/aida-public/AB6AXuBPhVRUB8xf9HIGHaktd3sEIUVi8FuvmzAGvcHjFioAYmzaVblMRtw4uOApmbXUzurn0mvhzZS_ThpDoUMGcjum-3wxaYGVZK1vrODFJ0DMFRwqEfZigQ_lr26oAQczzCI4ha7IGOAR4XdpU7Ypwu0AS4W-MPso6ntJ4FpFKOuptJGVzNNvHdFSY3uQcFxXVzVvsjW-2B8PiY-r-ZpWsoDI6-VORqCNWDpx2i5IuFjQpTKBIDxTQJyW',
      'https://lh3.googleusercontent.com/aida-public/AB6AXuB0QtHKAKMdfVIls6CcTko-lfey_KlD-_2ajw4ciLo2G5zc7IHYYMFzum87qz6gS9-UorMxSGlogKLGyn3I2K47FEKi63pmzrS1Q4CRCMubdDy1_I_4hGxqu_hLn3n_y1Y58hXZvEsJNp72uYLjrQdfolTt40eU_R4eANFaPx3raC3rcU3UuVpPNQEFwdDcSISc4xAW1RmExVrhFVMsYwz3L0qjh77ro6zDXQkwbLgOW5oKAf2hnb5F',
      'https://lh3.googleusercontent.com/aida-public/AB6AXuACL_4McCksfM5hi0vU_2ibv520efEhZsfQiP_wkp5PhqCViLZv2pBLXs8wEh0lau-0jP3gMbHYtiQM1bjPui5xRTncO3JMp-Ni1Jp7TOTjpXSvhfRtypissdPZG0_kiOK-CskbNSUQxEkGOsL_uWt5KqxF2ZHheXZVePvLCf15iOW3CWOgMCwXxCXZyNEY0kERcsZfJUfLqFOe9oIbVv8XvOJj5HvCS3u7Y8db5tsUhmtBoaP0xju9',
    ],
    services: [
      BusinessService(
          name: 'Deep Cleaning', priceLabel: 'From ₹599', icon: Icons.ac_unit_outlined),
      BusinessService(
          name: 'Repair & Fix', priceLabel: 'From ₹349', icon: Icons.build_outlined),
      BusinessService(
          name: 'Installation',
          priceLabel: 'From ₹1299',
          icon: Icons.home_work_outlined),
      BusinessService(
          name: 'Gas Refill', priceLabel: 'From ₹1500', icon: Icons.speed_outlined),
    ],
  );

  /// design_reference/user_quotes_requests_hub +
  /// design_reference/available_quotes_refined_view +
  /// design_reference/user_quote_comparison_refined.
  static final quoteRequests = <QuoteRequest>[
    QuoteRequest(
      id: 'req_ac',
      title: 'AC Repair & Service',
      icon: Icons.ac_unit_outlined,
      locationLabel: 'HSR Layout, Sector 2',
      requestedLabel: 'Requested yesterday',
      status: QuoteRequestStatus.active,
      description:
          'The AC is not cooling properly. It turns on, but only blows warm '
          'air. There might be a gas leak or compressor issue.',
      quotes: const [
        Quote(
          id: 'q1',
          providerName: 'CoolAir Experts',
          rating: 4.9,
          reviewCount: 120,
          price: 850,
          isFixedPrice: true,
          message:
              'Hi there! I can fix this leak permanently using high-grade '
              'PVC sealant. I have the parts in my van.',
          availability: 'Can arrive in 45 mins',
          badge: 'Top Rated',
          avatarUrl:
              'https://lh3.googleusercontent.com/aida-public/AB6AXuCxgwKtksIjwI6gXBqj8PPy8nXw7Lm--W1MUA2tepy25Jni8F6aMNOiSKMm5UwclVwArtB48RWYkX-YSh_pvDK2psgEV7n4bQmGc1TIim9PpTPMW1l5yO9SmuOph5lWmRkWJblweNdWRlPaEqkpE7jIj86hI_sTSji8sMJy65CJQUdN657REjOELmcv-DiXhYsMognvMxGJh-7MC_DDM8hFWDKFdgAFgvvEcqSGr4pLIOOHBna_RUBu',
          highlights: [
            'Includes gas check & filter cleaning',
            'Can arrive in 45 mins',
            '90-day service warranty',
          ],
        ),
        Quote(
          id: 'q2',
          providerName: 'FixIt Now Services',
          rating: 4.5,
          reviewCount: 45,
          price: 700,
          isFixedPrice: false,
          message:
              'We offer a baseline inspection rate. Final price depends on '
              'damage severity.',
          availability: 'Available tomorrow morning',
          // No photo in the Stitch export for this one either — it uses a
          // plain "F" initial avatar there too.
          highlights: ['Basic service only', 'Available tomorrow morning'],
        ),
        Quote(
          id: 'q3',
          providerName: 'Ramesh Handyman',
          rating: 5.0,
          reviewCount: 312,
          price: 950,
          isFixedPrice: true,
          message:
              'Premium service with 6-month warranty on the repair. I carry '
              'all heavy-duty equipment.',
          availability: 'Can start tomorrow, 9:00 AM',
          badge: 'Most Reliable',
          avatarUrl:
              'https://lh3.googleusercontent.com/aida-public/AB6AXuBUfyyLzU56jrivxGSFtNE3Rye358LjeQ-Cu5xJiqfHNHjbA7pgRe6U75vHiOU678dxsBBHsnCnLWsm3igdrNbMeFP08F9kQ5M7bpPGJU5Fsgiy4XppZ-1vt0vUrOpGZDQFXMq8prX9zJ40Lov_5Py93Zo1JRkXwGq4slGgcFLjnLIkBwg6oBIZQ-uu26gWDCqFgOnqvD-g9EKaZmrmzRrKBZ5vxFSuw4gAumAaT8eLpSTH3P8FzZE2',
          highlights: [
            'Premium service, 6-month warranty',
            'Heavy-duty equipment included',
          ],
        ),
      ],
    ),
    QuoteRequest(
      id: 'req_cleaning',
      title: 'Deep House Cleaning',
      icon: Icons.cleaning_services_outlined,
      locationLabel: 'Koramangala',
      requestedLabel: 'Requested 2 hours ago',
      status: QuoteRequestStatus.active,
      quotes: const [],
    ),
    QuoteRequest(
      id: 'req_lawn',
      title: 'Lawn Mowing & Trimming',
      icon: Icons.yard_outlined,
      locationLabel: 'Indiranagar',
      requestedLabel: 'Requested 2 days ago',
      status: QuoteRequestStatus.active,
      quotes: const [
        Quote(
          id: 'q4',
          providerName: 'GreenScape Lawns',
          rating: 4.6,
          reviewCount: 58,
          price: 400,
          isFixedPrice: true,
          message: 'Weekly maintenance package available.',
          availability: 'Available this weekend',
          highlights: ['Mowing, trimming & cleanup'],
        ),
      ],
    ),
    QuoteRequest(
      id: 'req_electrical',
      title: 'Electrical Panel Upgrade',
      icon: Icons.bolt_outlined,
      locationLabel: 'Whitefield',
      requestedLabel: 'Requested Oct 10, 2023',
      status: QuoteRequestStatus.completed,
      hiredProvider: 'Volt Pros',
      outcomeLabel: 'Completed Oct 15, 2023',
    ),
    QuoteRequest(
      id: 'req_painting',
      title: 'Interior Painting - Living Room',
      icon: Icons.format_paint_outlined,
      locationLabel: 'Jayanagar',
      requestedLabel: 'Requested Aug 28, 2023',
      status: QuoteRequestStatus.canceled,
      outcomeLabel: 'Canceled Sep 02, 2023',
    ),
  ];

  static Business businessById(String id) {
    for (final b in [eliteAcServices, ...nearYouBusinesses, ...searchResults]) {
      if (b.id == id) return b;
    }
    return eliteAcServices;
  }

  static QuoteRequest requestById(String id) =>
      quoteRequests.firstWhere((r) => r.id == id, orElse: () => quoteRequests.first);

  static List<QuoteRequest> get activeRequests => quoteRequests
      .where((r) => r.status == QuoteRequestStatus.active)
      .toList();

  static List<QuoteRequest> get pastRequests => quoteRequests
      .where((r) => r.status != QuoteRequestStatus.active)
      .toList();
}

/// design_reference/user_app_minimal_splash_screen,
/// user_login_minimalist_redesign, user_otp_verification_minimalist_redesign,
/// user_app_immersive_landing_page all share this one logo image.
/// design_reference/user_profile_referral ("Jane Doe").
const kUserAvatarUrl =
    'https://lh3.googleusercontent.com/aida-public/AB6AXuANCKSoxptjOTUNQW4Eu6emu5jSHVjcjCthtryG-wpViDCU6Nj0FTUZRnkBc8TMGvYEVQZr5yKkIKwCnTTXYwJa2VzKfL_rTaNcO_-oT8EEdCBXPzGYuVUvH608RsIBiyHMiMmQW7uittyOm4Ym1LF3I7UJut46dqZu4G_urwmrEFYhLM6cM5zCjx8XQIW5LXPplWXdz3FtJrsyq1h1LKfomA1s6PKcBcboXMONB6VqtqDrUJidT2_5';

const kInfioLogoUrl =
    'https://lh3.googleusercontent.com/aida/AEtjO1UrG-56jzOHnblj1J9BTr7N4BEYCi4ogMRes2eiCXAaENM9gUg0c2m7ojoDHqYuQM3MK3vg8ciKNRN_pNM4-CXxbix84VfgOGChqeyolOSlCdYJdV7VNbzjJ5mpJvw6m76JukrO5NAipdQD7yN21VCvzjlZ7Obev4VOrsdvjadX2HTaOxz5J99HAgFMWw_YPya-7XBNQ3zMdQwF1ivt7XeYKggQsLApQI_4fRWnPUj85CNUYYv7K9v_4g';

/// Hero carousel banner shown on Home
/// (design_reference/user_home_integrated_quick_quote_section).
class HomeBanner {
  const HomeBanner({
    required this.title,
    required this.subtitle,
    required this.ctaLabel,
    required this.icon,
    required this.gradientColors,
    this.imageUrl,
  });

  final String title;
  final String subtitle;
  final String ctaLabel;
  final IconData icon;
  final List<Color> gradientColors;

  /// Background photo; the gradient is layered on top as a scrim (matching
  /// the Stitch export's `bg-gradient-to-r ... via-X/40 to-transparent`)
  /// rather than being replaced by it, so the text stays legible.
  final String? imageUrl;
}

const homeBanners = <HomeBanner>[
  HomeBanner(
    title: 'Your Home, Happy & Handled',
    subtitle: 'Get 3 Quotes in 15 min. Effortless services at your fingertips.',
    ctaLabel: 'Request Now',
    icon: Icons.home_work_outlined,
    gradientColors: [Color(0xFF151C27), Color(0xFF8A19D8)],
    imageUrl:
        'https://lh3.googleusercontent.com/aida/AEtjO1X37HqLR4o9r22BygYLPfiFpTesZIpOb8MFWZMST4gXWH0gin8Oym1zVCVHJ3IWpXC9dHtSFAnz33_tWyjmP7e8BLY_z9dTGYfoJCk_4fiCWkQS0SPlhqesFx5trCbXCHlpGDpgZ3r7RzSYjoSXLw8CWvWBT_8e45giT5lTDd6wiTBFHE9LKaAZRyySJv8syKeUkMMOWDiD9Zq0dI4zukNEBnPmqWYtEUjvCP2kZMz9mNDjS4XIUEon9Oc',
  ),
  HomeBanner(
    title: 'AC Service Special',
    subtitle: 'Flat 20% off on all AC servicing and repairs this month.',
    ctaLabel: 'Book Now',
    icon: Icons.ac_unit_outlined,
    gradientColors: [Color(0xFFA540F3), Color(0xFF8A19D8)],
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuCrHji8pZX6CW1t4BjrHnn45KVdqVjW1_RvPm2XUTKAS9-nf9d-p_YugkkJ69yvCd4vax6fTwXQmfyZ-rUqOa8qrmI0RDRz1CJ3VoUlYARizzGcCisivpjvoH4B_FhTpBSKIZ69DPIFA9RBKyJznzDkkUHYmzaOHXgDkKz0aEufVQ3FmGfUdj3Julmywe88DgltCr3mI1d_UYbkY4hcYONnmMjBRDmlb4eLoWiKLTU0jG2CkxUkPEVb',
  ),
  HomeBanner(
    title: 'Cleaning Deals',
    subtitle: 'Deep cleaning packages starting at just \$49.',
    ctaLabel: 'View Deals',
    icon: Icons.cleaning_services_outlined,
    gradientColors: [Color(0xFF835400), Color(0xFFA46A00)],
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuD37ZYAPHED0h8Wq2_9Ec7hyZvL6sddI6TDNJLrHPD_MdW6E4kLe6Bh5bYbKqYxfLVSTk13NuNgFAHqu9KNEuhP34tqVGisp0TedAfw9aRl0eXKLPjOEIBSV2FBvGtMX5eXx8JFceguSZkj4m-nGZZ-hrNduCfMfyoMOlGn_ARQtw9Y4iMNneD-o-KGYHkIJUVDeVzSBJ8LVIigCqtUMmSaavE43ikRXv970mnE6unBR87h56XQPD_r',
  ),
];
