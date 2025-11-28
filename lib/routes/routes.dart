
class TRoutes{
  static const login = '/login';
  static const forgetPassword = '/forgetPassword';
  static const resetPassword = '/resetPassword';
  static const dashboard = '/dashboard';
  static const media = '/media';

  static const banners = '/banners';
  static const createBanner = '/createBanner';
  static const editBanner = '/editBanner';

  static const products = '/products';
  static const createProduct = '/createProduct';
  static const editProduct = '/editProduct';

  static const categories = '/categories';
  static const createCategory = '/createCategory';
  static const editCategory = '/editCategory';

  static const brands = '/brands';
  static const createBrand = '/createBrand';
  static const editBrand = '/editBrand';

  static const customers = '/customers';
  static const createCustomer = '/createCustomer';
  static const customerDetails = '/customerDetails';

  static const orders = '/order';
  static const ordersDetails = '/orderDetails';
  static const createOrder = '/createOrder';
  static const editOrder = '/editOrder';

  static const home = '/';
  static const secondScreen = '/second-screen';
  static const secondScreenUid = '/second-screen/:userId';
  static const responsiveDesignScreen = '/responsiveDesignScreen';

  static const settings = '/settings';
  static const profile = '/profile';

  static List sidebarMenuItems=[
    dashboard,media,categories,brands,banners,products,customers,orders,settings,profile
  ];

}