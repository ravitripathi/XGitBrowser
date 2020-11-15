import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'User.g.dart';

abstract class User implements Built<User, UserBuilder> {
  static Serializer<User> get serializer => _$userSerializer;

  @nullable
  String get avatar_url;

  @nullable
  String get name;

  User._();

  factory User([void Function(UserBuilder) updates]) = _$User;
}
