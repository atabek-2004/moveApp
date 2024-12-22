import 'package:flutter/material.dart';
import 'package:move/application/ui/screens/main_menu/list_products/add_things_model.dart';
import 'package:move/application/ui/themes/app_theme.dart';
import 'package:provider/provider.dart';

class AddThingsWidget extends StatelessWidget {
  const AddThingsWidget({super.key});

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
              'Список вещей',
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

class _ContainerWidget extends StatelessWidget {
  const _ContainerWidget();

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AddThingsModel>(context, listen: false);
    return Container(
      width: double.infinity,
      height: 280,
      decoration: const BoxDecoration(
        color: AppTheme.containerColor,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          children: [
            _dataContainer(
              'Название',
              'Введите текст',
              model.titleController,
              model,
              context,
            ),
            _divider(),
            _dataContainer(
              'Описание',
              'Введите текст',
              model.descriptionContrller,
              model,
              context,
            ),
            _divider(),
            _dataCotainerRow(
              'Размер',
              'Введите текст',
              'см',
              model.sizeController,
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
              'Комментарий',
              'Необязательное поле',
              model.commentController,
              model,
              context,
            ),
            _divider(),
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
    return const Text('ДОБАВЛЕНИЕ ВЕЩИ', style: AppTheme.headerSmallTextStyle);
  }
}

class _ElevatedButtonAddWidget extends StatelessWidget {
  const _ElevatedButtonAddWidget();

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AddThingsModel>(context, listen: false);
    return ElevatedButton(
      style: AppTheme.buttonStyle,
      onPressed: () => model.saveThing(context),
      child: const Text(
        'Добавить',
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
    String text,
    String hintText,
    TextEditingController controller,
    AddThingsModel model,
    BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(left: 25),
    child: Row(
      children: [
        Text(
          text,
          style: AppTheme.mainMenuTextsStyle,
        ),
        const SizedBox(width: 30),
        Expanded(
          child: TextField(
            onChanged: (value) => controller.text = value,
            onEditingComplete: () => model.saveThing(context),
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
    String text,
    String hintText,
    String size,
    TextEditingController controller,
    AddThingsModel model,
    BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(left: 25),
    child: Row(
      children: [
        Text(
          text,
          style: AppTheme.mainMenuTextsStyle,
        ),
        const SizedBox(width: 50),
        Expanded(
          child: TextField(
            onChanged: (value) => controller.text = value,
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
            size,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    ),
  );
}
