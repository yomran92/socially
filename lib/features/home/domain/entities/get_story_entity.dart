import 'package:equatable/equatable.dart';

class GetStoryEntity extends Equatable {
  int? id;

  String? name;
  String? image;
  bool? isSeen;

  GetStoryEntity({this.id, this.image, this.name, this.isSeen});

  @override
  List<Object?> get props => [id, name, image, isSeen];
}
