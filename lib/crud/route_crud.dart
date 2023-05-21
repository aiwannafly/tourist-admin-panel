import 'package:flutter/material.dart';
import 'package:tourist_admin_panel/components/route_type_view.dart';
import 'package:tourist_admin_panel/crud/base_crud.dart';

import '../api/route_api.dart';
import '../model/route.dart';
import 'forms/route_form.dart';

class RouteCRUD extends StatefulWidget {
  const RouteCRUD(
      {super.key,
        required this.items,
        this.onTap,
        this.itemHoverColor,
        required this.filtersFlex});

  final List<RouteTrip> items;
  final void Function(RouteTrip)? onTap;
  final Color? itemHoverColor;
  final int filtersFlex;

  @override
  State<RouteCRUD> createState() => _RouteCRUDState();
}

class _RouteCRUDState extends State<RouteCRUD> {
  List<RouteTrip> get items => widget.items;

  @override
  Widget build(BuildContext context) {
    return BaseCrud<RouteTrip>(
        title: "Routes",
        items: items,
        columns: [
          ColumnData<RouteTrip>(
              name: "ID",
              buildColumnElem: (e) => centeredText(e.id.toString()),
              flex: 1),
          ColumnData<RouteTrip>(
              name: "Name",
              buildColumnElem: (e) => centeredText(e.name),
              flex: 3),
          ColumnData<RouteTrip>(
              name: "Type",
              buildColumnElem: (e) => RouteTypeView(routeType: e.routeType),
              flex: 1)
        ],
        onTap: widget.onTap,
        itemHoverColor: widget.itemHoverColor,
        crudApi: RouteApi(),
        formBuilder: formBuilder,
        filters: buildFilters(),
        tailFlex: 1);
  }

  Widget formBuilder({required Function(RouteTrip) onSubmit, RouteTrip? initial}) {
    return RouteForm(
      onSubmit: onSubmit,
      initial: initial,
    );
  }

  Widget centeredText(String text) {
    return Center(
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  Widget buildFilters() {
    return Expanded(flex: widget.filtersFlex, child: Container());
  }
}