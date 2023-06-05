import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pets/models/pet.dart';
import 'package:pets/provider/http_provider.dart';
import 'package:pets/provider/user_provider.dart';

final petsProvider = FutureProvider<Map<String, Pet>>((ref) async {
  final token = ref.watch(tokenProvider);
  var res = await ref.read(httpClientProvider).get(
      Uri.http('10.0.2.2:8055', 'items/animais'),
      headers: {'Authorization': 'Bearer $token'});

  var decodedJson = jsonDecode(res.body)['data'] as List<dynamic>;

  // ignore: prefer_for_elements_to_map_fromiterable
  var pets = Map<String, Pet>.fromIterable(decodedJson,
      key: (json) => json['id'], value: (json) => Pet.fromJson(json));

  return pets;
});

final petProvider = FutureProvider.family<Pet?, String>((ref, id) async {
  var pets = await ref.watch(petsProvider.future);
  return pets[id];
});
