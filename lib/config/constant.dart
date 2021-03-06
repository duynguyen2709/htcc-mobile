class Constants {
  //Route

  static const String ic_logo = "assets/logo.png";
  static const String isLogin = "";
  static const String login_screen = "/login";
  static const String main_screen = "/main";
  static const String register_screen = "/register";
  static const String account_screen = "/account";
  static const String check_in_screen = "/checkin";
  static const String check_in_camera_screen = "/checkin/camera";
  static const String check_in_form = "/checkin/form";
  static const String home_screen = "/home";
  static const String password_screen = "/password";
  static const String leaving_form_screen = "/leavingform";
  static const String detail_leaving_screen = "/detailleaving";
  static const String complaint_screen = "/complaint";
  static const String complaint_form = "/complaint/new";
  static const String complaint_detail = "/complaint/detail";
  static const String quick_login = "/quicklogin";
  static const String contacts_screen = "/contacts";
  static const String statistic_detail_screen = "/statistic/detail";
  static const String shift_screen = "/shift";
  static const String about_us = "/about_us";

  //Shared preference

  static const String IS_LOGIN = "islogin";
  static const String TOKEN = "token";
  static const String USER = "user";
  static const String USERS = "users";
  static const String CHECK_IN_INFO = "checkin_info";
  static const String LIST_SCREEN = 'list_screen';

  //Message Dialog

  static const String MESSAGE_AUTHENTICATE = "Lỗi xác thực!\nVui lòng đăng nhập lại để tiếp tục.";
  static const String MESSAGE_NETWORK = "Lỗi kết nối!";
  static const String MESSAGE_EMPTY = "Dữ liệu không có sẵn!";
  static const String UPDATE_FAIL = "Cập nhật không thành công!";
  static const String UPDATE_SUCCESSFUL = "Cập nhật thành công!";

  //Status Model

  //Flag Screen

  static const int defaultScreen = 0;
  static const int checkInScreen = 1;
  static const int leavingScreen = 2;
  static const int statisticScreen = 3;
  static const int accountScreen = 4;
  static const int contactScreen = 5;
  static const int salaryScreen = 6;
  static const int complaintScreen = 7;
  static const int workingCalendarScreen = 12;

  //UI
  static String userName = "";

  static String password = "";

  static String checkIn = "Điểm Danh";

  static String hintUserName = "Tên đăng nhập";

  static String hintPassword = "Mật khẩu";

  static String forgotPassword = "Quên mật khẩu?";

  static String code = "Mã công ty";

  static String buttonLogin = "Đăng nhập";

  static String loading = "Please wait...";

  static String messageErrorDialog = "Tài khoản hoặc mật khẩu không chính xác!";

  static String buttonErrorDialog = "Ok";

  static String titleErrorDialog = "Thông báo";

  static String titleAppBarAccountScreen = "Personal details";

  static String phone = "phone: ";

  static String buttonCancel = "Cancel";

  static String buttonSave = "Save";

  static String titleErrorUserName = "Tên đăng nhập rỗng";

  static String titleErrorPassword = "Mật khẩu rỗng";

  static String titleErrorCode = "Mã công ty rỗng";

  static String messagePasswordError = "Mật khẩu không trùng lắp";

  static String messagePasswordEmpty = "Mật khẩu rỗng";

  static int CHECKIN = 1;

  static int DAY_OFF = 2;

  static int STATISTIC = 3;

  static int PERSONAL_INFO = 4;

  static int CONTACT_LIST = 5;

  static int PAYCHECK = 6;

  static int COMPLAINT = 7;

  static int HOME = 8;

  static int CHECKIN_IMAGE = 9;

  static int CHECKIN_QR = 10;

  static int CHECKIN_FORM = 11;

  static int WORKING_DAY = 12;
}
