import '../../../../../core/constants.dart';
import '../../../../../core/params/params_model.dart';

class AddCommentParams extends ParamsModel<AddCommentParamsBody> {
  @override
  Map<String, String>? get additionalHeaders => {};

  @override
  RequestType? get requestType => RequestType.POST;

  @override
  String? get url => 'comments/add';

  @override
  Map<String, String> get urlParams => {};

  AddCommentParams({AddCommentParamsBody? body})
      : super(body: body, baseUrl: BaseUrl);

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

class AddCommentParamsBody extends BaseBodyModel {
  String? todo;

  bool? completed;

  int? userId;
  int? postId;

  Map<String, dynamic> toJson() {
    return {
      'body': todo,
      'completed': completed,
      'userId': userId,
      'postId': postId,
    };
  }

  AddCommentParamsBody({
    required this.todo,
    required this.postId,
    required this.completed,
    required this.userId,
  });
}
