import 'package:portfix_mobile/data/logs/log_modal.dart';

abstract class LogDao {
  Future<List<LogModel>> getLogsOfUser(String engineerId);
  Future<bool> createLog(LogModel logModel);
}
