import 'package:flutter/material.dart';
import 'package:move/application/ui/navigations/main_navigation.dart';
import 'package:move/application/ui/screens/main_menu/list_products/list_things_model.dart';
import 'package:move/application/ui/themes/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ListThingsWidget extends StatelessWidget {
  const ListThingsWidget({super.key});

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
      body: const _ListOfThingsBody(),
    );
  }
}

class _ListOfThingsBody extends StatelessWidget {
  const _ListOfThingsBody();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: ListView(
        children: const [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'СПИСОК ВЕЩЕЙ',
                style: AppTheme.headerSmallTextStyle,
              ),
              SizedBox(height: 5),
              _ThingsContainerWidget(),
            ],
          ),
        ],
      ),
    );
  }
}

class _ThingsContainerWidget extends StatelessWidget {
  const _ThingsContainerWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            const _ElevatedButtonWidget(),
            SizedBox(height: 10.h),
            const _ListViewSeparatedWidget(),
          ],
        ),
      ),
    );
  }
}

class _ElevatedButtonWidget extends StatelessWidget {
  const _ElevatedButtonWidget();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 44.h,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0.r),
            ),
          ),
          backgroundColor: const WidgetStatePropertyAll(AppTheme.appColor),
          foregroundColor:
              const WidgetStatePropertyAll(AppTheme.foreGroundColor),
        ),
        onPressed: () =>
            Navigator.of(context).pushNamed(MainNavigationRouteNames.addThings),
        child: const Text(
          'Добавить новую вещь',
          style: AppTheme.buttonTextStyle,
        ),
      ),
    );
  }
}

class _ListViewSeparatedWidget extends StatelessWidget {
  const _ListViewSeparatedWidget();

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ListThingsModel>();
    return LayoutBuilder(
      builder: (context, constraints) {
        final int itemCount = model.listTings.length;
        const double itemHeight = 56.0;
        final double calculatedHeight = itemCount * itemHeight;
        final double maxHeight = calculatedHeight < constraints.maxHeight
            ? calculatedHeight
            : constraints.maxHeight;

        return Container(
          width: double.infinity,
          constraints: BoxConstraints(
            minHeight: 0.0, 
            maxHeight: maxHeight,
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (BuildContext context, index) => const Divider(
              height: 1,
            ),
            itemCount: itemCount,
            itemBuilder: (BuildContext context, index) {
              final thing = model.listTings[index];
              return ListTile(
                onTap: () => Navigator.of(context).pushNamed(
                  MainNavigationRouteNames.showThings,
                  arguments: index,
                ),
                title: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
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
                      Expanded(child: Text(thing.title)),
                    ],
                  ),
                ),
                trailing: const Icon(Icons.chevron_right),
              );
            },
          ),
        );
      },
    );
  }
}
