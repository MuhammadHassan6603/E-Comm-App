import 'package:ecomm/consts/consts.dart';
Widget detailsCard({width,String? count,String? title}){
  return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  count!.text.fontFamily(bold).color(darkFontGrey).make(),
                  5.heightBox,
                  title!.text.color(darkFontGrey).make(),
                ],
              ).box.white.rounded.width(width).height(55).padding(const EdgeInsets.all(4)).make();
}