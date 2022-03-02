import 'package:flutter/widgets.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class Entity<TKey> extends Equatable {
  final TKey id;

  Entity(this.id);

  Map<String, dynamic> toMap() {
    return {'id': id};
  }

  @override
  List<Object> get props => [];
}
