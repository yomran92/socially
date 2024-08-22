import '../../../../../core/constants.dart';
import '../../../../../core/params/params_model.dart';
import '../../../../../core/state/appstate.dart';
import '../../../../../service_locator.dart';

class GetAllPostParams extends ParamsModel<GetAllPostParamsBody> {
  @override
  Map<String, String>? get additionalHeaders => {};

  @override
  RequestType? get requestType => RequestType.GET;

  @override
  String? get url => 'todos/user/${sl<AppStateModel>().user!.id}';

  @override
  Map<String, String> get urlParams => {
        'limit': body!.limit.toString(),
        'skip': body!.skip.toString(),
      };

  GetAllPostParams({GetAllPostParamsBody? body})
      : super(body: body, baseUrl: BaseUrl);

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

class GetAllPostParamsBody extends BaseBodyModel {
  final int? limit;
  final int? skip;

  Map<String, dynamic> toJson() {
    return {};
  }

  GetAllPostParamsBody({required this.skip, required this.limit});
}
