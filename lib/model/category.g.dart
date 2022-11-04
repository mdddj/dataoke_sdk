// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryAdapter extends TypeAdapter<Category> {
  @override
  final int typeId = 100;

  @override
  Category read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Category(
      cname: fields[0] as String,
      cpic: fields[1] as String,
      subcategories: (fields[2] as List).cast<Subcategory>(),
      cid: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Category obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.cname)
      ..writeByte(1)
      ..write(obj.cpic)
      ..writeByte(2)
      ..write(obj.subcategories)
      ..writeByte(3)
      ..write(obj.cid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SubcategoryAdapter extends TypeAdapter<Subcategory> {
  @override
  final int typeId = 101;

  @override
  Subcategory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Subcategory(
      subcid: fields[0] as int,
      scpic: fields[1] as String,
      subcname: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Subcategory obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.subcid)
      ..writeByte(1)
      ..write(obj.scpic)
      ..writeByte(2)
      ..write(obj.subcname);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubcategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CategoryWrapperAdapter extends TypeAdapter<CategoryWrapper> {
  @override
  final int typeId = 102;

  @override
  CategoryWrapper read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryWrapper(
      (fields[0] as List).cast<Category>(),
    );
  }

  @override
  void write(BinaryWriter writer, CategoryWrapper obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.categorys);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryWrapperAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}