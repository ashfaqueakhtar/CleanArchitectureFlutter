import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:getx_clean_arch/config/network/api_service.dart';
import 'package:getx_clean_arch/config/network/network_constants.dart';
import 'package:getx_clean_arch/config/network/resource.dart';
import 'package:getx_clean_arch/config/network/status.dart';
import 'package:getx_clean_arch/data/datasources/appLocalData/app_local_data.dart';
import 'package:getx_clean_arch/data/model/remote/user/all_user_response.dart';
import 'package:getx_clean_arch/domain/repo/user_repo.dart';
import 'package:getx_clean_arch/utils/common_utils.dart';

class UserRepoImpl extends UserRepo{
  final ApiService _apiService = Get.find<ApiService>();
  final AppLocalData _localData = Get.find<AppLocalData>();

  @override
  Future clearAllData() {
    return _localData.clearAllData();
  }

  @override
  Future getAllUsers({requestData}) async{
    try {
      AllUserResponse? response;
      dynamic data = _apiService.getRequest(
          url: "${dotenv.get(NetworkConstants.baseUrl)}${NetworkConstants.endPointUser}",
          queryParameters: requestData,
          withToken: false // because we are not sending a default token in this api
      );
      Resource resource = await data;
      if (resource.status == STATUS.SUCCESS) {
        response = AllUserResponse.fromJson(resource.data);
        /*if (response.success ?? false) {
          return response;
        } else {
          if (Get.context != null) {
            CommonUtils().snackbarMessage(response.message ?? "", Get.context!);
          }
        }*/
        ////Use above if you follow the format shared in README file
        ////For this example return following
        return response;
      } else {
        if (Get.context != null) {
          CommonUtils().snackbarMessage(resource.message ?? "", Get.context!);
        }
      }
      return data;
    } catch (e) {
      if (Get.context != null) {
        CommonUtils().snackbarMessage("Something went wrong, Please try again!", Get.context!);
      }
      rethrow;
    }
  }

}