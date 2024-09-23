import 'package:ecomm/consts/consts.dart';
import 'package:ecomm/consts/lists.dart';
import 'package:ecomm/controller/product_controller.dart';
import 'package:ecomm/views/widgets_common/our_button.dart';
import 'package:get/get.dart';

class ItemDetails extends StatefulWidget {
  final String? title;
  final dynamic data;
  const ItemDetails({super.key, required this.title, this.data});

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  int count = 0;
  final List<Color> fixedColors = [Colors.red, Colors.green, Colors.blue];

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return WillPopScope(
      onWillPop: () async{
        controller.resetValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
          leading: IconButton(onPressed: (){controller.resetValues();Get.back();}, icon: const Icon(Icons.arrow_back)),
          title: widget.title!.text.make(),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_outline))
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VxSwiper.builder(
                        autoPlay: true,
                        height: 350,
                        aspectRatio: 16 / 9,
                        viewportFraction: 1.0,
                        itemCount: widget.data['p_imgs'].length,
                        itemBuilder: (context, index) {
                          return Image.network(
                            widget.data['p_imgs'][index],
                            width: double.infinity,
                            fit: BoxFit.cover,
                          );
                        }),
                    10.heightBox,
                    widget.title!.text
                        .size(18)
                        .fontFamily(semibold)
                        .color(darkFontGrey)
                        .make(),
                    10.heightBox,
                    VxRating(
                      isSelectable: false,
                      value: double.parse(widget.data['p_rating']),
                      onRatingUpdate: (value) {},
                      normalColor: textfieldGrey,
                      selectionColor: golden,
                      count: 5,
                      size: 25,
                      maxRating: 5,
                    ),
                    10.heightBox,
                    "Rs ${widget.data['p_price']}"
                        .text
                        .color(redColor)
                        .fontFamily(bold)
                        .size(16)
                        .make(),
                    10.heightBox,
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Seller".text.white.fontFamily(semibold).make(),
                            5.heightBox,
                            "${widget.data['p_seller']}"
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .size(16)
                                .make()
                          ],
                        )),
                        const CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.message_rounded,
                            color: darkFontGrey,
                          ),
                        )
                      ],
                    )
                        .box
                        .height(60)
                        .padding(const EdgeInsets.symmetric(horizontal: 16))
                        .color(textfieldGrey)
                        .make(),
                    10.heightBox,
                    Obx(
                      () => Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Color: "
                                    .text
                                    .color(Colors.black)
                                    .fontFamily(bold)
                                    .make(),
                              ).paddingAll(5),
                              Row(
                                children: List.generate(
                                    widget.data['p_colors'].length,
                                    (index) => Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            VxBox()
                                                .size(30, 30)
                                                .roundedFull
                                                .color(Color(widget
                                                        .data['p_colors'][index])
                                                    .withOpacity(1.0))
                                                .margin(const EdgeInsets.all(6))
                                                .make()
                                                .onTap(() {
                                              controller.changeColorIndex(index);
                                            }),
                                            Visibility(
                                                visible: index ==
                                                    controller.colorIndex.value,
                                                child: const Icon(
                                                    Icons.check_circle_outlined,
                                                    size: 40))
                                          ],
                                        )),
                              )
                            ],
                          )
                        ],
                      ).box.white.shadowSm.make(),
                    ),
                    10.heightBox,
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: "Quantity"
                              .text
                              .color(Colors.black)
                              .fontFamily(bold)
                              .make(),
                        ),
                        Obx(
                          () => Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    controller.decreadeQuantity();
                                    controller.calculateTotalPrice(
                                        int.parse(widget.data['p_price']));
                                  },
                                  icon: const Icon(Icons.remove)),
                              controller.quantity.value.text
                                  .size(16)
                                  .color(Colors.black)
                                  .fontFamily(bold)
                                  .make(),
                              IconButton(
                                  onPressed: () {
                                    controller.increaseQuantity(
                                        int.parse(widget.data['p_quantity']));
                                    controller.calculateTotalPrice(
                                        int.parse(widget.data['p_price']));
                                  },
                                  icon: const Icon(Icons.add)),
                              10.widthBox,
                              "(${widget.data['p_quantity']})"
                                  .text
                                  .color(Colors.black)
                                  .fontFamily(bold)
                                  .make()
                            ],
                          ),
                        )
                      ],
                    ),
                    10.heightBox,
                    Obx(
                      () => Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: "Total Price"
                                .text
                                .color(Colors.black)
                                .fontFamily(bold)
                                .make(),
                          ),
                          "Rs ${controller.totalPrice.value}"
                              .text
                              .color(redColor)
                              .fontFamily(bold)
                              .size(16)
                              .make()
                        ],
                      )
                          .box
                          .white
                          .shadowSm
                          .height(40)
                          .padding(const EdgeInsets.all(5))
                          .make(),
                    ),
                    10.heightBox,
                    "Description: "
                        .text
                        .size(17)
                        .color(darkFontGrey)
                        .fontFamily(bold)
                        .make(),
                    10.heightBox,
                    "${widget.data['p_desc']}"
                        .text
                        .color(darkFontGrey)
                        .fontFamily(semibold)
                        .make(),
                    10.heightBox,
                    ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: listTileSec.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title:
                              listTileSec[index].text.fontFamily(semibold).make(),
                          trailing: const Icon(Icons.arrow_forward),
                        );
                      },
                    ).box.white.shadowSm.make(),
                    10.heightBox,
                    productsyoumayalsolike.text
                        .fontFamily(semibold)
                        .size(18)
                        .make(),
                        10.heightBox,
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            6,
                            (index) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      imgP1,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                                    10.heightBox,
                                    "Laptop 4GB/64GB"
                                        .text
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .make(),
                                    10.heightBox,
                                    "\$600"
                                        .text
                                        .color(redColor)
                                        .fontFamily(bold)
                                        .size(16)
                                        .make()
                                  ],
                                )
                                    .box
                                    .white
                                    .margin(
                                        const EdgeInsets.symmetric(horizontal: 4))
                                    .roundedSM
                                    .padding(const EdgeInsets.all(8))
                                    .make()),
                      ),
                    ),
                  ],
                ),
              ),
            )),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ourButton(
                  color: redColor,
                  onPress: () {
                    controller.addToCart(
                      color: widget.data['p_colors'][controller.colorIndex.value],
                      context: context,
                      img: widget.data['p_imgs'][0],
                      qty: controller.quantity.value,
                      sellername: widget.data['p_seller'],
                      title: widget.data['p_name'],
                      tprice: controller.totalPrice.value
                    );
                    VxToast.show(context, msg: "Added to Cart");
                  },
                  textColor: whiteColor,
                  title: "Add to Cart"),
            )
          ],
        ),
      ),
    );
  }
}
