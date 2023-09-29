
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const FlutterSecureStorage storeLocal = FlutterSecureStorage();

class Constant {
  static const String MainBaseUrl = "https://admin.colorjobs.site/";
  //static const String MainBaseUrl = "http://192.168.35.38/color_challenge_admin/";
  //static const String MainBaseUrl = "https://demo.colorjobs.site/";
  static const String BaseUrl = "${MainBaseUrl}api/";
  static const String LOGIN_URL = "${BaseUrl}login.php";
  static const String USER_DETAIL_URL = "${BaseUrl}user_details.php";
  static const String REGISTER_URL = "${BaseUrl}register.php";
  static const String UPDATE_PROFILE_URL = "${BaseUrl}update_profile.php";
  static const String WITHDRAWAL_URL = "${BaseUrl}withdrawals.php";
  static const String CHECK_MOBILE = "${BaseUrl}check_mobile.php";
  static const String MY_WITHDRAWALS_LIST_URL =
      "${BaseUrl}withdrawals_list.php";
  static const String TRANSACTIONS_LIST_URL = "${BaseUrl}transactions_list.php";
  static const String NOTIFICATION_LIST_URL =
      "${BaseUrl}notification_lists.php";

  static const String SETTINGS_URL = "${BaseUrl}settings.php";
  static const String ADS_URL = "${BaseUrl}ads.php";
  static const String APPUPDATE_URL = "${BaseUrl}appupdate.php";

  static const String TRIAL_ADS_LIST = "${BaseUrl}trial_ads.php";
  static const String UPDATE_BANK_DETAILS = "${BaseUrl}update_bank_details.php";
  static const String ADD_MAIN_BALANCE_URL = "${BaseUrl}add_main_balance.php";
  static const String VIEW_AD_URL = "${BaseUrl}view_ad.php";
  static const String IMAGE_LIST = "${BaseUrl}image_list.php";
  static const String SHORTS_URL = "api/video_list.php";
  static const String SETTINGS_URL_ALL = "api/settings.php";

  static const String SUCCESS = "success";
  static const String MESSAGE = "message";
  static const String MOBILE = "mobile";
  static const String EMAIL = "email";
  static const String START_COINS = "start_coins";
  static const String PRIZE = "prize";
  static const String USER_ID = "user_id";
  static const String AMOUNT = "amount";
  static const String HOLDER_NAME = "holder_name";
  static const String BANK = "bank";
  static const String ACCOUNT_NUM = "account_num";
  static const String BRANCH = "branch";
  static const String BASIC_WALLET = "basic_wallet";
  static const String PREMIUM_WALLET = "premium_wallet";
  static const String TARGET_REFERS = "target_refers";
  static const String TODAY_ADS = "today_ads";
  static const String TOTAL_ADS = "total_ads";
  static const String REFER_BONUS = "refer_bonus";
  static const String TYPE = "type";
  static const String WALLET_TYPE = "wallet_type";
  static const String IFSC = "ifsc";
  static const String RESULT = "result";
  static const String TIME = "time";
  static const String APP_VERSION = "app_version";
  static const String LINK = "link";
  static const String ADS_LINK = "ads_link";
  static const String BET_STATUS = "bet_status";
  static const String FCM_ID = "fcm_id";
  static const String MY_DEVICE_ID = "my_device_id";

  static const String ID = "id";
  static const String LOGED_IN = "loged_in";
  static const String UPI = "upi";
  static const String EARN = "earn";
  static const String COINS = "coins";
  static const String BALANCE = "balance";
  static const String REFERRED_BY = "referred_by";
  static const String REFER_CODE = "refer_code";
  static const String STATUS = "status";
  static const String JOINED_DATE = "joined_date";
  static const String LAST_UPDATED = "last_updated";
  static const String AD_STARTED_TIME = "ad_started_time";

  static const String NAME = "name";
  static const String AGE = "age";
  static const String GENDER = "gender";
  static const String CITY = "city";
  static const String SUPPORT_LAN = "support_lan";
  static const String DEVICE_ID = "device_id";

  static const String RESULT_ANNOUNCE_TIME = "result_announce_time";
  static String handleNullableString(String input) {
    if (input == null) {
      return '';
    } else {
      return input;
    }
  }

  //settings
  static const String WITHDRAWAL_STATUS = "withdrawal_status";

  static const String CONTACT_US = "contact_us";
  static const String IMAGE = "image";
  static const String ADS_IMAGE = "ads_image";
  static const String OFFER_IMAGE = "offer_image";
  static const String REGISTER_POINTS = "register_points";
  static const String MIN_WITHDRAWAL = "min_withdrawal";
  static const String JOB_VIDEO = "job_video";
  static const String JOB_DETAILS = "job_details";
}
