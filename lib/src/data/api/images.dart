import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';

Future<ImageProvider> loadImage(url) async {
  final httpClient = HttpClient();
  try {
    final request = await httpClient.headUrl(Uri.parse(url));
    final response = await request.close();
    if (response.statusCode == HttpStatus.notFound) {
      return const AssetImage('assets/image_base.jpg');
    }
    return NetworkImage(url);
  } catch (error) {
    return const AssetImage('assets/image_base.jpg');
  } finally {
    httpClient.close();
  }
}