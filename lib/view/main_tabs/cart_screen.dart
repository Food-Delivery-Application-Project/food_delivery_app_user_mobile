// ignore_for_file: use_key_in_widget_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/blocs/cart/cart_bloc.dart';
import 'package:food_delivery_app/constants/app_text_style.dart';
import 'package:food_delivery_app/global/assets/app_assets.dart';
import 'package:food_delivery_app/global/colors/app_colors.dart';
import 'package:food_delivery_app/models/food/food_model.dart';
import 'package:food_delivery_app/utils/secure_storage.dart';
import 'package:food_delivery_app/widgets/buttons/primary_button.dart';
import 'package:food_delivery_app/widgets/loading/loading_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Blocs
  CartBloc cartBloc = CartBloc();

  // Pagination
  int page = 1;
  int paginatedBy = 10;

  // Lists
  List<FoodModel> foodList = [];
  List foodQuanty = [];

  @override
  void initState() {
    initInitialBloc();
    super.initState();
  }

  initInitialBloc() {
    UserSecureStorage.fetchUserId().then((value) {
      cartBloc.add(
        CartGetInitialDataEvent(
          userId: value.toString(),
          page: page,
          paginatedBy: paginatedBy,
        ),
      );
    });
  }

  initGetMoreDataBloc() {}
  final List<Map<String, dynamic>> cartItems = [
    {
      'name': 'Pizza',
      'quantity': 2,
      'price': 9.99,
      'image':
          'https://i0.wp.com/www.onceuponachef.com/images/2020/06/Margherita-Pizza-scaled.jpg?resize=1080%2C1536&ssl=1',
    },
    {
      'name': 'Tacos',
      'quantity': 1,
      'price': 6.49,
      'image':
          'https://i0.wp.com/www.onceuponachef.com/images/2023/08/Beef-Tacos.jpg?resize=1120%2C840&ssl=1',
    },
    // Add more sample cart items as needed
  ];

  void _incrementQuantity(int index) {
    // setState(() {
    //   cartItems[index]['quantity']++;
    // });
    // increment quantity for the food item in the foodQuantity list
    setState(() {
      foodQuanty[index]['quantity']++;
    });
  }

  void _decrementQuantity(int index) {
    // if (cartItems[index]['quantity'] > 1) {
    //   setState(() {
    //     cartItems[index]['quantity']--;
    //   });
    // }
    // decrement quantity for the food item in the foodQuantity list
    if (foodQuanty[index]['quantity'] > 1) {
      setState(() {
        foodQuanty[index]['quantity']--;
      });
    }
  }

  calculateTotalPrice() {
    double totalPrice = 0;

    // Calculate total price
    for (var item in cartItems) {
      totalPrice += item['price'] * item['quantity'];
    }

    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0;

    // Calculate total price
    for (var item in cartItems) {
      totalPrice += item['price'] * item['quantity'];
    }

    return BlocConsumer<CartBloc, CartState>(
      bloc: cartBloc,
      listener: (context, state) {
        if (state is CartGetInitialDataState) {
          // set quantity to 1 for all the available items
          for (var item in state.response.data) {
            foodQuanty.add({
              'id': item.sId,
              'quantity': 1,
            });
          }
        }
      },
      builder: (context, state) {
        if (state is CartInitialLoadingState) {
          return const Center(
            child: LoadingWidget(),
          );
        } else if (state is CartErrorState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.message),

                // Reload Button
                20.height,
                ElevatedButton(
                  onPressed: () {
                    initInitialBloc();
                  },
                  child: const Text('Reload'),
                ),
              ],
            ),
          );
        } else if (state is CartGetInitialDataState) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        margin: const EdgeInsets.only(bottom: 16),
                        child: ListTile(
                          title: Text(
                            state.response.data[index].foodName.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Quantity: ${foodQuanty[index]['quantity']}'),
                              Text(
                                'Price: ${state.response.data[index].price}',
                              ),
                            ],
                          ),
                          leading: CachedNetworkImage(
                            imageUrl:
                                state.response.data[index].image.toString(),
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                            errorWidget: (context, error, stackTrace) =>
                                Image.asset(AppImages.logoTrans),
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                shape: BoxShape.rectangle,
                                color: Colors.grey,
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.remove,
                                  color: AppColors.red,
                                ),
                                onPressed: () => _decrementQuantity(index),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.add,
                                  color: AppColors.success,
                                ),
                                onPressed: () => _incrementQuantity(index),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: state.response.data.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  )
                ],
              ),
            ),
          );
        } else {
          return Container(
            width: double.infinity,
            height: double.infinity,
            color: AppColors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Cart Items",
                  style: AppTextStyle.headings,
                ),
                20.height,
                ListView.builder(
                  shrinkWrap: true,
                  itemCount:
                      cartItems.length + 2, // +2 for items and total price row
                  itemBuilder: (BuildContext context, int index) {
                    if (index < cartItems.length) {
                      return Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        margin: const EdgeInsets.only(bottom: 16),
                        child: ListTile(
                          title: Text(
                            cartItems[index]['name'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Quantity: ${cartItems[index]['quantity']}'),
                              Text('Price: \$${cartItems[index]['price']}'),
                            ],
                          ),
                          leading: CachedNetworkImage(
                            imageUrl: cartItems[index]['image'],
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                            errorWidget: (context, error, stackTrace) =>
                                const Icon(Icons.error),
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                shape: BoxShape.rectangle,
                                color: Colors.grey,
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.remove,
                                  color: Colors.red,
                                ),
                                onPressed: () => _decrementQuantity(index),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.green,
                                ),
                                onPressed: () => _incrementQuantity(index),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else if (index == cartItems.length) {
                      return TotolAmountWidget(
                        totalPrice: totalPrice,
                        discount: 0,
                        deliveryFee: 0,
                      );
                    } else {
                      return const SizedBox(
                          height: 80); // Some padding at the end
                    }
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class TotolAmountWidget extends StatelessWidget {
  const TotolAmountWidget({
    super.key,
    required this.totalPrice,
    required this.discount,
    required this.deliveryFee,
  });

  final double totalPrice;
  final double discount;
  final double deliveryFee;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.primary,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Discount',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              Text(
                '\$${discount.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Delivery fee',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              Text(
                '\$${deliveryFee.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '\$${totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          PrimaryButtonWidget(
            width: MediaQuery.of(context).size.width * 0.9,
            onPressed: () {},
            caption: "Proceed to payment",
            color: AppColors.primary,
          ),
        ],
      ),
    );
  }
}