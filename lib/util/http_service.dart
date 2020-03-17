import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myh_shop/util/dialog.dart';
import 'package:myh_shop/util/toast_util.dart';


const String ROOT_URL = 'http://sign.myhkj.cn/';
// const String ROOT_URL = 'http://192.168.3.33:8085/';
/// 连接超时 ms
const int CONNECT_TIMEOUT = 30000;
/// 接收超时 ms
const int RECEIVE_TIMEOUT = 30000;

class HttpService {

  static showRequestDialog(BuildContext context,{String msg = 'loading...'}){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_){
        return NetLoadingDialog(
          outsideDismiss: false,
          loadingText: msg,
        );
      }
    );
  }

  static cancelDiaglog(BuildContext context){
    Navigator.pop(context);
  }
  /// get
  static Future get(
    String api, BuildContext context,{
    Map<String, dynamic> params,
    String rootUrl = ROOT_URL,
    int connectTimeout = CONNECT_TIMEOUT,
    int receiveTimeout = RECEIVE_TIMEOUT,
    bool showSuccess = false,
    bool showLoading = true,
  }) async {
    if (showLoading) {
      showRequestDialog(context);
    }
    BaseOptions options = new BaseOptions(
      baseUrl: rootUrl,
      queryParameters: params,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      contentType: ContentType.json,
    );
    Dio dio = new Dio(options);
    return dio.get(api).then((response) {
      if (showLoading) {
        cancelDiaglog(context);
      }
      return response.data;
    }).catchError((error) {
      if (showLoading) {
        cancelDiaglog(context);
      }
      switch (error.type) {
        case DioErrorType.RESPONSE:
          Response response = error.response;
          switch (response.statusCode) {
            case 400:
              
              break;
            case 401:
              
              break;
            case 500:
              // ControllerService.toastFail('Http status error [500]');
              break;
            default:
              break;
          }
          break;
        case DioErrorType.SEND_TIMEOUT:
          // ControllerService.toastFail('请求超时');
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          // ControllerService.toastFail('接收请求超时');
          break;
        default:
      }
    });
  }

  /// post
  static Future post(
    String api,
    BuildContext context,
    {
    Map<String, dynamic> params,
    String rootUrl = ROOT_URL,
    int connectTimeout = CONNECT_TIMEOUT,
    int receiveTimeout = RECEIVE_TIMEOUT,
    bool showSuccess = true,
    bool showLoading = false,
    bool showFail = true,
    bool isFormData = false,
    bool isChunked = false,
    int start,
    int end,
    int total,
    ContentType contentType
  }) async {
    if (showLoading == true) {
      showRequestDialog(context);
    }
    BaseOptions options = new BaseOptions(
      baseUrl: rootUrl,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      contentType: contentType ?? ContentType.json
    );
    if(isFormData){
      params = FormData.from(params);
    }
    Dio dio = new Dio(options);
    return dio.post(api, data: params).then((response) {
      if (showLoading == true) {
        cancelDiaglog(context);
      }
      if (showSuccess == true) {
      }
      return response;
    }).catchError((error) {
      if (showLoading == true) {
        cancelDiaglog(context);
      }
      switch (error.type) {
        case DioErrorType.RESPONSE:
          Response response = error.response;
          switch (response.statusCode) {
            case 400:
              var jsonRes =json.decode(response.toString());
              ToastUtil.toast(jsonRes['msg']);
              break;
            case 401:
              var jsonRes =json.decode(response.toString());
              ToastUtil.toast(jsonRes['msg']);
              break;
            case 500:
              var jsonRes =json.decode(response.toString());
              ToastUtil.toast(jsonRes['msg']);
              break;
            default:
              var jsonRes =json.decode(response.toString());
              ToastUtil.toast(jsonRes['msg']);
              break;
          }
          break;
        case DioErrorType.SEND_TIMEOUT:
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          break;
        default:
          break;
      }
      throw Exception(error);
    });
  }
  /// put
  static Future put(
    String api,
    BuildContext context,
     {
    Map<String, dynamic> params,
    String rootUrl = ROOT_URL,
    int connectTimeout = CONNECT_TIMEOUT,
    int receiveTimeout = RECEIVE_TIMEOUT,
    bool showSuccess = true,
    bool showLoading = false,
    bool showFail = true,
  }) async {
    if (showLoading == true) {
      showRequestDialog(context);
    }
    BaseOptions options = new BaseOptions(
      baseUrl: rootUrl,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      contentType: ContentType.json,
    );
    Dio dio = new Dio(options);
    return dio.put(api, data: params).then((response) {
      if (showLoading == true) {
        cancelDiaglog(context);
      }
      return response;
    }).catchError((error) {
      if (showLoading == true) {
        cancelDiaglog(context);
      }
      switch (error.type) {
        case DioErrorType.RESPONSE:
          Response response = error.response;
          switch (response.statusCode) {
            case 400:
              var jsonRes =json.decode(response.toString());
              ToastUtil.toast(jsonRes['msg']);
              break;
            case 401:
            var jsonRes =json.decode(response.toString());
              ToastUtil.toast(jsonRes['msg']);
              break;
            case 500:
              var jsonRes =json.decode(response.toString());
              ToastUtil.toast(jsonRes['msg']);
              break;
            default:
              var jsonRes =json.decode(response.toString());
              ToastUtil.toast(jsonRes['msg']);
              break;
          }
          break;
        case DioErrorType.SEND_TIMEOUT:
          ToastUtil.toast('请求超时');
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          ToastUtil.toast('接收请求超时');
          break;
        default:
          break;
      }
      throw Exception(error);
    });
  }

  /// patch
  static Future patch(
    String api, BuildContext context, {
    Map<String, dynamic> params,
    String rootUrl = ROOT_URL,
    int connectTimeout = CONNECT_TIMEOUT,
    int receiveTimeout = RECEIVE_TIMEOUT,
    bool showSuccess = true,
    bool showLoading = false,
    bool showFail = true,
    bool isFormData = false
  }) async {
    if (showLoading == true) {
      showRequestDialog(context);
    }
    BaseOptions options = new BaseOptions(
      baseUrl: rootUrl,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      contentType: ContentType.json,
    );
    if(isFormData){
      params = FormData.from(params);
    }
    Dio dio = new Dio(options);
    return dio.patch(api, data: params).then((response) {
      if (showLoading == true) {
        cancelDiaglog(context);
      }
      if (showSuccess == true) {
      }
      return response;
    }).catchError((error) {
      if (showLoading == true) {
        cancelDiaglog(context);
      }
      switch (error.type) {
        case DioErrorType.RESPONSE:
          Response response = error.response;
          switch (response.statusCode) {
            case 400:
              break;
            case 401:
              break;
            case 500:
              break;
            default:
              break;
          }
          break;
        case DioErrorType.SEND_TIMEOUT:
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          break;
        default:
      }
      throw Exception(error);
    });
  }




