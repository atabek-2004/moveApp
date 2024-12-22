import 'package:flutter/material.dart';
import 'package:move/application/domains/entity/boxes.dart';
import 'package:move/application/ui/screens/main_menu/list_products/menu_choose/list_boxes_model.dart';
import 'package:move/application/ui/themes/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditBoxWidget extends StatelessWidget {
  final int indexBox;
  const EditBoxWidget({super.key, required this.indexBox});

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
              'Список коробок',
              style: AppTheme.styleOfAppBarText,
            ),
            backgroundColor: AppTheme.appColor,
          ),
        ),
      ),
      body: _EditBoxBody(index: indexBox),
    );
  }
}

class _EditBoxBody extends StatelessWidget {
  final int index;
  const _EditBoxBody({required this.index});

  @override
  Widget build(BuildContext context) {
    final listBoxModel = context.watch<ListBoxesModel>();

    if (listBoxModel.listBoxes.isEmpty ||
        index >= listBoxModel.listBoxes.length) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final titleController =
        TextEditingController(text: listBoxModel.listBoxes[index].title);
    final dimensionController =
        TextEditingController(text: listBoxModel.listBoxes[index].dimensions);
    final weightController =
        TextEditingController(text: listBoxModel.listBoxes[index].weight);
    final commentController =
        TextEditingController(text: listBoxModel.listBoxes[index].comment);

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
                    const Text(
                      'РЕДАКТИРОВАНИЕ КОРОБКИ',
                      style: AppTheme.headerSmallTextStyle,
                    ),
                    const SizedBox(height: 5),
                    _BoxesContainerWidget(
                      titleController: titleController,
                      dimensionController: dimensionController,
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
                          dimensionController: dimensionController,
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

class _BoxesContainerWidget extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController dimensionController;
  final TextEditingController weightController;
  final TextEditingController commentController;

  const _BoxesContainerWidget({
    required this.titleController,
    required this.dimensionController,
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
                  child: Text('Габариты'),
                ),
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: dimensionController,
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
  final TextEditingController dimensionController;
  final TextEditingController weightController;
  final TextEditingController commentController;
  final int index;
  const _ElevatedButtonWidget({
    required this.titleController,
    required this.dimensionController,
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
          final updatedBox = Boxes(
            title: titleController.text,
            dimensions: dimensionController.text,
            weight: weightController.text,
            comment:
                commentController.text.isEmpty ? null : commentController.text,
          );
          context.read<ListBoxesModel>().updateBox(
                index: index,
                newBox: updatedBox,
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
