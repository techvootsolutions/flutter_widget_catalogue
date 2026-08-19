import 'package:flutter_widget_catalogue/flutter_widget_catalogue.dart';
import 'rrect_path_provider.dart';

class StadiumPathProvider extends RRectPathProvider {
  const StadiumPathProvider({super.reclip})
      : super(
            const BorderRadius.all(
              Radius.circular(1000),
            ));
}
