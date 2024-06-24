import 'package:get/get.dart';

import '../modules/activity/form/bindings/activity_form_binding.dart';
import '../modules/activity/form/views/activity_form_view.dart';
import '../modules/activity/show/bindings/activity_show_binding.dart';
import '../modules/activity/show/views/activity_show_view.dart';
import '../modules/admin/activities/bindings/admin_activities_binding.dart';
import '../modules/admin/activities/views/admin_activities_view.dart';
import '../modules/admin/bike/bindings/admin_bike_binding.dart';
import '../modules/admin/bike/views/admin_bike_view.dart';
import '../modules/admin/bindings/admin_binding.dart';
import '../modules/admin/carousel/bindings/admin_carousel_binding.dart';
import '../modules/admin/carousel/form/bindings/admin_carousel_form_binding.dart';
import '../modules/admin/carousel/form/views/admin_carousel_form_view.dart';
import '../modules/admin/carousel/views/admin_carousel_view.dart';
import '../modules/admin/challenges/bindings/admin_challenges_binding.dart';
import '../modules/admin/challenges/views/admin_challenges_view.dart';
import '../modules/admin/facilities/bindings/admin_facilities_binding.dart';
import '../modules/admin/facilities/views/admin_facilities_view.dart';
import '../modules/admin/products/bindings/admin_products_binding.dart';
import '../modules/admin/products/views/admin_products_view.dart';
import '../modules/admin/views/admin_view.dart';
import '../modules/admin_redemption/bindings/admin_redemption_binding.dart';
import '../modules/admin_redemption/views/admin_redemption_view.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/email_confirmation/bindings/auth_email_confirmation_binding.dart';
import '../modules/auth/email_confirmation/views/auth_email_confirmation_view.dart';
import '../modules/auth/forget_password/bindings/auth_forget_password_binding.dart';
import '../modules/auth/forget_password/views/auth_forget_password_view.dart';
import '../modules/auth/sign_in/bindings/auth_sign_in_binding.dart';
import '../modules/auth/sign_in/views/auth_sign_in_view.dart';
import '../modules/auth/sign_up/bindings/auth_sign_up_binding.dart';
import '../modules/auth/sign_up/views/auth_sign_up_view.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/bike/bindings/bike_binding.dart';
import '../modules/bike/form/bindings/bike_form_binding.dart';
import '../modules/bike/form/views/bike_form_view.dart';
import '../modules/bike/rent/bindings/bike_rent_binding.dart';
import '../modules/bike/rent/views/bike_rent_view.dart';
import '../modules/bike/views/bike_view.dart';
import '../modules/challenges/form/bindings/challenges_form_binding.dart';
import '../modules/challenges/form/views/challenges_form_view.dart';
import '../modules/challenges/index/bindings/challenges_index_binding.dart';
import '../modules/challenges/index/views/challenges_index_view.dart';
import '../modules/challenges/show/bindings/challenges_show_binding.dart';
import '../modules/challenges/show/views/challenges_show_view.dart';
import '../modules/facilities/form/bindings/facilities_form_binding.dart';
import '../modules/facilities/form/views/facilities_form_view.dart';
import '../modules/facilities/map/bindings/facilities_map_binding.dart';
import '../modules/facilities/map/views/facilities_map_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/product/form/bindings/product_form_binding.dart';
import '../modules/product/form/views/product_form_view.dart';
import '../modules/product/show/bindings/product_show_binding.dart';
import '../modules/product/show/views/product_show_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/redemption/show/bindings/redemption_show_binding.dart';
import '../modules/redemption/show/views/redemption_show_view.dart';
import '../modules/rent_verificator/bindings/rent_verificator_binding.dart';
import '../modules/rent_verificator/views/rent_verificator_view.dart';
import '../modules/saveQr/bindings/save_qr_binding.dart';
import '../modules/saveQr/views/save_qr_view.dart';
import '../modules/transactions/bindings/transactions_binding.dart';
import '../modules/transactions/views/transactions_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      transition: Transition.cupertino,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      transition: Transition.cupertino,
      page: () => AuthView(),
      binding: AuthBinding(),
      children: [
        GetPage(
          name: _Paths.SIGN_IN,
          transition: Transition.cupertino,
          page: () => AuthSignInView(),
          binding: AuthSignInBinding(),
        ),
        GetPage(
          name: _Paths.SIGN_UP,
          transition: Transition.cupertino,
          page: () => AuthSignUpView(),
          binding: AuthSignUpBinding(),
        ),
        GetPage(
          name: _Paths.FORGET_PASSWORD,
          transition: Transition.cupertino,
          page: () => AuthForgetPasswordView(),
          binding: AuthForgetPasswordBinding(),
        ),
        GetPage(
          name: _Paths.EMAIL_CONFIRMATION,
          transition: Transition.cupertino,
          page: () => const AuthEmailConfirmationView(),
          binding: AuthEmailConfirmationBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.CHALLENGES,
      transition: Transition.cupertino,
      page: () => const ChallengesIndexView(),
      binding: ChallengesIndexBinding(),
      children: [
        GetPage(
          name: _Paths.INDEX,
          transition: Transition.cupertino,
          page: () => const ChallengesIndexView(),
          binding: ChallengesIndexBinding(),
        ),
        GetPage(
          name: _Paths.SHOW,
          transition: Transition.cupertino,
          page: () => const ChallengesShowView(),
          binding: ChallengesShowBinding(),
          children: [],
        ),
        GetPage(
          name: _Paths.FORM,
          transition: Transition.cupertino,
          page: () => const ChallengesFormView(),
          binding: ChallengesFormBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.ACTIVITY,
      transition: Transition.cupertino,
      page: () => const ActivityFormView(),
      binding: ActivityFormBinding(),
      children: [
        GetPage(
          name: _Paths.FORM,
          transition: Transition.cupertino,
          page: () => const ActivityFormView(),
          binding: ActivityFormBinding(),
        ),
        GetPage(
          name: _Paths.SHOW,
          transition: Transition.cupertino,
          page: () => const ActivityShowView(),
          binding: ActivityShowBinding(),
        ),
      ],
    ),
    GetPage(
        name: _Paths.ADMIN,
        transition: Transition.cupertino,
        page: () => const AdminView(),
        binding: AdminBinding(),
        children: [
          GetPage(
            name: _Paths.CHALLENGES,
            transition: Transition.cupertino,
            page: () => const AdminChallengesView(),
            binding: AdminChallengesBinding(),
          ),
          GetPage(
            name: _Paths.PRODUCTS,
            transition: Transition.cupertino,
            page: () => const AdminProductsView(),
            binding: AdminProductsBinding(),
          ),
          GetPage(
            name: _Paths.ACTIVITIES,
            transition: Transition.cupertino,
            page: () => const AdminActivitiesView(),
            binding: AdminActivitiesBinding(),
          ),
          GetPage(
            name: _Paths.FACILITIES,
            transition: Transition.cupertino,
            page: () => const AdminFacilitiesView(),
            binding: AdminFacilitiesBinding(),
          ),
          GetPage(
            name: _Paths.BIKE,
            transition: Transition.cupertino,
            page: () => const AdminBikeView(),
            binding: AdminBikeBinding(),
            children: [],
          ),
          GetPage(
            name: _Paths.CAROUSEL,
            transition: Transition.cupertino,
            page: () => const AdminCarouselView(),
            binding: AdminCarouselBinding(),
            children: [
              GetPage(
                name: _Paths.FORM,
                transition: Transition.cupertino,
                page: () => const AdminCarouselFormView(),
                binding: AdminCarouselFormBinding(),
              ),
            ],
          ),
        ]),
    GetPage(
      name: _Paths.PROFILE,
      transition: Transition.cupertino,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
        name: _Paths.PRODUCTS,
        transition: Transition.cupertino,
        page: () => const AdminProductsView(),
        binding: AdminProductsBinding(),
        children: [
          GetPage(
            name: _Paths.SHOW,
            transition: Transition.cupertino,
            page: () => const ProductsShowView(),
            binding: ProductsShowBinding(),
          ),
          GetPage(
            name: _Paths.FORM,
            transition: Transition.cupertino,
            page: () => const ProductsFormView(),
            binding: ProductsFormBinding(),
          ),
        ]),
    GetPage(
      name: _Paths.TRANSACTIONS,
      transition: Transition.cupertino,
      page: () => const TransactionsView(),
      binding: TransactionsBinding(),
    ),
    GetPage(
      name: _Paths.REDEMPTION,
      transition: Transition.cupertino,
      page: () => const RedemptionShowView(),
      binding: RedemptionShowBinding(),
      children: [
        GetPage(
          name: _Paths.SHOW,
          transition: Transition.cupertino,
          page: () => const RedemptionShowView(),
          binding: RedemptionShowBinding(),
        ),
      ],
    ),
    GetPage(
        name: _Paths.FACILITIES,
        transition: Transition.cupertino,
        page: () => const AdminFacilitiesView(),
        binding: AdminFacilitiesBinding(),
        children: [
          GetPage(
            name: _Paths.FORM,
            transition: Transition.cupertino,
            page: () => const FacilitiesFormView(),
            binding: FacilitiesFormBinding(),
          ),
          GetPage(
            name: _Paths.MAP,
            transition: Transition.cupertino,
            page: () => FacilitiesMapView(),
            binding: FacilitiesMapBinding(),
          ),
        ]),
    GetPage(
      name: _Paths.BIKE,
      transition: Transition.cupertino,
      page: () => const BikeView(),
      binding: BikeBinding(),
      children: [
        GetPage(
          name: _Paths.FORM,
          transition: Transition.cupertino,
          page: () => const BikeFormView(),
          binding: BikeFormBinding(),
        ),
        GetPage(
          name: _Paths.RENT,
          transition: Transition.cupertino,
          page: () => const BikeRentView(),
          binding: BikeRentBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.SAVE_QR,
      transition: Transition.cupertino,
      page: () => const SaveQrView(),
      binding: SaveQrBinding(),
    ),
    GetPage(
      name: _Paths.RENT_VERIFICATOR,
      page: () => const RentVerificatorView(),
      binding: RentVerificatorBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_REDEMPTION,
      page: () => const AdminRedemptionView(),
      binding: AdminRedemptionBinding(),
    ),
  ];
}
