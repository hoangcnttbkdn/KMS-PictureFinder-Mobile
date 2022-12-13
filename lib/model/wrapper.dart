import 'package:equatable/equatable.dart';

class Wrapper<T> extends Equatable {
  const Wrapper(this.value);

  final T value;

  @override
  List<Object?> get props => [value];
}
