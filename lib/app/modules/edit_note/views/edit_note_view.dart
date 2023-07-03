import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controllers/edit_note_controller.dart';

class EditNoteView extends GetView<EditNoteController> {
  const EditNoteView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EditNoteView'),
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: controller.getNoteByID(Get.arguments.toString()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data == null) {
            return const Center(
              child: Text('Tidak dapat mengambil informasi data note.'),
            );
          } else {
            controller.titleC.text = snapshot.data!["title"];
            controller.descC.text = snapshot.data!["desc"];
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                TextField(
                  controller: controller.titleC,
                  autocorrect: false,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w400, fontSize: 11.sp),
                  decoration: const InputDecoration(
                    labelText: "title",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: controller.descC,
                  autocorrect: false,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w400, fontSize: 11.sp),
                  decoration: const InputDecoration(
                    labelText: "description",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 30),
                Obx(
                  () => ElevatedButton(
                    onPressed: () {
                      if (controller.isLoading.isFalse) {
                        controller.editNote(Get.arguments.toString());
                      }
                    },
                    child: Text(controller.isLoading.isFalse
                        ? 'EDIT NOTE'
                        : "LOADING..."),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
