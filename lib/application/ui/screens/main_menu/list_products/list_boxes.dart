import 'package:flutter/material.dart';
import 'package:move/application/ui/navigations/main_navigation.dart';
import 'package:move/application/ui/screens/main_menu/list_products/menu_choose/list_boxes_model.dart';
import 'package:move/application/ui/themes/app_theme.dart';
import 'package:move/resources/resources.dart';
import 'package:provider/provider.dart';

class ListBoxesWidget extends StatelessWidget {
  const ListBoxesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
          child: AppBar(
            foregroundColor: AppTheme.foreGroundColor,
            centerTitle: false,
            title: const Text(
              'Главное меню',
              style: AppTheme.styleOfAppBarText,
            ),
            backgroundColor: AppTheme.appColor,
          ),
        ),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'СПИСОК КОРОБОК',
                    style: AppTheme.headerSmallTextStyle,
                  ),
                  const SizedBox(height: 5),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                        color: Colors.white,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 25,
                        ),
                        child: _GridViewWidget(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _GridViewWidget extends StatelessWidget {
  const _GridViewWidget();

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ListBoxesModel>();
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisExtent: 110,
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      itemCount: model.listBoxes.length,
      itemBuilder: (BuildContext context, int index) {
        final box = model.listBoxes[index];
        if (index == 0) {
          return ElevatedButton(
            onPressed: () => Navigator.of(context)
                .pushNamed(MainNavigationRouteNames.addBoxes),
            style: ButtonStyle(
              shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              backgroundColor: const WidgetStatePropertyAll(AppTheme.appColor),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 25,
                  ),
                  Expanded(
                    child: Text(
                      'Добавить новую коробку',
                      style: TextStyle(
                        letterSpacing: -0.41,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Stack(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black.withOpacity(0.1)),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  image: index == 1
                      ? const DecorationImage(
                          alignment: Alignment.centerRight,
                          image: AssetImage(
                            Images.containerBacjgroundOne,
                          ),
                        )
                      : const DecorationImage(
                          alignment: Alignment.centerRight,
                          image: AssetImage(
                            Images.containerBackgroundTwo,
                          ),
                        ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(5, 5),
                      blurRadius: 35,
                      spreadRadius: -25,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 1,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          child: Text(
                            box.title,
                            style: const TextStyle(
                              letterSpacing: -0.41,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Material(
                clipBehavior: Clip.hardEdge,
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  onTap: () => Navigator.of(context)
                      .pushNamed(MainNavigationRouteNames.showBoxes, arguments: index),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
