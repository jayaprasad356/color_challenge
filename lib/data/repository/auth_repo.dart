// import 'package:ats_customar_app/util/index_path.dart';
//
// class AuthRepo {
//   final ApiClient apiClient;
//   final FlutterSecureStorage storageLocal;
//
//   AuthRepo({required this.apiClient, required this.storageLocal});
//
//   Future<Response> login(String email, String password) async {
//     return await apiClient.postData(
//       AppConstants.LOGIN_URI,
//       {
//         "email": email,
//         "password": password,
//       },
//     );
//   }
//
//   Future<Response> createUserProvider(
//     String userName,
//     String email,
//     String password,
//     String mobileNumber,
//     String driverLicence,
//     String truckPlate,
//   ) async {
//     return await apiClient.postData(
//       AppConstants.CREATE_USER_URI,
//       {
//         'userName': userName,
//         'email': email,
//         'password': password,
//         'mobileNumber': mobileNumber,
//         'driverLicence': driverLicence,
//         'truckPlate': truckPlate,
//         'roles': ["technician"],
//         'status': "ACTIVE",
//       },
//     );
//   }
//
//   // Future<Response> createUserProviderPut(String userName, String email, String password, String mobileNumber, String driverLicence, String truckPlate,) async {
//   //   return await apiClient.putData(AppConstants.CREATE_USER_URI,
//   //     {
//   //       'userName': userName,
//   //       'email': email,
//   //       'password': password,
//   //       'mobileNumber': mobileNumber,
//   //       'driverLicence': driverLicence,
//   //       'truckPlate': truckPlate,
//   //       'roles': ["technician"],
//   //       'status': "ACTIVE",
//   //     },
//   //   );
//   // }
//
//   // Future<Response> getProfileInfo() async {
//   //   return await apiClient.getData(AppConstants.PROFILE_URI + getUserToken());
//   // }
//
//   // Future<Response> recordLocation(RecordLocationBody recordLocationBody) {
//   //   recordLocationBody.token = getUserToken();
//   //   return apiClient.postData(AppConstants.RECORD_LOCATION_URI, recordLocationBody.toJson());
//   // }
//
//   // Future<Response> updateProfile(ProfileModel userInfoModel, XFile data, String token) async {
//   //   Map<String, String> _fields = Map();
//   //   _fields.addAll(<String, String>{
//   //     '_method': 'put', 'f_name': userInfoModel.fName, 'l_name': userInfoModel.lName,
//   //     'email': userInfoModel.email, 'token': getUserToken()
//   //   });
//   //   return await apiClient.postMultipartData(AppConstants.UPDATE_PROFILE_URI, _fields, [MultipartBody('image', data)]);
//   // }
//
//   // Future<Response> adddriverdoc(String dname, XFile data, String token) async {
//   //   Map<String, String> _fields = Map();
//   //   _fields.addAll(<String, String>{
//   //     '_method': 'post', 'name': dname,'token': getUserToken()
//   //   });
//   //   return await apiClient.postMultipartData(AppConstants.ADD_DRIVER_DOC, _fields, [MultipartBody('image', data)]);
//   // }
//
//   // Future<Response> adddriverpmt(String wmethod, String email, String cardno, String token) async {
//   //   Map<String, String> _fields = Map();
//   //   _fields.addAll(<String, String>{
//   //     '_method': 'post', 'wmethod': wmethod, 'email': email, 'cardno': cardno, 'token': getUserToken()
//   //   });
//   //   return await apiClient.postData(AppConstants.ADD_DRIVER_PMT, _fields);
//   // }
//
//   // Future<Response> changePassword(ProfileModel userInfoModel, String password) async {
//   //   return await apiClient.postData(AppConstants.UPDATE_PROFILE_URI, {'_method': 'put', 'f_name': userInfoModel.fName,
//   //     'l_name': userInfoModel.lName, 'email': userInfoModel.email, 'password': password, 'token': getUserToken()});
//   // }
//
//   // Future<Response> updateActiveStatus() async {
//   //   return await apiClient.postData(AppConstants.ACTIVE_STATUS_URI, {'token': getUserToken()});
//   // }
//
//   // Future<Response> updateToken() async {
//   //   String _deviceToken;
//   //   if (GetPlatform.isIOS) {
//   //     print("is ios platform ${GetPlatform.isIOS}");
//   //     FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
//   //     NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
//   //       alert: true, announcement: false, badge: true, carPlay: false,
//   //       criticalAlert: false, provisional: false, sound: true,
//   //     );
//   //     if(settings.authorizationStatus == AuthorizationStatus.authorized) {
//   //       _deviceToken = await _saveDeviceToken();
//   //     }
//   //   }else if(GetPlatform.isAndroid){
//   //     print("is android platform ${GetPlatform.isAndroid}");
//   //     FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
//   //     NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
//   //       alert: true, announcement: false, badge: true, carPlay: false,
//   //       criticalAlert: false, provisional: false, sound: true,
//   //     );
//   //     if(settings.authorizationStatus == AuthorizationStatus.authorized) {
//   //       _deviceToken = await _saveDeviceToken();
//   //     }
//   //   }
//   //   else {
//   //     _deviceToken = await _saveDeviceToken();
//   //   }
//   //   if(!GetPlatform.isWeb) {
//   //     FirebaseMessaging.instance.subscribeToTopic(AppConstants.TOPIC);
//   //     FirebaseMessaging.instance.subscribeToTopic(sharedPreferences.getString(AppConstants.ZONE_TOPIC));
//   //   }
//   //   return await apiClient.postData(AppConstants.TOKEN_URI, {"_method": "put", "token": getUserToken(), "fcm_token": _deviceToken});
//   // }
//
//   // Future<String> _saveDeviceToken() async {
//   //   String _deviceToken = '';
//   //   if(!GetPlatform.isWeb) {
//   //     _deviceToken = await FirebaseMessaging.instance.getToken();
//   //     print("_deviceToken $_deviceToken");
//   //   }
//   //   if (_deviceToken != null) {
//   //     print('--------Device Token---------- '+_deviceToken);
//   //   }
//   //   return _deviceToken;
//   // }
//
//   // Future<Response> forgetPassword(String phone) async {
//   //   return await apiClient.postData(AppConstants.FORGET_PASSWORD_URI, {"phone": phone});
//   // }
//
//   // Future<Response> verifyToken(String phone, String token) async {
//   //   return await apiClient.postData(AppConstants.VERIFY_TOKEN_URI, {"phone": phone, "reset_token": token});
//   // }
//
//   // Future<Response> resetPassword(String resetToken, String phone, String password, String confirmPassword) async {
//   //   return await apiClient.postData(
//   //     AppConstants.RESET_PASSWORD_URI,
//   //     {"_method": "put", "phone": phone, "reset_token": resetToken, "password": password, "confirm_password": confirmPassword},
//   //   );
//   // }
//
//   // Future<bool> saveUserToken(String token, String zoneTopic) async {
//   //   apiClient.token = token;
//   //   apiClient.updateHeader(token, sharedPreferences.getString(AppConstants.LANGUAGE_CODE));
//   //   sharedPreferences.setString(AppConstants.ZONE_TOPIC, zoneTopic);
//   //   return await sharedPreferences.setString(AppConstants.TOKEN, token);
//   // }
//
//   // String getUserToken() {
//   //   return sharedPreferences.getString(AppConstants.TOKEN) ?? "";
//   // }
//
//   // bool isLoggedIn() {
//   //   return sharedPreferences.containsKey(AppConstants.TOKEN);
//   // }
//
//   // Future<bool> clearSharedData() async {
//   //   if(!GetPlatform.isWeb) {
//   //     await FirebaseMessaging.instance.unsubscribeFromTopic(AppConstants.TOPIC);
//   //     FirebaseMessaging.instance.unsubscribeFromTopic(sharedPreferences.getString(AppConstants.ZONE_TOPIC));
//   //     apiClient.postData(AppConstants.TOKEN_URI, {"_method": "put", "token": getUserToken(), "fcm_token": '@'});
//   //   }
//   //   await sharedPreferences.remove(AppConstants.TOKEN);
//   //   await sharedPreferences.setStringList(AppConstants.IGNORE_LIST, []);
//   //   await sharedPreferences.remove(AppConstants.USER_ADDRESS);
//   //   apiClient.updateHeader(null, null);
//   //   return true;
//   // }
//
//   // Future<void> saveUserEmailAndPassword(String email, String password, String countryCode) async {
//   //   try {
//   //     await flutterSecureStorage.write(key: AppConstants.USER_PASSWORD, value: password);
//   //     await flutterSecureStorage.write(key: AppConstants.USER_EMAIL, value: email);
//   //     await flutterSecureStorage.write(key: AppConstants.USER_COUNTRY_CODE, value: countryCode);
//   //   } catch (e) {
//   //     throw e;
//   //   }
//   // }
//
//   // Future<String> getUserEmail() async {
//   //   final userEmail = await flutterSecureStorage.read(key: AppConstants.USER_EMAIL);
//   //   return userEmail ?? "";
//   // }
//
//   // String getUserCountryCode() {
//   //   return sharedPreferences.getString(AppConstants.USER_COUNTRY_CODE) ?? "";
//   // }
//
//   // Future<String> getUserPassword() async {
//   //   final userEmail = await flutterSecureStorage.read(key: AppConstants.USER_PASSWORD);
//   //   return userEmail ?? "";
//   // }
//
//   // Future<bool> isNotificationActive() async {
//   //   final notificationValue = await flutterSecureStorage.read(key: AppConstants.NOTIFICATION);
//   //   return notificationValue != null ? notificationValue.toLowerCase() == 'true' : true;
//   // }
//
//   // void setNotificationActive(bool isActive) {
//   //   if(isActive) {
//   //     updateToken();
//   //   }else {
//   //     if(!GetPlatform.isWeb) {
//   //       FirebaseMessaging.instance.unsubscribeFromTopic(AppConstants.TOPIC);
//   //       FirebaseMessaging.instance.unsubscribeFromTopic(sharedPreferences.getString(AppConstants.ZONE_TOPIC));
//   //     }
//   //   }
//   //   sharedPreferences.setBool(AppConstants.NOTIFICATION, isActive);
//   // }
//
//   // Future<bool> clearUserNumberAndPassword() async {
//   //   await sharedPreferences.remove(AppConstants.USER_PASSWORD);
//   //   await sharedPreferences.remove(AppConstants.USER_COUNTRY_CODE);
//   //   return await sharedPreferences.remove(AppConstants.USER_NUMBER);
//   // }
//
//   // Future<Response> deleteDriver() async {
//   //   return await apiClient.deleteData(AppConstants.DRIVER_REMOVE + getUserToken());
//   // }
//
//   // Future<Response> getZoneList() async {
//   //   return await apiClient.getData(AppConstants.ZONE_LIST_URI);
//   // }
//
//   // Future<Response> getZone(String lat, String lng) async {
//   //   return await apiClient.getData('${AppConstants.ZONE_URI}?lat=$lat&lng=$lng');
//   // }
//
//   // Future<bool> saveUserAddress(String address, List<int> zoneIDs) async {
//   //   apiClient.updateHeader(
//   //     sharedPreferences.getString(AppConstants.TOKEN),
//   //     sharedPreferences.getString(AppConstants.LANGUAGE_CODE),
//   //   );
//   //   return await sharedPreferences.setString(AppConstants.USER_ADDRESS, address);
//   // }
//
//   // String getUserAddress() {
//   //   return sharedPreferences.getString(AppConstants.USER_ADDRESS);
//   // }
//
//   // Future<Response> registerDeliveryMan(DeliveryManBody deliveryManBody, List<MultipartBody> multiParts) async {
//   //   return apiClient.postMultipartData(AppConstants.DM_REGISTER_URI, deliveryManBody.toJson(), multiParts);
//   // }
// }
