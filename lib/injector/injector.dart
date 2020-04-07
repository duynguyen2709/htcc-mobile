import 'package:hethongchamcong_mobile/data/remote/account/account_repository.dart';
import 'package:hethongchamcong_mobile/data/remote/auth/auth_repository.dart';
import 'package:hethongchamcong_mobile/data/remote/checkin/check_in_repository.dart';
import 'package:hethongchamcong_mobile/data/remote/complaint/complaint_repository.dart';
import 'package:hethongchamcong_mobile/data/remote/contact/contact_repository.dart';
import 'package:hethongchamcong_mobile/data/remote/leaving/leaving_repository.dart';

class Injector {
  static final AccountRepository accountRepository = AccountRepository();
  static final AuthRepository authRepository = AuthRepository();
  static final CheckInRepository checkInRepository = CheckInRepository();
  static final ComplaintRepository complaintRepository = ComplaintRepository();
  static final ContactRepository contactRepository = ContactRepository();
  static final LeavingRepository leavingRepository = LeavingRepository();
}
