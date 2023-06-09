import 'package:flutter/material.dart';
import 'package:tourist_admin_panel/components/image_box.dart';
import 'package:tourist_admin_panel/components/slider_text_setter.dart';
import 'package:tourist_admin_panel/crud/crud_config.dart';
import 'package:tourist_admin_panel/crud/forms/base_form.dart';
import 'package:tourist_admin_panel/model/section_manager.dart';

import '../../components/input_label.dart';
import '../../config/config.dart';
import '../../services/service_io.dart';

class SectionManagerForm extends StatefulWidget {
  const SectionManagerForm({super.key, required this.onSubmit, this.initial});

  final Function(SectionManager) onSubmit;
  final SectionManager? initial;

  @override
  State<SectionManagerForm> createState() => _SectionManagerFormState();
}

class _SectionManagerFormState extends State<SectionManagerForm> {
  var builder = SectionManagerBuilder();
  var firstNameController = TextEditingController();
  var secondNameController = TextEditingController();
  static const defaultSalary = minSectionManagerSalary;
  static const defaultBirthYear = 1990;
  static const defaultEmploymentYear = 2010;
  final salaryNotifier = ValueNotifier(defaultSalary);

  @override
  void initState() {
    super.initState();
    salaryNotifier.addListener(updateSalary);
    if (widget.initial != null) {
      builder = SectionManagerBuilder.fromExisting(widget.initial!);
      firstNameController.text = builder.firstName;
      secondNameController.text = builder.secondName;
      salaryNotifier.value = builder.salary;
      return;
    }
    builder.birthYear = defaultBirthYear;
    builder.employmentYear = defaultEmploymentYear;
    builder.salary = defaultSalary;
    builder.id = 0;
  }

  @override
  void dispose() {
    super.dispose();
    salaryNotifier.removeListener(updateSalary);
  }

  void updateSalary() {
    builder.salary = salaryNotifier.value;
  }

  String get actionName => widget.initial == null ? "Create" : "Update";

  @override
  Widget build(BuildContext context) {
    return BaseForm(
        buildEntity: buildEntity,
        entityName: "section manager",
        formType: widget.initial == null ? FormType.create : FormType.update,
        body: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ImageBox(imageName: "manager.png"),
                const SizedBox(
                  width: Config.defaultPadding,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: Config.defaultPadding * 3,
                    ),
                    SizedBox(
                        width: BaseForm.defaultLabelWidth,
                        child: InputLabel(
                            controller: firstNameController,
                            hintText: "First name")),
                    const SizedBox(
                      height: Config.defaultPadding,
                    ),
                    SizedBox(
                        width: BaseForm.defaultLabelWidth,
                        child: InputLabel(
                            controller: secondNameController,
                            hintText: "Second name")),
                    const SizedBox(
                      height: Config.defaultPadding,
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: Config.defaultPadding,
            ),
            SliderTextSetter<int>(
                minVal: minSectionManagerSalary,
                maxVal: maxSectionManagerSalary,
                divisions:
                    (maxSectionManagerSalary - minSectionManagerSalary) ~/
                        salaryPortion,
                notifier: salaryNotifier,
                leadingText: "Select salary"),
            const SizedBox(
              height: Config.defaultPadding,
            ),
            Container(
              alignment: Alignment.center,
              child: Config.defaultText("Select birth year"),
            ),
            SizedBox(
              height: Config.pageHeight(context) * .2,
              width: 500,
              child: YearPicker(
                  firstDate: DateTime(1940),
                  lastDate: DateTime(2010),
                  selectedDate: DateTime(builder.birthYear),
                  currentDate: DateTime(builder.birthYear),
                  onChanged: (date) {
                    setState(() {
                      builder.birthYear = date.year;
                    });
                  }),
            ),
            const SizedBox(
              height: Config.defaultPadding,
            ),
            Container(
              alignment: Alignment.center,
              child: Config.defaultText("Select employment year"),
            ),
            SizedBox(
              height: Config.pageHeight(context) * .2,
              width: 500,
              child: YearPicker(
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2023),
                  selectedDate: DateTime(builder.employmentYear),
                  currentDate: DateTime(builder.employmentYear),
                  onChanged: (date) {
                    setState(() {
                      builder.employmentYear = date.year;
                    });
                  }),
            ),
          ],
        ));
  }

  void buildEntity() {
    builder.firstName = firstNameController.text;
    builder.secondName = secondNameController.text;
    if (builder.firstName.isEmpty) {
      ServiceIO().showMessage("First name must not be empty", context);
      return;
    }
    if (builder.secondName.isEmpty) {
      ServiceIO().showMessage("Second name must not be empty", context);
      return;
    }
    widget.onSubmit(builder.build());
  }
}
