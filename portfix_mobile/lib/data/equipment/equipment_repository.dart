import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:portfix_mobile/data/equipment/equipment_dao.dart';
import 'package:portfix_mobile/data/equipment/equipment_model.dart';

class EquipmentRepository implements EquipmentDao {
  EquipmentRepository._();
  static final EquipmentRepository _repository = EquipmentRepository._();
  factory EquipmentRepository.getInstance() => _repository;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionPath = "equipment";

  @override
  Future<List<EquipmentModel>> getAllEquipments() async {
    var documents = await _firestore.collection(collectionPath).get();
    return documents.docs.map((e) {
      return EquipmentModel.fromDocument(e);
    }).toList();
  }

  @override
  Future<EquipmentModel> getEquipmentById(String id) async {
    var document = await _firestore.collection(collectionPath).doc(id).get();
    return EquipmentModel.fromDocument(document);
  }
}
