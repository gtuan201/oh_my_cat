import 'dart:convert';

import 'package:mood_press/ulti/constant.dart';

import '../../helper/api_client.dart';
import 'package:get/get.dart';

class EmojiRepo{
  final ApiClient api;

  EmojiRepo({required this.api});

  Future<Response> getChatCompletion(String prompt) async {
    Map<String,dynamic> body = {
      'model': 'qwen/qwen3-235b-a22b:free',
      'messages': [
        {
          'role': 'user',
          'content': prompt,
        }
      ],
    };
    Map<String,String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${Constant.aiApiKey}',
    };
    return await api.post(Constant.ENDPOINT_AI,body: body,headers: headers,url: Constant.AI_URL);
  }
}