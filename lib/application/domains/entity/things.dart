import 'package:hive_flutter/hive_flutter.dart';

part 'things.g.dart';

@HiveType(typeId: 0)
class Things {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  String size;

  @HiveField(3)
  String weight;

  @HiveField(4)
  String? comment;

  @HiveField(5)
  bool checked;

  Things({
    required this.title,
    required this.description,
    required this.size,
    required this.weight,
    required this.comment,
    this.checked = false,
  });
}
