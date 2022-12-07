import 'package:equatable/equatable.dart';

class FocusState extends Equatable {
  final bool? hasValue;
  final bool? isFocused;
  final bool? hasError;

  const FocusState({
    this.hasValue = false,
    this.isFocused = false,
    this.hasError = false,
  });

  @override
  List<Object?> get props => [hasValue, isFocused, hasError];
}
