import 'package:flutter/material.dart';
import 'package:tourist_admin_panel/components/gender.dart';
import 'package:tourist_admin_panel/components/image_button.dart';
import 'package:tourist_admin_panel/components/range_slider.dart';
import 'package:tourist_admin_panel/components/selector_label.dart';
import 'package:tourist_admin_panel/crud/crud_config.dart';
import 'package:tourist_admin_panel/crud/query_forms/trainer_by_group_and_time_interval.dart';
import 'package:tourist_admin_panel/crud/query_forms/trainer_work_hours.dart';
import 'package:tourist_admin_panel/model/tourist.dart';
import 'package:tourist_admin_panel/services/service_io.dart';

import '../../config/config.dart';
import '../../model/trainer.dart';
import '../../responsive.dart';

class TrainerFilters extends StatelessWidget {
  const TrainerFilters(
      {super.key, required this.onChange, required this.onFound});

  final VoidCallback onChange;
  final void Function(List<Trainer> trainers) onFound;

  static final Set<Gender> selectedGenders = Gender.values.toSet();
  static final ageRangeNotifier = ValueNotifier(const RangeValues(18, 40));
  static final salaryRangeNotifier = ValueNotifier(
      RangeValues(minTrainerSalary.toDouble(), maxTrainerSalary.toDouble()));

  @override
  Widget build(BuildContext context) {
    if (!Responsive.isDesktop(context)) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child: buildSelector(context,
                      prefix: "Gender",
                      items: Gender.values,
                      selectedItems: selectedGenders,
                      itemBuilder: (i) => GenderView(gender: i))),
              Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Config.defaultText("Age"),
                      IntRangeSlider(
                          min: 16, max: 40, rangeNotifier: ageRangeNotifier)
                    ],
                  )),
              Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Config.defaultText("Salary"),
                      IntRangeSlider(
                          min: minTrainerSalary,
                          max: maxTrainerSalary,
                          divisions: (maxTrainerSalary - minTrainerSalary) ~/
                              salaryPortion,
                          rangeNotifier: salaryRangeNotifier)
                    ],
                  )),
            ],
          ),
          const SizedBox(
            height: Config.defaultPadding,
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    ImageButton(
                        onPressed: () => selectByGroupAndTimeInterval(context),
                        text: "Select by group",
                        imageName: "group.png"),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    ImageButton(
                        onPressed: () => getWorkHours(context),
                        text: "Get work hours",
                        imageName: "time.png"),
                  ],
                ),
              ),
              const Spacer()
            ],
          ),
        ],
      );
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Config.defaultText("Filters"),
      const SizedBox(
        height: Config.defaultPadding,
      ),
      buildSelector(context,
          prefix: "Gender",
          items: Gender.values,
          selectedItems: selectedGenders,
          itemBuilder: (i) => GenderView(gender: i)),
      const SizedBox(
        height: Config.defaultPadding,
      ),
      Config.defaultText("Age"),
      Row(
        children: [
          Expanded(
              flex: 2,
              child: IntRangeSlider(
                  min: 16, max: 40, rangeNotifier: ageRangeNotifier)),
          const Spacer(
            flex: 1,
          )
        ],
      ),
      const SizedBox(
        height: Config.defaultPadding,
      ),
      Config.defaultText("Salary"),
      Row(
        children: [
          Expanded(
              flex: 2,
              child: IntRangeSlider(
                  min: minTrainerSalary,
                  max: maxTrainerSalary,
                  divisions:
                      (maxTrainerSalary - minTrainerSalary) ~/ salaryPortion,
                  rangeNotifier: salaryRangeNotifier)),
          const Spacer(
            flex: 1,
          )
        ],
      ),
      const SizedBox(
        height: Config.defaultPadding,
      ),
      ImageButton(
          onPressed: () => selectByGroupAndTimeInterval(context),
          text: "Select by group",
          imageName: "group.png"),
      const SizedBox(
        height: Config.defaultPadding,
      ),
      ImageButton(
          onPressed: () => getWorkHours(context),
          text: "Get work hours",
          imageName: "time.png")
    ]);
  }

  void selectByGroupAndTimeInterval(BuildContext context) {
    ServiceIO().showWidget(context,
        child: TrainerByGroupAndTimeInterval(
          onFound: onFound,
        ));
  }

  void getWorkHours(BuildContext context) {
    ServiceIO().showWidget(context,
        child: const TrainerWorkHours());
  }

  Widget buildSelector<T>(BuildContext context,
      {required String prefix,
      required List<T> items,
      required Widget Function(T) itemBuilder,
      required Set<T> selectedItems}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Config.defaultText(prefix),
        const SizedBox(
          height: Config.defaultPadding,
        ),
        SelectorLabel(
          items: items,
          itemBuilder: itemBuilder,
          selectedItems: selectedItems,
          onChange: onChange,
        )
      ],
    );
  }
}
