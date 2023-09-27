
List<SliderData> sliderData = <SliderData>[
  SliderData(
    img: 'assets/images/Add.jpg',
    title: "Best Phone",
  ),
  SliderData(
    img: 'assets/images/add2.png',
    title: "Best Head Phone",
  ),
  SliderData(
    img: 'assets/images/cosmetics-or-skin-care-product-ads-with-bottle-banner-ad-for-beauty-products-and-leaf-background-glittering-light-effect-design-vector.jpg',
    title: "Best cosmetics",
  ),
];

class SliderData {
  String img;
  String title;

  SliderData({
    required this.img,
    required this.title,
  });
}
