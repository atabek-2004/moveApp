import 'package:flutter/material.dart';
import 'package:move/application/ui/screen_factory/screen_factory.dart';
import 'package:move/application/ui/screens/main_menu/list_products/edit_box.dart';
import 'package:move/application/ui/screens/main_menu/list_products/edit_things.dart';
import 'package:move/application/ui/screens/main_menu/list_products/list_things_model.dart';
import 'package:move/application/ui/screens/main_menu/list_products/menu_choose/list_boxes_model.dart';
import 'package:move/application/ui/screens/main_menu/list_products/show_boxes.dart';
import 'package:move/application/ui/screens/main_menu/list_products/show_things.dart';
import 'package:provider/provider.dart';

abstract class MainNavigationRouteNames {
  static const splashScreen = '/';
  static const pageView = '/page_view';
  static const mainMenu = '/page_view/main_menu';
  static const listThings = '/page_view/main_menu/list_things';
  static const listBoxes = '/page_view/main_menu/list_boxes';
  static const listDelivers = '/page_view/main_menu/list_delivers';
  static const addThings = '/page_view/main_menu/add_things';
  static const showThings = '/page_view/main_menu/list_things/show_things';
  static const editThing =
      '/page_view/main_menu/list_things/show_things/edit_thing';
  static const addBoxes = '/page_view/main_menu/list_things/add_boxes';
  static const menuChooseThing =
      '/page_view/main_menu/list_things/add_boxes/menu_choose_thing';
  static const showBoxes = '/page_view/main_menu/list_boxes/show_boxes';
  static const editBox = '/page_view/main_menu/list_boxes/show_boxes/edit_box';
}

class MainNavigation {
  final initialRoute = MainNavigationRouteNames.splashScreen;
  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.splashScreen: (_) =>
        ScreenFactory().makeSplashScreen(),
    MainNavigationRouteNames.pageView: (_) => ScreenFactory().makePageView(),
    MainNavigationRouteNames.mainMenu: (_) => ScreenFactory().makeMainMenu(),
    MainNavigationRouteNames.listThings: (_) =>
        ScreenFactory().makeListThings(),
    MainNavigationRouteNames.listBoxes: (_) => ScreenFactory().makeListBoxes(),
    MainNavigationRouteNames.listDelivers: (_) =>
        ScreenFactory().makeListDelivers(),
    MainNavigationRouteNames.addThings: (_) => ScreenFactory().makeAddThings(),
    MainNavigationRouteNames.addBoxes: (_) => ScreenFactory().makeAddBoxes(),
    MainNavigationRouteNames.menuChooseThing: (_) =>
        ScreenFactory().makeMenuChooseThing(),
  };
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.showThings:
        final arg = settings.arguments;
        final thingIndex = arg is int ? arg : 0;
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => ListThingsModel(),
            child: ShowThings(indexThing: thingIndex),
          ),
        );
      case MainNavigationRouteNames.editThing:
        final arg = settings.arguments;
        final thingIndex = arg is int ? arg : 0;
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
              create: (_) => ListThingsModel(),
              child: EditThings(indexThing: thingIndex)),
        );
      case MainNavigationRouteNames.showBoxes:
        final arg = settings.arguments;
        final boxIndex = arg is int ? arg : 0;
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => ListBoxesModel(),
            child: ShowBoxesWidget(indexBox: boxIndex),
          ),
        );
        case MainNavigationRouteNames.editBox:
        final arg = settings.arguments;
        final boxIndex = arg is int ? arg : 0;
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
              create: (_) => ListBoxesModel(),
              child: EditBoxWidget(indexBox: boxIndex)),
        );
      default:
        return MaterialPageRoute(builder: (_) => const Text('Error'));
    }
  }
}
