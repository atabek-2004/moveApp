import 'package:flutter/material.dart';
import 'package:move/application/ui/screens/main_menu/list_products/add_boxes.dart';
import 'package:move/application/ui/screens/main_menu/list_products/add_boxes_model.dart';
import 'package:move/application/ui/screens/main_menu/list_products/add_things.dart';
import 'package:move/application/ui/screens/main_menu/list_products/add_things_model.dart';
import 'package:move/application/ui/screens/main_menu/list_products/list_boxes.dart';
import 'package:move/application/ui/screens/main_menu/list_products/list_delivers.dart';
import 'package:move/application/ui/screens/main_menu/list_products/list_things.dart';
import 'package:move/application/ui/screens/main_menu/list_products/list_things_model.dart';
import 'package:move/application/ui/screens/main_menu/list_products/menu_choose/list_boxes_model.dart';
import 'package:move/application/ui/screens/main_menu/list_products/menu_choose/menu_choose_thing.dart';
import 'package:move/application/ui/screens/main_menu/list_products/menu_choose/menu_choose_thing_model.dart';
import 'package:move/application/ui/screens/main_menu/main_menu.dart';
import 'package:move/application/ui/screens/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

class ScreenFactory {
  Widget makeSplashScreen() => const SplashScreen();
  Widget makePageView() => PageView();
  Widget makeMainMenu() => ChangeNotifierProvider(
        create: (_) => ListThingsModel(),
        child: const MainMenuWidget(),
      );
  Widget makeListThings() => ChangeNotifierProvider(
        create: (_) => ListThingsModel(),
        child: const ListThingsWidget(),
      );
  Widget makeListBoxes() => ChangeNotifierProvider(
        create: (_) => ListBoxesModel(),
        child: const ListBoxesWidget(),
      );
  Widget makeListDelivers() => const ListDeliversWidget();
  Widget makeAddThings() => Provider(
        create: (_) => AddThingsModel(),
        child: const AddThingsWidget(),
      );
  Widget makeAddBoxes() => Provider(
        create: (_) => AddBoxesModel(),
        child: const AddBoxesWidget(),
      );
  Widget makeMenuChooseThing() => ChangeNotifierProvider(create: (_) => MenuChooseThingModel(), child: const MenuChooseThingWidget(),);
}
