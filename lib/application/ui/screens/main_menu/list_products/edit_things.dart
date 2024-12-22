import 'package:flutter/material.dart';
import 'package:move/application/domains/entity/things.dart';
import 'package:move/application/ui/screens/main_menu/list_products/list_things_model.dart';
import 'package:move/application/ui/themes/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class EditThings extends StatelessWidget {
  final int indexThing;
  const EditThings({super.key, required this.indexThing});

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
              'Список вещей',
              style: AppTheme.styleOfAppBarText,
            ),
            backgroundColor: AppTheme.appColor,
          ),
        ),
      ),
      body: _EditThingsBody(index: indexThing),
    );
  }
}

class _EditThingsBody extends StatelessWidget {
  final int index;
  const _EditThingsBody({required this.index});

  @override
  Widget build(BuildContext context) {
    final listThingsModel = context.watch<ListThingsModel>();

    if (listThingsModel.listTings.isEmpty ||
        index >= listThingsModel.listTings.length) {
      return const Center(
        child: Text(
          'Нет данных для отображения',
          style: AppTheme.mainMenuTextsStyle,
        ),
      );
    }

    final titleController = TextEditingController(text: listThingsModel.listTings[index].title);
    final descriptionController = TextEditingController(text: listThingsModel.listTings[index].description);
    final sizeController = TextEditingController(text: listThingsModel.listTings[index].size);
    final weightController = TextEditingController(text: listThingsModel.listTings[index].weight);
    final commentController = TextEditingController(text: listThingsModel.listTings[index].comment);

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'РЕДАКТИРОВАНИЕ ВЕЩИ',
                      style: AppTheme.headerSmallTextStyle,
                    ),
                    const SizedBox(height: 5),
                    _ThingsContainerWidget(
                      titleController: titleController,
                      descriptionController: descriptionController,
                      sizeController: sizeController,
                      weightController: weightController,
                      commentController: commentController,
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 30),
                        width: double.infinity,
                        height: 44,
                        child: _ElevatedButtonWidget(
                          titleController: titleController,
                          descriptionController: descriptionController,
                          sizeController: sizeController,
                          weightController: weightController,
                          commentController: commentController,
                          index: index,
                        ),
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

class _ThingsContainerWidget extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController sizeController;
  final TextEditingController weightController;
  final TextEditingController commentController;

  const _ThingsContainerWidget({
    required this.titleController,
    required this.descriptionController,
    required this.sizeController,
    required this.weightController,
    required this.commentController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: Text('Название'),
                ),
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 0),
            Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: Text('Описание'),
                ),
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 0),
            Row(
              children: [
                const Expanded(
                  flex: 3,
                  child: Text('Размер'),
                ),
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: sizeController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: Text('см'),
                ),
              ],
            ),
            const Divider(height: 0),
            Row(
              children: [
                const Expanded(
                  flex: 3,
                  child: Text('Вес'),
                ),
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: weightController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: Text('кг'),
                ),
              ],
            ),
            const Divider(height: 0),
            Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: Text('Комментарий'),
                ),
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: commentController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 0),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}


class _ElevatedButtonWidget extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController sizeController;
  final TextEditingController weightController;
  final TextEditingController commentController;
  final int index;
  const _ElevatedButtonWidget({
    required this.titleController,
    required this.descriptionController,
    required this.sizeController,
    required this.weightController,
    required this.commentController,
    required this.index,
  });

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
        onPressed: () {
          final updatedThing = Things(
            title: titleController.text,
            description: descriptionController.text,
            size: sizeController.text,
            weight: weightController.text,
            comment:
                commentController.text.isEmpty ? null : commentController.text,
          );
          context.read<ListThingsModel>().updateThing(
                index: index,
                newThing: updatedThing,
              );
          Navigator.of(context).pop();
        },
        child: const Text(
          'Готово',
          style: AppTheme.buttonTextStyle,
        ),
      ),
    );
  }
}
