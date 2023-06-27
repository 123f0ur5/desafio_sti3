// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagamento.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PagamentoAdapter extends TypeAdapter<Pagamento> {
  @override
  final int typeId = 4;

  @override
  Pagamento read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pagamento(
      fields[0] as String?,
      fields[1] as num?,
      fields[2] as num?,
      fields[3] as String?,
      fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Pagamento obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.parcela)
      ..writeByte(2)
      ..write(obj.valor)
      ..writeByte(3)
      ..write(obj.codigo)
      ..writeByte(4)
      ..write(obj.nome);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PagamentoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
