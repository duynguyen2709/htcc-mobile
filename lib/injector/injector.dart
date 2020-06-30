import 'package:hethongchamcong_mobile/data/model/payslip.dart';
import 'package:hethongchamcong_mobile/data/remote/account/account_repository.dart';
import 'package:hethongchamcong_mobile/data/remote/auth/auth_repository.dart';
import 'package:hethongchamcong_mobile/data/remote/checkin/check_in_repository.dart';
import 'package:hethongchamcong_mobile/data/remote/complaint/complaint_repository.dart';
import 'package:hethongchamcong_mobile/data/remote/contact/contact_repository.dart';
import 'package:hethongchamcong_mobile/data/remote/leaving/leaving_repository.dart';
import 'package:hethongchamcong_mobile/data/remote/main/main_repository.dart';
import 'package:hethongchamcong_mobile/data/remote/notification/notification_repository.dart';
import 'package:hethongchamcong_mobile/data/remote/payslip/pay_slip_repository.dart';
import 'package:hethongchamcong_mobile/data/remote/shift/shift_repository.dart';
import 'package:hethongchamcong_mobile/data/remote/statistic/statistic_repository.dart';

class Injector {
  static final AccountRepository accountRepository = AccountRepository();
  static final AuthRepository authRepository = AuthRepository();
  static final CheckInRepository checkInRepository = CheckInRepository();
  static final ComplaintRepository complaintRepository = ComplaintRepository();
  static final ContactRepository contactRepository = ContactRepository();
  static final LeavingRepository leavingRepository = LeavingRepository();
  static final NotificationRepository notificationRepository = NotificationRepository();
  static final MainRepository mainRepository = MainRepository();
  static final StatisticRepository statisticRepository= StatisticRepository();
  static final ShiftRepository shiftRepository= ShiftRepository();
  static final PayslipRepository payslipRepository = PayslipRepository();
}
