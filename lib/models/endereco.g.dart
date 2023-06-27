// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'endereco.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EnderecoAdapter extends TypeAdapter<Endereco> {
  @override
  final int typeId = 2;

  @override
  Endereco read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Endereco(
      fields[0] as String?,
      fields[1] as String?,
      fields[2] as String?,
      fields[3] as String?,
      fields[4] as String?,
      fields[5] as String?,
      fields[6] as String?,
      fields[7] as String?,
      fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Endereco obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.endereco)
      ..writeByte(2)
      ..write(obj.numero)
      ..writeByte(3)
      ..write(obj.cep)
      ..writeByte(4)
      ..write(obj.bairro)
      ..writeByte(5)
      ..write(obj.cidade)
      ..writeByte(6)
      ..write(obj.estado)
      ..writeByte(7)
      ..write(obj.complemento)
      ..writeByte(8)
      ..write(obj.referencia);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EnderecoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
