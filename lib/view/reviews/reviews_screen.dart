import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/blocs/review/review_bloc.dart';
import 'package:food_delivery_app/global/colors/app_colors.dart';
import 'package:food_delivery_app/models/review/review_model.dart';
import 'package:food_delivery_app/utils/app_dialogs.dart';
import 'package:food_delivery_app/utils/app_toast.dart';
import 'package:food_delivery_app/widgets/appbars/back_appbar_widget.dart';
import 'package:food_delivery_app/widgets/loading/loading_widget.dart';
import 'package:food_delivery_app/widgets/text_fields/text_fields_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class ReviewsScreen extends StatefulWidget {
  final String foodId;
  const ReviewsScreen({Key? key, required this.foodId}) : super(key: key);

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  var reviewController = TextEditingController();

  // blocs
  var reviewBloc = ReviewBloc();

  // Lists
  List<ReviewModel> reviewList = [];

  // Methods
  @override
  void initState() {
    getInitialReviews();
    super.initState();
  }

  writeReview() {
    reviewBloc.add(
      ReviewPostEvent(
        foodId: widget.foodId,
        text: reviewController.text.trim(),
      ),
    );
  }

  getInitialReviews() {
    reviewBloc.add(ReviewGetInitialEvent(foodId: widget.foodId));
  }

  @override
  void dispose() {
    reviewController.dispose();
    reviewBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackAppbarWidget(),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          // show modal bottom sheet
          showModalBottomSheet(
            context: context,
            backgroundColor: AppColors.white,
            builder: (context) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              height: 600,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: TextFieldWidget(
                      labelText: "Review",
                      controller: reviewController,
                      hintText: "Write new review",
                      maxLines: 2,
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: () {
                        writeReview();
                      },
                      icon: const Icon(Icons.send_sharp),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        child: Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.primary,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 5,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: const Text(
            "Post new review",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
        ),
      ),
      body: BlocListener<ReviewBloc, ReviewState>(
        bloc: reviewBloc,
        listener: (context, state) {
          if (state is ReviewLoadingState) {
            AppDialogs.loadingDialog(context);
          } else if (state is ReviewPostSuccessState) {
            AppDialogs.closeDialog(context);
            AppToast.success(state.response.message);
            getInitialReviews();
            // close bottom sheet and clear controller
            Navigator.pop(context);
            reviewController.clear();
          } else if (state is ReviewSuccessState) {
            reviewList = state.response.data as List<ReviewModel>;
          } else if (state is ReviewErrorState) {
            AppDialogs.closeDialog(context);
            AppToast.danger(state.message);
          }
        },
        child: BlocBuilder<ReviewBloc, ReviewState>(
          bloc: reviewBloc,
          builder: (context, state) {
            if (state is ReviewDataLoadingState) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      itemBuilder: (context, index) => ListTile(
                        title: Container(
                          margin: const EdgeInsets.only(right: 100),
                          height: 30,
                          color: AppColors.lightGrey,
                        ),
                        subtitle: Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          height: 50,
                          color: AppColors.lightGrey,
                        ),
                      ),
                      itemCount: 5,
                      shrinkWrap: true,
                    )
                  ],
                ),
              );
            } else if (state is ReviewEmptyState) {
              return const Center(
                child: Text("No reviews found"),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      itemBuilder: (context, index) => ReviewWidget(
                        reviewList: reviewList,
                        index: index,
                      ),
                      itemCount: reviewList.length,
                      shrinkWrap: true,
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class ReviewWidget extends StatelessWidget {
  final List<ReviewModel> reviewList;
  final int index;
  const ReviewWidget({Key? key, required this.reviewList, required this.index})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: CachedNetworkImage(
          imageUrl: reviewList[index].userId!.profileImage.toString(),
          fit: BoxFit.cover,
          placeholder: (context, url) => const LoadingWidget(),
          errorWidget: (context, url, error) => const Icon(
            LineIcons.user,
            color: AppColors.black,
            size: 30,
          ),
        ),
      ),
      title: Text(
        reviewList[index].userId!.fullname.toString(),
      ),
      subtitle: Text(reviewList[index].text.toString()),
    );
  }
}
