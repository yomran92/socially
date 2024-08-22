import 'package:equatable/equatable.dart';

import '../../../account/data/remote/models/responses/user_model.dart';

class GetCommentEntity extends Equatable {
  int? id;



    String? body;
   int? postId;
   int? likes;
   int? userId;


  UserModel? user;
  GetCommentEntity({this.id, this.body, this.postId, this.likes,this.user,this.userId});

  @override
  List<Object?> get props => [id, body, postId, likes,user,userId];
}
