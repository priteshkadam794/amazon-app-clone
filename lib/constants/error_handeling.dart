import 'dart:convert';

import 'package:e_commerce_app/constants/utils.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void handleHttpResonse({
  required BuildContext context,
  required VoidCallback onSuccess,
  required http.Response httpResponse,
}) {
  switch (httpResponse.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(context, jsonDecode(httpResponse.body)['msg']);
      break;
    case 406:
      showSnackBar(context, jsonDecode(httpResponse.body)['msg']);
      break;
    case 500:
      showSnackBar(context, jsonDecode(httpResponse.body)['error']);
    default:
      showSnackBar(context, "Some internal error occured");
  }
}
