import 'dart:io';
import 'package:http/http.dart' as http;
import '/services/api-list.dart';

class Server {
  static String? bearerToken;

  static initClass({String? token}) {
    bearerToken = token!;
  }

  getRequest({String? endPoint}) async {
    HttpClient client = HttpClient();
    try {
      client.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      return await http.get(Uri.parse(APIList.server! + endPoint!),
          headers: _getHttpHeaders());
    } catch (error) {
      return null;
    } finally {
      client.close();
    }
  }

  getRequestSettings(endPoint) async {
    HttpClient client = HttpClient();
    try {
      return await http.get(Uri.parse(APIList.server! + endPoint!),
          headers: getAuthHeaders());
    } catch (error) {
      return null;
    } finally {
      client.close();
    }
  }

  getRequestWithParam({String? endPoint, var categoryId}) async {
    HttpClient client = HttpClient();
    try {
      client.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      return await http.get(
          Uri.parse(APIList.server! + "category/$categoryId/show"),
          headers: _getHttpHeaders());
    } catch (error) {
      return null;
    } finally {
      client.close();
    }
  }

  getRequestWithParamCuisine({String? endPoint, var cuisineId}) async {
    HttpClient client = HttpClient();
    try {
      client.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      return await http.get(
          Uri.parse(APIList.server! + "cuisine/$cuisineId/show"),
          headers: _getHttpHeaders());
    } catch (error) {
      return null;
    } finally {
      client.close();
    }
  }

  getRequestWithParamOrders({String? endPoint, var orderId}) async {
    HttpClient client = HttpClient();
    try {
      client.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      return await http.get(Uri.parse(APIList.server! + "orders/$orderId/show"),
          headers: _getHttpHeaders());
    } catch (error) {
      return null;
    } finally {
      client.close();
    }
  }

  getRequestWithParamMenuItems({String? endPoint, var menuItemId}) async {
    HttpClient client = HttpClient();
    try {
      client.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      return await http.get(
          Uri.parse(APIList.server! +
              "restaurant-menuItem/menuItem/$menuItemId/show"),
          headers: _getHttpHeaders());
    } catch (error) {
      return null;
    } finally {
      client.close();
    }
  }

  postRequest({String? endPoint, String? body}) async {
    HttpClient client = HttpClient();
    try {
      client.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      return await http.post(Uri.parse(APIList.server! + endPoint!),
          headers: getAuthHeaders(), body: body);
    } catch (error) {
      //  return null;
    } finally {
      client.close();
    }
  }

  postRequestWithToken({String? endPoint, String? body}) async {
    HttpClient client = HttpClient();
    try {
      client.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      return await http.post(Uri.parse(APIList.server! + endPoint!),
          headers: _getHttpHeaders(), body: body);
    } catch (error) {
      return null;
    } finally {
      client.close();
    }
  }

  putRequest({String? endPoint, String? body}) async {
    HttpClient client = HttpClient();
    try {
      client.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      return await http.put(Uri.parse(APIList.server! + endPoint!),
          headers: _getHttpHeaders(), body: body);
    } catch (error) {
      return null;
    } finally {
      client.close();
    }
  }

  multipartRequest({String? endPoint, body, String? filepath, type}) async {
    Map<String, String> headers = {
      'Authorization': bearerToken!,
      'Content-Type': 'multipart/form-data',
    };
    HttpClient client = HttpClient();
    try {
      var request;
      if (type) {
        request = http.MultipartRequest(
            'POST', Uri.parse(APIList.server! + endPoint!))
          ..fields.addAll(body)
          ..headers.addAll(headers)
          ..files.add(await http.MultipartFile.fromPath('image', filepath!));
      } else {
        request = http.MultipartRequest(
            'POST', Uri.parse(APIList.server! + endPoint!))
          ..fields.addAll(body)
          ..headers.addAll(headers);
      }
      return await request.send();
    } catch (error) {
      return null;
    } finally {
      client.close();
    }
  }

  getRequestParam({String? endPoint, body}) async {
    HttpClient client = HttpClient();
    var uri =
        Uri.https(APIList.apiUrl!, APIList.apiEndPoint! + endPoint!, body);
    try {
      return await http.get(uri, headers: _getHttpHeaders());
    } catch (error) {
      return null;
    } finally {
      client.close();
    }
  }

  deleteRequest({String? endPoint}) async {
    HttpClient client = HttpClient();
    try {
      client.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      return await http.delete(Uri.parse(APIList.server! + endPoint!),
          headers: _getHttpHeaders());
    } catch (error) {
      return null;
    } finally {
      client.close();
    }
  }

  static Map<String, String> _getHttpHeaders() {
    Map<String, String> headers = new Map<String, String>();
    headers['Authorization'] = bearerToken!;
    headers['content-type'] = 'application/json';
    return headers;
  }

  static Map<String, String> getAuthHeaders() {
    Map<String, String> headers = new Map<String, String>();
    headers['content-type'] = 'application/json';
    return headers;
  }

  customGetRequest({String? endPoint, String? token}) async {
    HttpClient client = HttpClient();
    try {
      return await http.get(
        Uri.parse(APIList.server! + endPoint!),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': token!
        },
      );
    } catch (error) {
      return null;
    } finally {
      client.close();
    }
  }
}
