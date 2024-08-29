// import 'package:flutter/material.dart';

import 'dart:typed_data';
import 'package:hive/hive.dart';

class UserInfo {
  final String name;
  final int age;
  final List<int>? numbers;
  final String? email;
  final Map<String, String>? socialMediaLinks;
  Uint8List? image;

  UserInfo(
      {required this.age,
      required this.name,
      required this.numbers,
      this.email,
      this.image,
      this.socialMediaLinks});

  @override
  String toString() {
    return "UserInfo(name: $name, age: $age, number: $numbers)";
  }
}

class UserInfoAdapter extends TypeAdapter<UserInfo> {
  @override
  final int typeId = 0;

  @override
  UserInfo read(BinaryReader reader) {
    final name = reader.readString();
    final age = reader.readInt();
    final numbers = reader.readBool() ? reader.readIntList() : null;
    final email = reader.readBool() ? reader.readString() : null;
    final image = reader.readBool() ? reader.readByteList() : null;
    final socialMediaLinks = reader.readBool()
        ? reader.readMap().map(
              (key, value) => MapEntry(key.toString(), value.toString()),
            )
        : null;

    return UserInfo(
      name: name,
      age: age,
      numbers: numbers,
      email: email,
      image: image,
      socialMediaLinks: socialMediaLinks,
    );
  }

  @override
  void write(BinaryWriter writer, UserInfo obj) {
    writer.writeString(obj.name);
    writer.writeInt(obj.age);

    writer.writeBool(obj.numbers != null);
    if (obj.numbers != null) writer.writeIntList(obj.numbers!);

    writer.writeBool(obj.email != null);
    if (obj.email != null) writer.writeString(obj.email!);

    writer.writeBool(obj.image != null);
    if (obj.image != null) writer.writeByteList(obj.image!);

    writer.writeBool(obj.socialMediaLinks != null);
    if (obj.socialMediaLinks != null) {
      writer.writeMap(obj.socialMediaLinks!);
    }
  }
}
