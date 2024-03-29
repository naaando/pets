import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:pets/models/pet.dart';
import 'package:pets/http_client.dart';

class PetRepository {
  final HttpClient httpClient;

  PetRepository(this.httpClient);

  Future<Pet?> find(String id, {bool forceRefresh = false}) async {
    var jsonPet = await httpClient.getJson('api/pets/$id');
    return Pet.fromJson(jsonPet);
  }

  Future<Map<String, Pet>> findAll(
      {String? espacoId, bool forceRefresh = false}) async {
    var jsonPets = await httpClient.getJson('api/pets?espaco_id=$espacoId');

    // ignore: prefer_for_elements_to_map_fromiterable
    return Map<String, Pet>.fromIterable(jsonPets,
        key: (json) => json['id'], value: (json) => Pet.fromJson(json));
  }

  Future<Pet> save(Pet pet) async {
    Pet? savedPet;

    if (pet.id == null) {
      savedPet = await _create(pet);
    } else {
      savedPet = await _update(pet);
    }

    return savedPet;
  }

  remove(Pet pet) async {
    await httpClient.delete('api/pets/${pet.id}');
  }

  Future<Pet> _create(Pet pet) async {
    var jsonPet = await httpClient.postJson('api/pets', pet.toJson());
    return Pet.fromJson(jsonPet);
  }

  Future<Pet> _update(Pet pet) async {
    var petJson =
        await httpClient.patchJson('api/pets/${pet.id}', pet.toJson());
    return Pet.fromJson(petJson);
  }

  Future<String?> updateProfilePicture(Pet pet, XFile file) async {
    Dio dio = httpClient.httpClient;

    final formData = FormData.fromMap({
      '_method': 'put',
      'file': MultipartFile.fromBytes(
        await file.readAsBytes(),
        filename: file.name,
        contentType: MediaType.parse(lookupMimeType(file.name)!),
      )
    });

    var response = await dio.post(
      'api/pets/${pet.id}/image',
      data: formData,
      options: Options(
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        headers: {
          'Accept': 'application/json',
        },
      ),
    );

    return response.data['path'];
  }
}
