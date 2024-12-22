import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:move/application/domains/entity/things.dart';

class ListThingsModel extends ChangeNotifier {
  bool _isDisposed = false;

  ListThingsModel() {
    _setup();
  }

  var _listThings = <Things>[];
  List<Things> get listTings => _listThings;

  Future<void> _setup() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ThingsAdapter());
    }

    final box = await Hive.openBox<Things>('things_box');
    await _readThingsFromHive();
    box.listenable().addListener(_readThingsFromHive);
  }

  Future<void> _readThingsFromHive() async {
    if (_isDisposed) return;
    final box = await Hive.openBox<Things>('things_box');
    _listThings = box.values.toList();
    notifyListeners();
  }

  @override
  void dispose() {
    _isDisposed = true;
    final box = Hive.box<Things>('things_box');
    if (box.isOpen) {
      box.listenable().removeListener(_readThingsFromHive);
    }
    super.dispose();
  }

  void deleteThing(int index, BuildContext context) async {
    if (_isDisposed) return;
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ThingsAdapter());
    }

    final box = await Hive.openBox<Things>('things_box');
    await box.deleteAt(index);
    Navigator.of(context).pop();
  }

  Future<void> updateThing({
    required int index,
    required Things newThing,
  }) async {
    
    final box = await Hive.openBox<Things>('things_box');
    await box.putAt(index, newThing);
    await _readThingsFromHive();
  }
}
