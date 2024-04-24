import 'package:get/get.dart';

import '../modules/Thrift/bindings/thrift_binding.dart';
import '../modules/Thrift/views/thrift_view.dart';
import '../modules/addproduct/bindings/addproduct_binding.dart';
import '../modules/addproduct/views/addproduct_view.dart';
import '../modules/admin_categories/bindings/admin_categories_binding.dart';
import '../modules/admin_categories/views/admin_categories_view.dart';
import '../modules/admin_dashboard/bindings/admin_dashboard_binding.dart';
import '../modules/admin_dashboard/views/admin_dashboard_view.dart';
import '../modules/admin_main/bindings/admin_main_binding.dart';
import '../modules/admin_main/views/admin_main_view.dart';
import '../modules/admin_orders/bindings/admin_orders_binding.dart';
import '../modules/admin_orders/views/admin_orders_view.dart';
import '../modules/admin_products/bindings/admin_products_binding.dart';
import '../modules/admin_products/views/admin_products_view.dart';
import '../modules/admin_profile/bindings/admin_profile_binding.dart';
import '../modules/admin_profile/views/admin_profile_view.dart';
import '../modules/admin_users/bindings/admin_users_binding.dart';
import '../modules/admin_users/views/admin_users_view.dart';
import '../modules/cart/bindings/cart_binding.dart';
import '../modules/cart/views/cart_view.dart';
import '../modules/detail_category/bindings/detail_category_binding.dart';
import '../modules/detail_category/views/detail_category_view.dart';
import '../modules/detail_thrift_category/bindings/detail_thrift_category_binding.dart';
import '../modules/detail_thrift_category/views/detail_thrift_category_view.dart';
import '../modules/detailed_product/bindings/detailed_product_binding.dart';
import '../modules/detailed_product/views/detailed_product_view.dart';
import '../modules/detailedthriftproduct/bindings/detailedthriftproduct_binding.dart';
import '../modules/detailedthriftproduct/views/detailedthriftproduct_view.dart';
import '../modules/editprofile/bindings/editprofile_binding.dart';
import '../modules/editprofile/views/editprofile_view.dart';
import '../modules/favourites/bindings/favourites_binding.dart';
import '../modules/favourites/views/favourites_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/main/bindings/main_binding.dart';
import '../modules/main/views/main_view.dart';
import '../modules/newcategory/bindings/newcategory_binding.dart';
import '../modules/newcategory/views/newcategory_view.dart';
import '../modules/newproduct/bindings/newproduct_binding.dart';
import '../modules/newproduct/views/newproduct_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/order/bindings/order_binding.dart';
import '../modules/order/views/order_view.dart';
import '../modules/order_details/bindings/order_details_binding.dart';
import '../modules/order_details/views/order_details_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/thriftcategory/bindings/thriftcategory_binding.dart';
import '../modules/thriftcategory/views/thriftcategory_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const LOGIN = Routes.LOGIN;
  static const HOME = Routes.MAIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => const CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.ORDER,
      page: () => const OrderView(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () => const MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_MAIN,
      page: () => const AdminMainView(),
      binding: AdminMainBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_DASHBOARD,
      page: () => const AdminDashboardView(),
      binding: AdminDashboardBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_PRODUCTS,
      page: () => const AdminProductsView(),
      binding: AdminProductsBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_CATEGORIES,
      page: () => const AdminCategoriesView(),
      binding: AdminCategoriesBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_ORDERS,
      page: () => const AdminOrdersView(),
      binding: AdminOrdersBinding(),
    ),
    GetPage(
      name: _Paths.DETAILED_PRODUCT,
      page: () => const DetailedProductView(),
      binding: DetailedProductBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_USERS,
      page: () => const AdminUsersView(),
      binding: AdminUsersBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_CATEGORY,
      page: () => const DetailCategoryView(),
      binding: DetailCategoryBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.THRIFT,
      page: () => const ThriftView(),
      binding: ThriftBinding(),
    ),
    GetPage(
      name: _Paths.ADDPRODUCT,
      page: () => const AddproductView(),
      binding: AddproductBinding(),
    ),
    GetPage(
      name: _Paths.NEWCATEGORY,
      page: () => const NewcategoryView(),
      binding: NewcategoryBinding(),
    ),
    GetPage(
      name: _Paths.EDITPROFILE,
      page: () => const EditprofileView(),
      binding: EditprofileBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_DETAILS,
      page: () => const OrderDetailsView(),
      binding: OrderDetailsBinding(),
    ),
    GetPage(
      name: _Paths.NEWPRODUCT,
      page: () => const NewproductView(),
      binding: NewproductBinding(),
    ),
    GetPage(
      name: _Paths.DETAILEDTHRIFTPRODUCT,
      page: () => const DetailedthriftproductView(),
      binding: DetailedthriftproductBinding(),
    ),
    GetPage(
      name: _Paths.FAVOURITES,
      page: () => const FavouritesView(),
      binding: FavouritesBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_PROFILE,
      page: () => const AdminProfileView(),
      binding: AdminProfileBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_THRIFT_CATEGORY,
      page: () => const DetailThriftCategoryView(),
      binding: DetailThriftCategoryBinding(),
    ),
    GetPage(
      name: _Paths.THRIFTCATEGORY,
      page: () => const ThriftcategoryView(),
      binding: ThriftcategoryBinding(),
    ),
  ];
}
