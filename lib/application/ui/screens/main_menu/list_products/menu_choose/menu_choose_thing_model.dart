import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:move/application/domains/entity/boxes.dart';
import 'package:move/application/domains/entity/things.dart';

class MenuChooseThingModel extends ChangeNotifier {
  MenuChooseThingModel() {
    _setup();
  }


  final textController = TextEditingController();

  var _searchedList = <Things>[];
  List<Things> get searchedList => _searchedList;

  void searchFunc(String text) {
    if (text.isEmpty) {
      _searchedList = _listThings;
    } else {
      _searchedList = _listThings.where((e) {
        return e.title.toLowerCase().contains(text.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  var _listThings = <Things>[];
  List<Things> get listTings => _searchedList;

  void funcChecked(int index, bool value) {
    _listThings[index].checked = value;
    notifyListeners();
  }

  Future<void> _setup() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ThingsAdapter());
    }

    final box = await Hive.openBox<Things>('things_box');
    _listThings = box.values.toList();
    _searchedList = _listThings;
    notifyListeners();
  }

  var _listAddedThings = <Things>[];
  List<Things> get listAddedThings => _listAddedThings;

  Future<void> addThings(BuildContext context) async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ThingsAdapter());
    }

    final box = await Hive.openBox<Things>('things_box');
    box.values.map((e) {
      e.checked == true ? _listAddedThings.add(e) : null;
    });
    notifyListeners();
    Navigator.of(context).pop();
  }

  //  Future<void> addBox(String title, String dimensions, String weight, String? comment) async {
  //   final box = await Hive.openBox<Boxes>('boxes_box');
  //   final selectedThingNames = _listThings.where((thing) => thing.checked).map((thing) => thing.title).toList();
  //   final newBox = Boxes(
  //     title: title,
  //     dimensions: dimensions,
  //     weight: weight,
  //     comment: comment,
  //     thingTitle: selectedThingNames,
  //   );
  //   await box.add(newBox);
  //   notifyListeners();
  // }
}