//   /// post
//   static Future delete(
//     String api, {
//     Map<String, dynamic> params,
//     String rootUrl = ROOT_URL,
//     int connectTimeout = CONNECT_TIMEOUT,
//     int receiveTimeout = RECEIVE_TIMEOUT,
//     bool showSuccess = true,
//     bool showLoading = false,
//     bool showFail = true,
//   }) async {
//     Function dismiss;
//     if (showLoading == true) {
//       dismiss = FLToast.loading(text: 'Loading...');
//     }
//     BaseOptions options = new BaseOptions(
//       baseUrl: rootUrl,
//       connectTimeout: connectTimeout,
//       receiveTimeout: receiveTimeout,
//       contentType: ContentType.json,
//     );
//     Dio dio = new Dio(options);
//     return dio.delete(api, data: params).then((response) {
//       if (showLoading == true) {
//         dismiss();
//       }
//       if (showSuccess == true) {
//         ControllerService.toastSuccess();
//       }
//       return response;
//     }).catchError((error) {
//       if (showLoading == true) {
//         dismiss();
//       }
//       switch (error.type) {
//         case DioErrorType.RESPONSE:
//           Response response = error.response;
//           switch (response.statusCode) {
//             case 400:
//               int i = 1;
//               var jsonRes =json.decode(response.toString());
//               jsonRes.forEach((k,v){
//                 if(i == 1){
//                   ControllerService.toastFail(v[0]);
//                   ++i;
//                 }
//               });
//               break;
//             case 401:
//               break;
//             case 500:
//               ControllerService.toastFail('Http status error [500]');
//               break;
//             default:
//               break;
//           }
//           break;
//         case DioErrorType.SEND_TIMEOUT:
//           ControllerService.toastFail('请求超时');
//           break;
//         case DioErrorType.CONNECT_TIMEOUT:
//           ControllerService.toastFail('接收请求超时');
//           break;
//         default:
//       }
//       throw Exception(error);
//     });
//   }

