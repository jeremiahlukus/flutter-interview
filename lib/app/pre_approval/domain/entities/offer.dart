import 'package:equatable/equatable.dart';

class Offer extends Equatable {
  final String? asset;
  final String? title;
  final String? description;

  const Offer({
    this.asset,
    this.title,
    this.description,
  });

  String get fullName => '$asset $title $description';

  @override
  List<Object?> get props => [asset, title, description];
}
