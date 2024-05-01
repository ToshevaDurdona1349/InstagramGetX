import 'dart:convert';
import 'package:http/http.dart';
import 'package:ngdemo17/model/member_model.dart';
import 'package:ngdemo17/services/log_service.dart';
import '../model/notification_model.dart';

class Network {
  static String SERVER_FCM = "fcm.googleapis.com";

  static Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization':
    'key=AAAAZGqIWv0:APA91bFYC0r_O6g421E2tmVckyaBCBdMns7jpmodFI8SgVXdNM-crvKQRd65E8Pdwq-BhvPG_Y-B3_We2vLy2IcAK30rYtxDUlP6Aac_KVJJ2eHbHT6Q4pAB_T71snu6zNQkC62W8TA1'
  };

  /* Http Requests */

  static Future<String?> POST(String api, Map<String, dynamic> params) async {
    var uri = Uri.https(SERVER_FCM, api);
    var response = await post(uri, headers: headers, body: jsonEncode(params));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  /* Http Apis*/
  static String API_SEND_NOTIF = "/fcm/send";

  /* Http Params */
  static Map<String, dynamic> paramsNotify(Member sender, Member receiver) {
    var notification = Notification(title: "Followed", body: "${sender.fullname} has just been followed");
    var registrationIds = [receiver.device_token];
    var notificationModel = NotificationModel(notification: notification, registrationIds: registrationIds);
    return notificationModel.toJson();
  }
}