//     /// post
//   static dynamic postVideo(
//     String api, 
//     {
//     Map<String, dynamic> params,
//     String rootUrl = ROOT_URL,
//     int connectTimeout = CONNECT_TIMEOUT,
//     int receiveTimeout = RECEIVE_TIMEOUT,
//     bool showSuccess = true,
//     bool showLoading = false,
//     bool showFail = true,
//     bool isFormData = false,
//     bool isChunked = false,
//     int start,
//     int end,
//     int total
//   }) async {
//     Function dismiss;
//     if (showLoading == true) {
//       dismiss = FLToast.loading(text: 'Loading...');
//     }
//     BaseOptions options = new BaseOptions(
//       baseUrl: rootUrl,
//       connectTimeout: connectTimeout,
//       receiveTimeout: receiveTimeout,
//       contentType: ContentType.json,
//     );
//     if(isFormData){
//       params = FormData.from(params);
//     }
//     Dio dio = new Dio(options);
//     try{
//       var res = await dio.post(api, data: params).catchError((e){
//     });
//       var rs = res.data;
//       return rs;
//     }catch(e){
//       return null;
//     }
    
//   }
//   static Future requestImg(File img) async{
//     try{
//       Dio dio = new Dio();
//       dio.options.responseType = ResponseType.plain;
//       FormData formData = new FormData.from({
//         'file':new UploadFileInfo(new File(img.path), img.path.substring(img.path.lastIndexOf('/'),img.path.length))
//       });
//       Response res = await dio.post('http://182.92.64.244:2019/kuaiya/upload/headImg',data:formData);
//       if(res.statusCode == 200){
//         return res.data;
//       }else{
//         throw Exception('error://');
//       }
//     }catch(e){
//       throw Exception('error://');
//     }
//   }

//   static Future ping() async{
//     try{
//       Dio dio = new Dio();
//       Response res = await dio.get('http://www.baidu.com');
//       if(res.statusCode == 200){
//         return res.statusCode;
//       }else{
//         throw Exception('error://');
//       }
//     }catch(e){
//       throw Exception('error://');
//     }
//   }

static Future uploadImg(
    File image, BuildContext context, {
    String api = 'api/upload/video',
    String rootUrl = 'http://mpw.520mpw.com/',
    int connectTimeout = CONNECT_TIMEOUT,
    int receiveTimeout = RECEIVE_TIMEOUT,
    bool showSuccess = false,
    bool showFail = true,
    bool showLoading = true
  }) async {
    if (showLoading == true) {
      showRequestDialog(context);
    }
    String path = image.path;
    var name = path.substring(path.lastIndexOf("/") + 1, path.length);
    var suffix = name.substring(name.lastIndexOf(".") + 1, name.length);

    FormData formData = new FormData.from({
      "file": new UploadFileInfo(new File(path), name,
          contentType: ContentType.parse("image/$suffix"))
    });

    BaseOptions options = new BaseOptions(
      baseUrl: rootUrl,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
    );
    Dio dio = new Dio(options);

    return dio.post(api, data: formData).then((response) {
      if(showLoading){
        cancelDiaglog(context);
      }
      return response.data;
    }).catchError((error) {
      if (showLoading) {
        cancelDiaglog(context);
      }
      throw Exception(error);
    });
  }

}
