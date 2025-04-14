import 'package:hive/hive.dart';

part 'user_model.g.dart'; // Generated file

@HiveType(typeId: 0) // Unique typeId for the model
class User extends HiveObject {
  @HiveField(0) // Unique index for the field
  late String id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late int age;

  User({
    required this.id,
    required this.name,
    required this.age,
  });

  @override
  String toString() => 'User(id: $id, name: $name, age: $age)';
} 