import 'package:flutter/cupertino.dart';
import 'package:tourist_admin_panel/api/instructor_api.dart';
import 'package:tourist_admin_panel/crud/sportsman_crud.dart';
import 'package:tourist_admin_panel/model/competition.dart';
import 'package:tourist_admin_panel/model/sportsman.dart';

import '../../api/activity_api.dart';
import '../../api/group_api.dart';
import '../../api/route_api.dart';
import '../../api/schedule_api.dart';
import '../../api/trainer_api.dart';
import '../../api/trip_api.dart';
import '../../crud/activity_crud.dart';
import '../../crud/group_crud.dart';
import '../../crud/route_crud.dart';
import '../../crud/schedule_crud.dart';
import '../../crud/section_manager_crud.dart';
import '../../crud/trainer_crud.dart';
import '../../crud/trip_crud.dart';
import '../../model/activity.dart';
import '../../model/section.dart';
import '../../model/trip.dart';

import 'package:tourist_admin_panel/api/section_api.dart';
import 'package:tourist_admin_panel/api/section_manager_api.dart';
import 'package:tourist_admin_panel/api/tourist_api.dart';
import 'package:tourist_admin_panel/crud/base_crud_future_builder.dart';
import 'package:tourist_admin_panel/crud/section_crud.dart';
import 'package:tourist_admin_panel/crud/tourist_crud.dart';
import 'package:tourist_admin_panel/model/group.dart';
import 'package:tourist_admin_panel/model/route.dart';
import 'package:tourist_admin_panel/model/schedule.dart';
import 'package:tourist_admin_panel/model/section_manager.dart';
import 'package:tourist_admin_panel/model/tourist.dart';
import 'package:tourist_admin_panel/model/trainer.dart';

import '../api/competition_api.dart';
import '../api/sportsman_api.dart';
import 'competition_crud.dart';
import 'instructor_crud.dart';

enum CRUD {
  tourists,
  groups,
  sectionManagers,
  sections,
  trainers,
  schedules,
  activities,
  routes,
  trips,
  instructors,
  competitions,
  sportsmen
}

extension CRUDBuilder on CRUD {
  Type entityType() {
    return switch (this) {
      CRUD.tourists => Tourist,
      CRUD.groups => Group,
      CRUD.sectionManagers => SectionManager,
      CRUD.sections => Section,
      CRUD.trainers => Trainer,
      CRUD.schedules => Schedule,
      CRUD.activities => Activity,
      CRUD.routes => Route,
      CRUD.trips => Trip,
      CRUD.competitions => Competition,
      CRUD.instructors => Tourist,
      CRUD.sportsmen => Sportsman
    };
  }

  Widget build() {
    return switch (this) {
      CRUD.tourists => ItemsFutureBuilder<Tourist>(
          itemsGetter: TouristApi().findByGenderAndSkill(),
          contentBuilder: (tourists) => TouristCRUD(
            tourists: tourists,
            filtersFlex: 2,
          ),
        ),
      CRUD.groups => ItemsFutureBuilder<Group>(
          itemsGetter: GroupApi().getAll(),
          contentBuilder: (items) => GroupCRUD(
            items: items,
            filtersFlex: 3,
          ),
        ),
      CRUD.sections => ItemsFutureBuilder<Section>(
          itemsGetter: SectionApi().getAll(),
          contentBuilder: (sections) => SectionCRUD(
            sections: sections,
            filtersFlex: 3,
          ),
        ),
      CRUD.trainers => ItemsFutureBuilder<Trainer>(
          itemsGetter: TrainerApi().findByGenderAndAgeAndSalary(),
          contentBuilder: (trainers) => TrainerCRUD(
            trainers: trainers,
            filtersFlex: 2,
          ),
        ),
      CRUD.sectionManagers => ItemsFutureBuilder<SectionManager>(
          itemsGetter: SectionManagerApi().findByGenderAndAgeAndSalary(),
          contentBuilder: (sectionManagers) => SectionManagerCRUD(
            sectionManagers: sectionManagers,
            filtersFlex: 2,
          ),
        ),
      CRUD.schedules => ItemsFutureBuilder<Schedule>(
          itemsGetter: ScheduleApi().getAll(),
          contentBuilder: (items) => ScheduleCRUD(
            items: items,
            filtersFlex: 0,
          ),
        ),
      CRUD.activities => ItemsFutureBuilder<Activity>(
          itemsGetter: ActivityApi().getAll(),
          contentBuilder: (items) => ActivityCRUD(
            items: items,
            filtersFlex: 2,
          ),
        ),
      CRUD.routes => ItemsFutureBuilder<RouteTrip>(
          itemsGetter: RouteApi().getAll(),
          contentBuilder: (items) => RouteCRUD(
            items: items,
            filtersFlex: 3,
          ),
        ),
      CRUD.trips => ItemsFutureBuilder<Trip>(
          itemsGetter: TripApi().getAll(),
          contentBuilder: (items) => TripCRUD(
            items: items,
            filtersFlex: 1,
          ),
        ),
      CRUD.competitions => ItemsFutureBuilder<Competition>(
          itemsGetter: CompetitionApi().getAll(),
          contentBuilder: (items) => CompetitionCRUD(
            items: items,
            filtersFlex: 3,
          ),
        ),
      CRUD.instructors => ItemsFutureBuilder<Tourist>(
          itemsGetter: InstructorApi().getAll(),
          contentBuilder: (tourists) => InstructorCRUD(
            tourists: tourists,
            filtersFlex: 2,
          ),
        ),
      CRUD.sportsmen => ItemsFutureBuilder<Sportsman>(
          itemsGetter: SportsmanApi().getAll(),
          contentBuilder: (sportsmen) => SportsmanCRUD(
            sportsmen: sportsmen,
            filtersFlex: 2,
          ),
        ),
    };
  }
}
