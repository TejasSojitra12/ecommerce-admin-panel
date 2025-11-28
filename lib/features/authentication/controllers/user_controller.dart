//
// import 'package:e_commerce_admin_pannel/data/repositories/user/user_repository.dart';
// import 'package:e_commerce_admin_pannel/features/authentication/models/user/user_model.dart';
// import 'package:e_commerce_admin_pannel/utils/popups/loaders.dart';
// import 'package:get/get.dart';
//
// class UserController extends GetxController{
//   static UserController get instance => Get.find();
//
//   RxBool isLoading = false.obs;
//   Rx<UserModel> user = UserModel.empty().obs;
//   final userRepository = Get.put(UserRepository());
//
//   @override
//   void onInit() {
//     fetchUserDetails();
//     super.onInit();
//   }
//
//   /// Fetch user detail from repository
// Future<UserModel> fetchUserDetails()async{
//   try{
//     isLoading.value=true;
//     final user = await userRepository.fetchAdminDetails();
//     this.user.value=user;
//     isLoading.value=false;
//     return user;
//   }catch(e){
//     isLoading.value=false;
//     TLoaders.errorSnackBar(title: 'Something went wrong.',message: e.toString());
//     return UserModel.empty();
//   }
// }
// }