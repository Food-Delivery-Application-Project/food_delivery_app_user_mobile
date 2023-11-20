import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/constants/app_text_style.dart';
import 'package:food_delivery_app/global/assets/app_assets.dart';
import 'package:food_delivery_app/global/colors/app_colors.dart';
import 'package:food_delivery_app/models/food/food_model.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';

class FoodItem extends StatelessWidget {
  final FoodModel foodModel;
  const FoodItem({Key? key, required this.foodModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                shape: BoxShape.rectangle,
                color: AppColors.grey,
              ),
              child: GridTile(
                header: Container(
                  // give some gradient color
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        AppColors.darkBackground,
                        AppColors.transparent,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                    ),
                  ),
                  child: GridTileBar(
                    leading: const SizedBox.shrink(),
                    title: AutoSizeText(
                      foodModel.foodName.toString(),
                      style: AppTextStyle.foodItemName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const CircleAvatar(
                        backgroundColor: AppColors.white,
                        radius: 15,
                        child: Icon(
                          Ionicons.cart,
                          color: AppColors.primary,
                          size: 20,
                          shadows: [
                            Shadow(
                              color: AppColors.black,
                              blurRadius: 1,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    shape: BoxShape.rectangle,
                    color: AppColors.grey,
                    // image: DecorationImage(
                    //   image: const AssetImage(AppImages.logo),
                    //   fit: BoxFit.cover,
                    //   onError: (exception, stackTrace) =>
                    //       const SizedBox.shrink(),
                    // ),
                  ),
                  child: Image.network(
                    foodModel.image.toString(),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Image.asset(AppImages.logo),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Container(
            width: context.width(),
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  foodModel.description.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    AutoSizeText(
                      "PKR: ${foodModel.price}",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                        // delete the text
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const Icon(
                          Ionicons.star,
                          color: AppColors.primary,
                          size: 14,
                        ),
                        const SizedBox(width: 5),
                        AutoSizeText(
                          "5",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
