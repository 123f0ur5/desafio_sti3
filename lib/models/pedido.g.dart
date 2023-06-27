// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pedido.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PedidoAdapter extends TypeAdapter<Pedido> {
  @override
  final int typeId = 0;

  @override
  Pedido read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pedido(
      fields[0] as String?,
      fields[1] as int?,
      fields[2] as DateTime?,
      fields[3] as DateTime?,
      fields[4] as String?,
      fields[5] as num?,
      fields[6] as num?,
      fields[7] as num?,
      fields[8] as num?,
      fields[9] as String?,
      fields[10] as String?,
      (fields[11] as List).cast<String>(),
      (fields[12] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Pedido obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.numero)
      ..writeByte(2)
      ..write(obj.dataCriacao)
      ..writeByte(3)
      ..write(obj.dataAlteracao)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.desconto)
      ..writeByte(6)
      ..write(obj.frete)
      ..writeByte(7)
      ..write(obj.subTotal)
      ..writeByte(8)
      ..write(obj.valorTotal)
      ..writeByte(9)
      ..write(obj.idCliente)
      ..writeByte(10)
      ..write(obj.idEnderecoEntrega)
      ..writeByte(11)
      ..write(obj.idItens)
      ..writeByte(12)
      ..write(obj.idPagamento);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PedidoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
