import 'package:tourist_admin_panel/model/base_entity.dart';
import 'package:tourist_admin_panel/model/tourist.dart';

class CompetitionBuilder {
  late int id;
  late String name;
  late DateTime date;
  late List<Tourist> tourists;

  CompetitionBuilder();

  CompetitionBuilder.fromExisting(Competition c) {
    id = c.id;
    name = c.name;
    date = c.date;
    tourists = c.tourists;
  }

  Competition build() {
    return Competition(id: id, name: name, date: date, tourists: tourists);
  }
}

class Competition extends BaseEntity {
  int id;
  final String name;
  final DateTime date;
  final List<Tourist> tourists;

  Competition(
      {required this.id,
      required this.name,
      required this.date,
      required this.tourists});

  @override
  int getId() {
    return id;
  }

  @override
  void setId(int id) {
    this.id = id;
  }
}
