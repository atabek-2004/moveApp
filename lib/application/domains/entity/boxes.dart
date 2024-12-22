import 'package:hive_flutter/hive_flutter.dart';
import 'package:move/application/domains/entity/things.dart';

part 'boxes.g.dart';

@HiveType(typeId: 1)
class Boxes {
  @HiveField(0)
  String title;

  @HiveField(1)
  String dimensions;

  @HiveField(3)
  String weight;

  @HiveField(4)
  String? comment;

  @HiveField(5) 
  List<String>? thingTitle;
  
  Boxes({
    required this.title,
    required this.dimensions,
    required this.weight,
    required this.comment,
    this.thingTitle,
  });
}
