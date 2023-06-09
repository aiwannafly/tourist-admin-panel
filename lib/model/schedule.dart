import 'package:flutter/material.dart';
import 'package:tourist_admin_panel/model/base_entity.dart';
import 'package:tourist_admin_panel/model/group.dart';

enum DayOfWeek {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday
}

extension DayOfWeekExtension on DayOfWeek {
  static DayOfWeek fromString(String s) {
    s = s.toLowerCase();
    return DayOfWeek.values.firstWhere((e) => e.toString() == 'DayOfWeek.$s');
  }

  String get string {
    return toString().substring("DayOfWeek.".length).toUpperCase();
  }
}

class ScheduleBuilder {
  late int id;
  late Group group;
  late DayOfWeek dayOfWeek;
  late TimeOfDay timeOfDay;
  late int durationMins;

  ScheduleBuilder();

  ScheduleBuilder.fromExisting(Schedule s) {
    id = s.id;
    group = s.group;
    dayOfWeek = s.dayOfWeek;
    timeOfDay = s.timeOfDay;
    durationMins = s.durationMins;
  }

  Schedule build() {
    return Schedule(
        id: id, group: group, dayOfWeek: dayOfWeek, timeOfDay: timeOfDay,
    durationMins: durationMins);
  }
}

class Schedule extends BaseEntity {
  final Group group;
  final DayOfWeek dayOfWeek;
  final TimeOfDay timeOfDay;
  final int durationMins;

  Schedule(
      {required super.id,
      required this.group,
      required this.durationMins,
      required this.dayOfWeek,
      required this.timeOfDay});
}
