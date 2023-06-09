import 'package:flutter/cupertino.dart';
import 'package:tourist_admin_panel/model/route.dart';

class RouteTypeView extends StatelessWidget {
  const RouteTypeView({super.key, required this.routeType,
  this.size = 30});

  final RouteType routeType;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: size,
      width: size,
      child: Image.asset(
          "assets/images/${routeType.string.toLowerCase()}.png"),);
  }
}
