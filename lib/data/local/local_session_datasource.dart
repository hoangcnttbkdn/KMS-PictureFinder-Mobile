import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pictures_finder/model/sent_session.dart';

class LocalSessionDatasource {
  LocalSessionDatasource({required Box<SentSession> box}) : _box = box;
  final Box<SentSession> _box;

  Iterable<SentSession> get datas => _box.values;

  ValueListenable<Box<SentSession>> getListenable() => _box.listenable();

  Future<void> insert(SentSession data) => _box.add(data);

  Future<void> deleteAt(int index) => _box.deleteAt(index);
}
