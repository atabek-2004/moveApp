import 'package:flutter/material.dart';
import 'package:move/application/ui/screens/main_menu/list_products/menu_choose/menu_choose_thing_model.dart';
import 'package:move/application/ui/themes/app_theme.dart';
import 'package:provider/provider.dart';

class MenuChooseThingWidget extends StatelessWidget {
  const MenuChooseThingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MenuChooseThingModel>();
    const textStyle = TextStyle(
      color: AppTheme.appColor,
      fontWeight: FontWeight.w700,
      fontSize: 16,
      letterSpacing: -0.41,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leadingWidth: 110,
        leading: TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Row(
            children: [
              Icon(
                Icons.arrow_back_ios,
                color: AppTheme.appColor,
              ),
              Text(
                'Назад',
                style: textStyle,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => model.addThings(context),
              child: const Text(
                'Готово',
                style: textStyle,
              )),
        ],
        title: const Text(
          'Выберите вещи',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            letterSpacing: -0.41,
          ),
        ),
      ),
      body: const _MenuChooseThingWidgetBody(),
      backgroundColor: Colors.white,
    );
  }
}

class _MenuChooseThingWidgetBody extends StatelessWidget {
  const _MenuChooseThingWidgetBody();

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<MenuChooseThingModel>(listen: true, context);

    return Stack(
      children: [
        ListView.separated(
          padding: const EdgeInsets.only(top: 50),
          separatorBuilder: (BuildContext context, index) =>
              const Divider(height: 1),
          itemCount: model.listTings.length,
          itemBuilder: (BuildContext context, index) {
            final listBoxModel = context.watch<MenuChooseThingModel>();
            if (listBoxModel.listTings.isEmpty ||
                index >= listBoxModel.listTings.length) {
              return const SizedBox.shrink();
            }
            final thing = listBoxModel.listTings[index];
            return CheckboxListTile(
              value: model.listTings[index].checked,
              onChanged: (value) {
                model.funcChecked(index, value ?? false);
              },
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(thing.title),
            );
          },
        ),
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              onChanged: (value) => model.searchFunc(value),
              controller: model.textController,
              cursorHeight: 20,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                prefixIconColor: Colors.grey,
                hintText: 'Поиск',
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Colors.grey,
                ),
                isCollapsed: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                filled: true,
                fillColor: Color.fromARGB(12, 0, 0, 0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
