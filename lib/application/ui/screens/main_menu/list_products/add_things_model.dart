import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:move/application/domains/entity/things.dart';

class AddThingsModel {

  final titleController = TextEditingController();
  final descriptionContrller = TextEditingController();
  final sizeController = TextEditingController();
  final weightController = TextEditingController();
  final commentController = TextEditingController();

  Future<void> saveThing(BuildContext context) async {
    final title = titleController.text;
    final description = descriptionContrller.text;
    final size = sizeController.text;
    final weight = weightController.text;
    final comment = commentController.text;

    if (title.isEmpty &&
        description.isEmpty &&
        size.isEmpty &&
        weight.isEmpty &&
        comment.isEmpty) {
      return;
    }
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ThingsAdapter());
    }

    final box = await Hive.openBox<Things>('things_box');
    final thing = Things(
      title: title,
      description: description,
      size: size,
      weight: weight,
      comment: comment,
    );
    await box.add(thing);
    Navigator.of(context).pop();
  }
}
