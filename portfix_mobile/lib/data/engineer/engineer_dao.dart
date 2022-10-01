
import 'package:portfix_mobile/data/engineer/engineer_modal.dart';

abstract class EngineerDao {
  Future<EngineerModal> getEngineerById(String id);
}
