import 'dart:io';

import 'package:ecomm/consts/consts.dart';
import 'package:ecomm/controller/profile_controller.dart';
import 'package:ecomm/views/profile_screen/profile_screen.dart';
import 'package:ecomm/views/widgets_common/bg_widget.dart';
import 'package:ecomm/views/widgets_common/custom_textfield.dart';
import 'package:ecomm/views/widgets_common/our_button.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    return bgWidget(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 100,
              child: controller.profileImgPath.isEmpty
                  ? Image.asset(
                      profileimg,
                      width: 90,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make()
                  :
                  data['imageUrl']!=''&&controller.profileImgPath.isEmpty?
                  Image.network(data['imageUrl'],width: 100,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make():
                   Image.file(
                      File(controller.profileImgPath.value),
                      width: 90,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make(),
            ),
            10.heightBox,
            ourButton(
                onPress: () {
                  controller.changeImage(context);
                },
                color: redColor,
                textColor: whiteColor,
                title: "Change"),
            const Divider(),
            20.heightBox,
            customTextField(controller: controller.nameController,hint: nameHint, title: name, isPass: false),
            10.heightBox,
            customTextField(controller: controller.oldpassController,hint: passwordHint, title: oldpass, isPass: true),
            10.heightBox,
            customTextField(controller: controller.newpassController,hint: passwordHint, title: newpass, isPass: true),
            20.heightBox,
            controller.isLoading.value? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor),): SizedBox(
                width: context.screenWidth - 60,
                child: ourButton(
                    onPress: () async {
                      controller.isLoading(true);
                      if(controller.profileImgPath.value.isNotEmpty){
                        await controller.uploadProfileImage();
                      }else{
                        controller.profileImageLink=data['imageUrl'];
                      }
                      if(data['password']==controller.oldpassController.text){
                        await controller.changeAuthPassword(
                          email: data['email'],
                          password: controller.oldpassController.text,
                          newpassword: controller.newpassController.text,
                        );
                        await controller.updateProfile(
                        imgUrl: controller.profileImageLink,
                        name: controller.nameController.text,
                        password: controller.newpassController.text,
                      );
                        Get.to(()=>const ProfileScreen());
                      VxToast.show(context, msg: "Profile Updated");
                      }else{
                        VxToast.show(context, msg: "Old Password is Incorrect");
                        controller.isLoading(false);
                      }
                    },
                    color: redColor,
                    textColor: whiteColor,
                    title: "Save")),
          ],
        )
            .box
            .white
            .shadowSm
            .padding(const EdgeInsets.all(16))
            .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
            .rounded
            .make(),
      ),
    ));
  }
}
