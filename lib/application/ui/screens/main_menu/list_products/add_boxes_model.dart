import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:move/application/domains/entity/boxes.dart';

class AddBoxesModel {
  final titleController = TextEditingController();
  final dimensionsContrller = TextEditingController();
  final weightController = TextEditingController();
  final commentController = TextEditingController();

  Future<void> saveBox(BuildContext context) async {
    final title = titleController.text;
    final dimensions = dimensionsContrller.text;

    final weight = weightController.text;
    final comment = commentController.text;

    if (title.isEmpty &&
        dimensions.isEmpty &&
        weight.isEmpty &&
        comment.isEmpty) {
      return;
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(BoxesAdapter());
    }

    final box = await Hive.openBox<Boxes>('boxes_box');
    final boxes = Boxes(title: title, dimensions: dimensions, weight: weight, comment: comment);
    await box.add(boxes);
    Navigator.of(context).pop();
  }
}
