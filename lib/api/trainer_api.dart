import 'dart:convert';

import 'package:tourist_admin_panel/api/base_crud_api.dart';
import 'package:tourist_admin_panel/api/crud_api.dart';
import 'package:tourist_admin_panel/api/section_api.dart';
import 'package:tourist_admin_panel/api/tourist_api.dart';

import '../model/trainer.dart';

class TrainerApi extends CRUDApi<Trainer> {
  static final _crudApi = BaseCRUDApi<Trainer>(
      singleApiName: "trainer",
      multiApiName: "trainers",
      toJSON: toJSON,
      fromJSON: fromJSON);

  static String toJSON(Trainer t) {
    return jsonEncode(toMap(t));
  }

  static Trainer fromJSON(dynamic json) {
    return Trainer(
        id: json["id"],
        salary: json["salary"],
        section: SectionApi.fromJSON(json["section"]),
        tourist: TouristApi.fromJSON(json["tourist"]));
  }

  static Map<String, dynamic> toMap(Trainer t) {
    return {
      "id": t.id,
      "salary": t.salary,
      "section": SectionApi.toMap(t.section),
      "tourist": TouristApi.toMap(t.tourist)
    };
  }

  @override
  Future<int?> create(Trainer value) {
    return _crudApi.create(value);
  }

  @override
  Future<bool> delete(Trainer value) {
    return _crudApi.delete(value);
  }

  @override
  Future<List<Trainer>?> getAll() {
    return _crudApi.getAll();
  }

  @override
  Future<bool> update(Trainer value) {
    return _crudApi.update(value);
  }
}