import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:move/application/domains/entity/boxes.dart';

class ListBoxesModel extends ChangeNotifier {
  bool _isDisposed = false;

  ListBoxesModel() {
    _setup();
  }

  var _listBoxes = <Boxes>[];
  List<Boxes> get listBoxes => _listBoxes;

  Future<void> _setup() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(BoxesAdapter());
    }

    final box = await Hive.openBox<Boxes>('boxes_box');
    await _readBoxesFromHive();
    box.listenable().addListener(_readBoxesFromHive);
  }

  Future<void> _readBoxesFromHive() async {
    if (_isDisposed) return;
    final box = await Hive.openBox<Boxes>('boxes_box');
    _listBoxes = box.values.toList();
    notifyListeners();
  }

  @override
  void dispose() {
    _isDisposed = true;
    final box = Hive.box<Boxes>('boxes_box');
    if (box.isOpen) {
      box.listenable().removeListener(_readBoxesFromHive);
    }
    super.dispose();
  }

  void deleteBox(int index, BuildContext context) async {
    if (_isDisposed) return;
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(BoxesAdapter());
    }

    final box = await Hive.openBox<Boxes>('boxes_box');
    await box.deleteAt(index);
    Navigator.of(context).pop();
  }

  Future<void> updateBox({
    required int index,
    required Boxes newBox,
  }) async {
    
    final box = await Hive.openBox<Boxes>('boxes_box');
    await box.putAt(index, newBox);
    await _readBoxesFromHive();
  }
}
