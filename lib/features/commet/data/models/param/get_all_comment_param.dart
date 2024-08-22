import '../../../../../core/constants.dart';
import '../../../../../core/params/params_model.dart';

class GetAllCommentParams extends ParamsModel<GetAllCommentParamsBody> {
  @override
  Map<String, String>? get additionalHeaders => {};

  @override
  RequestType? get requestType => RequestType.GET;

  @override
  String? get url => 'comments/post/${body!.postId}';

  @override
  Map<String, String> get urlParams => {
        'limit': body!.limit.toString(),
        'skip': body!.skip.toString(),
      };

  GetAllCommentParams({GetAllCommentParamsBody? body})
      : super(body: body, baseUrl: BaseUrl);

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

class GetAllCommentParamsBody extends BaseBodyModel {
  final int? limit;
  final int? skip;
  final int? postId;

  Map<String, dynamic> toJson() {
    return {};
  }

  GetAllCommentParamsBody(
      {required this.skip, required this.limit, required this.postId});
}
