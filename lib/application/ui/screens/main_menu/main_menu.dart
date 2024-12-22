import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:move/application/ui/navigations/main_navigation.dart';
import 'package:move/application/ui/screens/main_menu/list_products/list_things_model.dart';
import 'package:move/application/ui/themes/app_theme.dart';
import 'package:move/resources/resources.dart';
import 'package:provider/provider.dart';

class MainMenuWidget extends StatelessWidget {
  const MainMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55.h),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12.r),
            bottomRight: Radius.circular(12.r),
          ),
          child: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Главное меню', style: AppTheme.styleOfAppBarText),
                Row(
                  children: [
                    SizedBox(
                      width: 40.w,
                      height: 40.h,
                      child: IconButton(
                        color: Colors.white,
                        onPressed: () {},
                        icon: const Icon(Icons.article),
                      ),
                    ),
                    SizedBox(
                      width: 40.w,
                      height: 40.h,
                      child: IconButton(
                        color: Colors.white,
                        onPressed: () {},
                        icon: const Icon(Icons.settings),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            backgroundColor: AppTheme.appColor,
          ),
        ),
      ),
      body: const _MainMenuWidgetBody(),
    );
  }
}

class _MainMenuWidgetBody extends StatelessWidget {
  const _MainMenuWidgetBody();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: double.infinity,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: const [
              SizedBox(height: 20),
              _ThingContainerWidget(),
              SizedBox(height: 20),
              _BoxContainerWidget(),
              SizedBox(height: 20),
              _DeliveryContainerWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ThingContainerWidget extends StatelessWidget {
  const _ThingContainerWidget();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 270,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            child: Column(
              children: [
                const Row(
                  children: [
                    Image(
                      width: 40,
                      height: 20,
                      image: AssetImage(Images.rectanglesGroupFill),
                    ),
                    Text(
                      'Вещи',
                      style: AppTheme.thingBoxDeliverTextStyle,
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 35, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Добавить вещь',
                          style: AppTheme.mainMenuTextsStyle),
                      IconButton(
                        onPressed: () => Navigator.of(context)
                            .pushNamed(MainNavigationRouteNames.addThings),
                        icon: const Icon(Icons.add),
                        color: AppTheme.appColor,
                        iconSize: 30,
                      ),
                    ],
                  ),
                ),
                _divider(),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 15, right: 15),
                    child: const _ListViewSeparatedWidget(),
                  ),
                ),
              ],
            ),
          ),
        ),
        const _ElevatedButtonWidgetThing(),
      ],
    );
  }
}

Widget _divider() {
  return Container(
    margin: const EdgeInsets.only(right: 15, left: 15),
    height: 0.5,
    width: double.infinity,
    color: Colors.black54,
  );
}

class _ListViewSeparatedWidget extends StatefulWidget {
  const _ListViewSeparatedWidget();

  @override
  State<_ListViewSeparatedWidget> createState() =>
      _ListViewSeparatedWidgetState();
}

class _ListViewSeparatedWidgetState extends State<_ListViewSeparatedWidget> {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<ListThingsModel>();
    
