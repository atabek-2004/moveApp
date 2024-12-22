import 'package:flutter/material.dart';
import 'package:move/application/ui/navigations/main_navigation.dart';
import 'package:move/application/ui/screens/main_menu/list_products/menu_choose/list_boxes_model.dart';
import 'package:move/application/ui/themes/app_theme.dart';
import 'package:provider/provider.dart';

class ShowBoxesWidget extends StatelessWidget {
  final int indexBox;
  const ShowBoxesWidget({super.key, required this.indexBox});

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
      backgroundColor: AppTheme.scaffoldBackgroundColor,
      body: _ShowBoxesBody(index: indexBox),
    );
  }
}

class _ShowBoxesBody extends StatelessWidget {
  final int index;
  const _ShowBoxesBody({required this.index});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _HeaderFirstRowWidget(index: index),
                  const _HeaderRowSecondWidget(),
                  const SizedBox(height: 7),
                  _ContainerWidget(
                    index: index,
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'СПИСОК ВЕЩЕЙ',
                    style: AppTheme.headerSmallTextStyle,
                  ),
                  const SizedBox(height: 5),
                  const _SmallContainerWidget(),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class _HeaderRowSecondWidget extends StatelessWidget {
  const _HeaderRowSecondWidget();

  @override
  Widget build(BuildContext context) {
    return Row(
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
          'В СБОРКЕ',
          style: AppTheme.headerSmallTextStyle,
        ),
      ],
    );
  }
}

class _HeaderFirstRowWidget extends StatelessWidget {
  final int index;
  const _HeaderFirstRowWidget({required this.index});

  @override
  Widget build(BuildContext context) {
    final model = context.read<ListBoxesModel>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'ПРОСМОТР КОРОБКИ',
          style: AppTheme.headerSmallTextStyle,
        ),
        IconButton(
          onPressed: () => _showActionDialog(context, index, model),
          icon: const Icon(
            Icons.more_horiz,
            color: AppTheme.appColor,
            size: 30,
          ),
        ),
      ],
    );
  }
}

class _ContainerWidget extends StatelessWidget {
  final int index;
  const _ContainerWidget({required this.index});

  @override
  Widget build(BuildContext context) {
    final listBoxModel = context.watch<ListBoxesModel>();
    if (listBoxModel.listBoxes.isEmpty ||
        index >= listBoxModel.listBoxes.length) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    final box = context.read<ListBoxesModel>().listBoxes[index];
    return Container(
      width: double.infinity,
      height: 280,
      decoration: const BoxDecoration(
        color: AppTheme.containerColor,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _dataContainer('Название', box.title),
            _divider(),
            _dataCotainerRow('Габариты', box.dimensions, 'см'),
            _divider(),
            _dataCotainerRow('Вес', box.weight, 'кг'),
            _divider(),
            _dataContainer('Комментарий', box.comment ?? ''),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

void _showActionDialog(
  BuildContext context,
  int index,
  ListBoxesModel model,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        actionsPadding: const EdgeInsets.all(0),
        actions: <Widget>[
          Column(
            children: [
              TextButton(
                style: const ButtonStyle(
                  foregroundColor: WidgetStatePropertyAll(Colors.black),
                  textStyle: WidgetStatePropertyAll(
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(
                      MainNavigationRouteNames.editBox,
                      arguments: index);
                },
                child: const Text('Редактировать'),
              ),
              _divider(),
              TextButton(
                style: const ButtonStyle(
                  foregroundColor: WidgetStatePropertyAll(Colors.black),
                  textStyle: WidgetStatePropertyAll(
                    TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFFF3B30),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  _showDeleteConfirmationDialog(context, index, model);
                },
                child: const Text(
                  'Удалить',
                  style: TextStyle(color: Color(0xFFFF3B30)),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}

void _showDeleteConfirmationDialog(
  BuildContext context,
  int index,
  ListBoxesModel model,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        actionsAlignment: MainAxisAlignment.center,
        title: const Text('Вы действительно хотите удалить коробку?',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
        actions: <Widget>[
          Column(
            children: [
              _divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    style: const ButtonStyle(
                        foregroundColor:
                            WidgetStatePropertyAll(Color(0xFFFF3B30))),
                    onPressed: () {
                      Navigator.of(context).pop();
                      model.deleteBox(index, context);
                    },
                    child: const Text(
                      'Удалить',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                  ),
                  const SizedBox(width: 30),
                  Container(
                    height: 47,
                    width: 0.5,
                    color: Colors.black54,
                  ),
                  const SizedBox(width: 30),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Отмена',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      );
    },
  );
}

class _SmallContainerWidget extends StatelessWidget {
  const _SmallContainerWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent),
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      width: double.infinity,
      height: 300,
      child: ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (BuildContext context, index) => Container(
            margin: const EdgeInsets.only(right: 15, left: 15),
            child: const Divider(height: 1)),
        itemCount: 2,
        itemBuilder: (BuildContext context, index) {
          return const ListTile(
            title: Text('Полотенца 130 * 80'),
          );
        },
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

Widget _dataContainer(String text, String thing) {
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
          child: Text(thing),
        ),
      ],
    ),
  );
}

Widget _dataCotainerRow(String text, String hintText, String size) {
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
          child: Text(hintText),
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
