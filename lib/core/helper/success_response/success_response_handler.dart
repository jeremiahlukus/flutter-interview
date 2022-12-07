import 'package:otto_app/core/helper/success_response/successful_response.dart';

//
class SuccessResponseHanlder<T> {
  call(int? statusCode, {required T data}) {
    switch (statusCode) {
      case 200:
        return SuccessfullResponse.ok(data: data);
      case 201:
        return SuccessfullResponse.created(data: data);
      case 202:
        return const SuccessfullResponse.accepted();
      case 204:
        return const SuccessfullResponse.noContent();
      default:
        return SuccessfullResponse.ok(data: data);
    }
  }
}
