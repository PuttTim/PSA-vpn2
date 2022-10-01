import 'package:portfix_mobile/data/equipment/equipment_model.dart';

abstract class EquipmentDao {
  Future<EquipmentModel> getEquipmentById(String id);
  Future<List<EquipmentModel>> getAllEquipments();
}
