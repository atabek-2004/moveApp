import 'package:flutter/material.dart';
import 'package:move/application/ui/navigations/main_navigation.dart';
import 'package:move/application/ui/screens/main_menu/list_products/add_boxes_model.dart';
import 'package:move/application/ui/themes/app_theme.dart';
import 'package:provider/provider.dart';

class AddBoxesWidget extends StatelessWidget {
  const AddBoxesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
              'Список коробок',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 20,
                letterSpacing: -0.40799999237060547,
                fontFamily: 'Open Sans',
              ),
            ),
            backgroundColor: AppTheme.appColor,
          ),
        ),
      ),
      body: const _AddThingsBody(),
      backgroundColor: AppTheme.scaffoldBackgroundColor,
    );
  }
}

class _AddThingsBody extends StatelessWidget {
  const _AddThingsBody();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _HeaderTextWidget(),
                    const SizedBox(height: 5),
                    const _ContainerWidget(),
                    const SizedBox(height: 30),
                    const Text(
                      'СПИСОК ВЕЩЕЙ',
                      style: AppTheme.headerSmallTextStyle,
                    ),
                    const SizedBox(height: 5),
                    const _SmallContainerWidget(),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 30),
                        width: double.infinity,
                        height: 44,
                        child: const _ElevatedButtonAddWidget(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SmallContainerWidget extends StatelessWidget {
  const _SmallContainerWidget();

  @override
  Widget build(BuildContext context) {
   
    return Stack(
      children: [
        Container(
          height: 56,
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: Colors.white,
          ),
          child: Row(
            children: [
              const SizedBox(width: 5),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add),
                color: AppTheme.appColor,
                iconSize: 25,
              ),
              const Text(
                'Добавить вещи',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  letterSpacing: -0.41,
                ),
              ),
            ],
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              onTap: () => Navigator.of(context)
                  .pushNamed(MainNavigationRouteNames.menuChooseThing),
            ),
          ),
        ),
      ],
    );
  }
}


class _ContainerWidget extends StatelessWidget {
  const _ContainerWidget();

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AddBoxesModel>(context, listen: false);
    return Container(
      width: double.infinity,
      height: 225,
      decoration: const BoxDecoration(
        color: AppTheme.containerColor,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _dataContainer(
              'Введите текст',
              'Название',
              model.titleController,
              model,
              context,
            ),
            _divider(),
            _dataCotainerRow(
              'Габариты',
              'Введите текст',
              'см',
              model.dimensionsContrller,
              model,
              context,
            ),
            _divider(),
            _dataCotainerRow(
              'Вес',
              'Введите текст',
              'кг',
              model.weightController,
              model,
              context,
            ),
            _divider(),
            _dataContainer(
              'Необязательное поле',
              'Комментарий',
              model.commentController,
              model,
              context,
            ),
            _divider(),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}

class _HeaderTextWidget extends StatelessWidget {
  const _HeaderTextWidget();

  @override
  Widget build(BuildContext context) {
    return const Text('ДОБАВЛЕНИЕ НОВОЙ КОРОБКИ',
        style: AppTheme.headerSmallTextStyle);
  }
}

class _ElevatedButtonAddWidget extends StatelessWidget {
  const _ElevatedButtonAddWidget();

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AddBoxesModel>(context, listen: false);
    return ElevatedButton(
      style: AppTheme.buttonStyle,
      onPressed: () => model.saveBox(context),
      child: const Text(
        'Готово',
        style: AppTheme.buttonTextStyle,
      ),
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

Widget _dataContainer(
  String hintText,
  String title,
  TextEditingController controller,
  AddBoxesModel model,
  BuildContext context,
) {
  return Container(
    margin: const EdgeInsets.only(left: 25),
    child: Row(
      children: [
        Text(
          title,
          style: AppTheme.mainMenuTextsStyle,
        ),
        const SizedBox(width: 30),
        Expanded(
          child: TextField(
            onChanged: (value) => controller.text = value,
            onEditingComplete: () => model.saveBox(context),
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.grey),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _dataCotainerRow(
  String title,
  String hintText,
  String weight,
  TextEditingController controller,
  AddBoxesModel model,
  BuildContext context,
) {
  return Container(
    margin: const EdgeInsets.only(left: 25),
    child: Row(
      children: [
        Text(
          title,
          style: AppTheme.mainMenuTextsStyle,
        ),
        const SizedBox(width: 50),
        Expanded(
          child: TextField(
            onChanged: (value) => controller.text = value,
            onEditingComplete: () => model.saveBox(context),
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.grey),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          margin: const EdgeInsets.only(right: 20),
          child: Text(
            weight,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    ),
  );
}
