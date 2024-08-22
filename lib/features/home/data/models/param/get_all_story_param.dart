import '../../../../../core/constants.dart';
import '../../../../../core/params/params_model.dart';
import '../../../../../core/state/appstate.dart';
import '../../../../../service_locator.dart';

class GetAllStoryParams extends ParamsModel<GetAllStoryParamsBody> {
  @override
  Map<String, String>? get additionalHeaders => {};

  @override
  RequestType? get requestType => RequestType.GET;

  @override
  String? get url => 'users';

  @override
  Map<String, String> get urlParams => {
        'limit': body!.limit.toString(),
        'skip': body!.skip.toString(),
      };

  GetAllStoryParams({GetAllStoryParamsBody? body})
      : super(body: body, baseUrl: BaseUrl);

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

class GetAllStoryParamsBody extends BaseBodyModel {
  final int? limit;
  final int? skip;

  Map<String, dynamic> toJson() {
    return {};
  }

  GetAllStoryParamsBody({required this.skip, required this.limit});
}