    return ListView.separated(
      separatorBuilder: (BuildContext context, index) => const Divider(),
      itemCount: model.listTings.length > 2 ? 2 : model.listTings.length,
      itemBuilder: (BuildContext context, index) {
        final thing = model.listTings[index];
        return Padding(
          padding: const EdgeInsets.only(left: 22, top: 10, right: 5),
          child: Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  thing.title,
                  style: AppTheme.mainMenuTextsStyle,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget _sizedBoxOfButtons(String text, BuildContext context, String path) {
  return Container(
    margin: const EdgeInsets.only(left: 20, right: 20, top: 210),
    child: SizedBox(
      width: double.infinity,
      height: 44,
      child: ElevatedButton(
        style: AppTheme.buttonStyle,
        onPressed: () => Navigator.of(context).pushNamed(path),
        child: Text(
          text,
          style: AppTheme.buttonTextStyle,
        ),
      ),
    ),
  );
}

class _ElevatedButtonWidgetThing extends StatelessWidget {
  const _ElevatedButtonWidgetThing();

  @override
  Widget build(BuildContext context) {
    return _sizedBoxOfButtons(
        'Открыть полный список', context, MainNavigationRouteNames.listThings);
  }
}

class _ElevatedButtonWidgetBox extends StatelessWidget {
  const _ElevatedButtonWidgetBox();

  @override
  Widget build(BuildContext context) {
    return _sizedBoxOfButtons(
        'Открыть полный список', context, MainNavigationRouteNames.listBoxes);
  }
}

class _ElevatedButtonWidgetDeliver extends StatelessWidget {
  const _ElevatedButtonWidgetDeliver();

  @override
  Widget build(BuildContext context) {
    return _sizedBoxOfButtons('Открыть полный список', context,
        MainNavigationRouteNames.listDelivers);
  }
}

class _BoxContainerWidget extends StatelessWidget {
  const _BoxContainerWidget();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 270,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            child: Column(
              children: [
                const Row(
                  children: [
                    Image(
                      width: 40,
                      height: 20,
                      image: AssetImage(Images.shippingboxFill),
                    ),
                    Text(
                      'Коробки',
                      style: AppTheme.thingBoxDeliverTextStyle,
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 35, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Собрать новую коробку',
                          style: AppTheme.mainMenuTextsStyle),
                      IconButton(
                        onPressed: () => Navigator.of(context).pushNamed(MainNavigationRouteNames.addBoxes),
                        icon: const Icon(Icons.add),
                        color: AppTheme.appColor,
                        iconSize: 30,
                      ),
                    ],
                  ),
                ),
                _divider(),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 15, right: 15),
                    child: const _ListSeparatedWidgetBoxs(),
                  ),
                ),
              ],
            ),
          ),
        ),
        const _ElevatedButtonWidgetBox(),
      ],
    );
  }
}

class _ListSeparatedWidgetBoxs extends StatelessWidget {
  const _ListSeparatedWidgetBoxs();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (BuildContext context, index) => const Divider(),
      itemCount: 2,
      itemBuilder: (BuildContext context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 22, top: 10, right: 5),
          child: Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
              ),
              const SizedBox(width: 15),
              const Expanded(
                child: Text(
                  'Коробка  с верхней одеждой',
                  style: AppTheme.mainMenuTextsStyle,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DeliveryContainerWidget extends StatelessWidget {
  const _DeliveryContainerWidget();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 300,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            child: Column(
              children: [
                const Row(
                  children: [
                    Image(
                      width: 40,
                      height: 20,
                      image: AssetImage(Images.shippingTruck),
                    ),
                    Text(
                      'Доставки',
                      style: AppTheme.thingBoxDeliverTextStyle,
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 35, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Оформить новую доставку',
                          style: AppTheme.mainMenuTextsStyle),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.add),
                        color: AppTheme.appColor,
                        iconSize: 30,
                      ),
                    ],
                  ),
                ),
                _divider(),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 15, right: 15),
                    child: const _ListSeparatedWidgetDelivery(),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Positioned(
          bottom: 15,
          left: 0,
          right: 0,
          child: _ElevatedButtonWidgetDeliver(),
        ),
      ],
    );
  }
}

class _ListSeparatedWidgetDelivery extends StatelessWidget {
  const _ListSeparatedWidgetDelivery();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (BuildContext context, index) => const Divider(),
      itemCount: 2,
      itemBuilder: (BuildContext context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 5, top: 5, right: 5),
          child: ListTile(
            onTap: () {},
            minTileHeight: 0,
            title: const Text(
              'Вся одежда',
              style: AppTheme.mainMenuTextsStyle,
            ),
            subtitle: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Готовы к доставке',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            trailing: const Icon(Icons.chevron_right),
          ),
        );
      },
    );
  }
}
