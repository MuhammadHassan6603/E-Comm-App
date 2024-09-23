import 'package:ecomm/consts/consts.dart';
import 'package:ecomm/controller/auth_controller.dart';
import 'package:ecomm/views/home_screen/home.dart';
import 'package:ecomm/views/widgets_common/applogo_widget.dart';
import 'package:ecomm/views/widgets_common/bg_widget.dart';
import 'package:ecomm/views/widgets_common/custom_textfield.dart';
import 'package:ecomm/views/widgets_common/our_button.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogoWidget(),
            10.heightBox,
            "Signup to $appname".text.fontFamily(bold).white.size(18).make(),
            15.heightBox,
            Obx(()=> Column(
                children: [
                  customTextField(
                      title: name,
                      hint: nameHint,
                      controller: nameController,
                      isPass: false),
                  customTextField(
                      title: email,
                      hint: emailHint,
                      controller: emailController,
                      isPass: false),
                  customTextField(
                      title: password,
                      hint: passwordHint,
                      controller: passwordController,
                      isPass: true),
                  customTextField(
                      title: retypePassword,
                      hint: passwordHint,
                      controller: passwordRetypeController,
                      isPass: true),
                  Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {}, child: forgerPass.text.make())),
                  Row(
                    children: [
                      Checkbox(
                        activeColor: redColor,
                        checkColor: whiteColor,
                        value: isCheck,
                        onChanged: (newValue) {
                          setState(() {
                            isCheck = newValue;
                          });
                        },
                      ),
                      10.widthBox,
                      Expanded(
                        child: RichText(
                            text: const TextSpan(children: [
                          TextSpan(
                            text: "I agree to the ",
                            style:
                                TextStyle(fontFamily: regular, color: fontGrey),
                          ),
                          TextSpan(
                            text: termsAndCond,
                            style: TextStyle(fontFamily: bold, color: redColor),
                          ),
                          TextSpan(
                            text: " & ",
                            style:
                                TextStyle(fontFamily: regular, color: fontGrey),
                          ),
                          TextSpan(
                            text: privacyPolicy,
                            style: TextStyle(fontFamily: bold, color: redColor),
                          ),
                        ])),
                      )
                    ],
                  ),
                  5.heightBox,
                  controller.isLoading.value? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  ): ourButton(
                      color: isCheck == true ? redColor : fontGrey,
                      title: signup,
                      textColor: whiteColor,
                      onPress: () async {
                        if (isCheck != false) {
                          controller.isLoading(true);
                          try {
                            await controller
                                .signupMethod(
                                    context: context,
                                    email: emailController.text,
                                    password: passwordController.text)
                                .then((value) {
                              return controller.storeUserData(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text);
                            }).then((value) {
                              VxToast.show(context, msg: loggedIn);
                              Get.to(() => const Home());
                            });
                          } catch (e) {
                            auth.signOut();
                            // ignore: use_build_context_synchronously
                            VxToast.show(context, msg: e.toString());
                            controller.isLoading(false);
                          }
                        }
                      }).box.width(context.screenWidth - 50).make(),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      alreadyAccount.text.color(fontGrey).fontFamily(bold).make(),
                      login.text
                          .color(redColor)
                          .fontFamily(bold)
                          .make()
                          .onTap(() {
                        Get.back();
                      })
                    ],
                  )
                ],
              )
                  .box
                  .white
                  .rounded
                  .padding(const EdgeInsets.all(16))
                  .width(context.screenWidth - 70)
                  .shadowSm
                  .make(),
            ),
          ],
        ),
      ),
    ));
  }
}
