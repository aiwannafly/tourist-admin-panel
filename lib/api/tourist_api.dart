import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tourist_admin_panel/api/base_crud_api.dart';
import 'package:tourist_admin_panel/api/crud_api.dart';
import 'package:tourist_admin_panel/api/group_api.dart';
import 'package:tourist_admin_panel/model/tourist.dart';

import 'api_fields.dart';

class TouristApi extends CRUDApi<Tourist> {
  TouristApi._internal();

  static final _crudApi = BaseCRUDApi<Tourist>(
      singleApiName: "tourist",
      multiApiName: "tourists",
      toJSON: toJSON,
      fromJSON: fromJSON);

  factory TouristApi() {
    return TouristApi._internal();
  }

  @override
  Future<List<Tourist>?> getAll() async {
    return _crudApi.getAll();
  }

  Future<List<Tourist>?> findByGroup({required int groupId}) async {
    var response = await http.get(Uri.parse(
        '${apiUrl}search/tourists/group/$groupId'));
    if (response.statusCode != 200) {
      return null;
    }
    var decodedBody = utf8.decode(response.body.codeUnits);
    var collectionJson = jsonDecode(decodedBody);
    List<Tourist> tourists = [];
    for (dynamic entity in collectionJson) {
      tourists.add(fromJSON(entity));
    }
    return tourists;
  }

  Future<List<Tourist>?> findByGenderAndSkill(
      Set<Gender> genders, Set<SkillCategory> skillCategories) async {
    if (genders.isEmpty || skillCategories.isEmpty) {
      return [];
    }
    String gendersStr =
        genders.fold("", (prev, curr) => "$prev,${curr.string}").substring(1);
    String skillsStr = skillCategories
        .fold("", (prev, curr) => "$prev,${curr.string}")
        .substring(1);
    var response = await http.get(Uri.parse(
        '${apiUrl}search/tourists?genders=$gendersStr&skillCategories=$skillsStr'));
    if (response.statusCode != 200) {
      return null;
    }
    var decodedBody = utf8.decode(response.body.codeUnits);
    var collectionJson = jsonDecode(decodedBody);
    List<Tourist> tourists = [];
    for (dynamic entity in collectionJson) {
      tourists.add(fromJSON(entity));
    }
    return tourists;
  }

  @override
  Future<int?> create(Tourist value) async {
    return _crudApi.create(value);
  }

  static String toJSON(Tourist tourist) {
    return jsonEncode(toMap(tourist));
  }

  static Map<String, dynamic> toMap(Tourist tourist) {
    return {
      "id" : tourist.id,
      "birthYear": tourist.birthYear,
      "firstName": tourist.firstName,
      "secondName": tourist.secondName,
      "gender": tourist.gender.string,
      "group": tourist.group == null ? null :  GroupApi.toMap(tourist.group!),
      "skillCategory": tourist.skillCategory.string.toUpperCase()
    };
  }

  @override
  Future<bool> update(Tourist value) async {
    return _crudApi.update(value);
  }

  @override
  Future<bool> delete(Tourist value) async {
    return _crudApi.delete(value);
  }

  static Tourist fromJSON(dynamic data) {
    TouristBuilder builder = TouristBuilder()
      ..id = data["id"]
      ..birthYear = data["birthYear"]
      ..firstName = data["firstName"]
      ..secondName = data["secondName"]
      ..group = data["group"] == null ? null : GroupApi.fromJSON(data["group"])
      ..gender = GenderExtension.fromString(data["gender"])
      ..skillCategory = SkillCateforyExtension.fromString(data["skillCategory"])
      ..build();
    return builder.build();
  }
}
