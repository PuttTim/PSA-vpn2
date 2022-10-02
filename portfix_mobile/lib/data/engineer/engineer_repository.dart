import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:portfix_mobile/data/engineer/engineer_dao.dart';
import 'package:portfix_mobile/data/engineer/engineer_modal.dart';

class EngineerRepository implements EngineerDao {
  EngineerRepository._();
  static final EngineerRepository _repository = EngineerRepository._();
  factory EngineerRepository.getInstance() => _repository;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String collectionPath = "engineer";

  @override
  Future<EngineerModal> getEngineerById(String id) async {
    var document = await _firestore.collection(collectionPath).doc(id).get();
    return EngineerModal.fromDocument(document);
  }
}
