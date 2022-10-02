import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:portfix_mobile/data/logs/log_dao.dart';
import 'package:portfix_mobile/data/logs/log_modal.dart';

class LogRepository implements LogDao {
  LogRepository._();
  static final LogRepository _repository = LogRepository._();
  factory LogRepository.getInstance() => _repository;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String collectionPath = "log";

  @override
  Future<bool> createLog(LogModel logModel) async {
    try {
      await _firestore.collection(collectionPath).doc().set(logModel.toMap());
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  @override
  Future<List<LogModel>> getLogsOfUser(String engineerId) async {
    var documents = await _firestore
        .collection(collectionPath)
        .where("engineerId", isEqualTo: engineerId)
        .get();
    return documents.docs.map((e) {
      return LogModel.fromDocument(e);
    }).toList();
  }
}
