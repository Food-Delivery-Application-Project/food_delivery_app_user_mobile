// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/blocs/auth/auth_bloc.dart';
import 'package:food_delivery_app/blocs/image_picker/image_picker_bloc.dart';
import 'package:food_delivery_app/blocs/media/media_upload_bloc.dart';
import 'package:food_delivery_app/constants/app_text_style.dart';
import 'package:food_delivery_app/global/colors/app_colors.dart';
import 'package:food_delivery_app/models/user/register_user_model.dart';
import 'package:food_delivery_app/utils/app_dialogs.dart';
import 'package:food_delivery_app/utils/app_navigator.dart';
import 'package:food_delivery_app/utils/app_toast.dart';
import 'package:food_delivery_app/utils/app_validators.dart';
import 'package:food_delivery_app/utils/secure_storage.dart';
import 'package:food_delivery_app/view/bottom_nav_bar/main_tabs_screen.dart';
import 'package:food_delivery_app/widgets/buttons/primary_button.dart';
import 'package:food_delivery_app/widgets/text_fields/text_fields_widget.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({Key? key}) : super(key: key);

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  // Blocs
  ImagePickerBloc imageBloc = ImagePickerBloc();
  MediaUploadBloc mediaUploadBloc = MediaUploadBloc();
  AuthBloc authBloc = AuthBloc();

  // Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  // Focus node
  FocusNode nameFocusNode = FocusNode();
  FocusNode bioFocusNode = FocusNode();

  // form key
  final formKey = GlobalKey<FormState>();

  late RegisterUserModel userModel;
  File? image;

  @override
  void initState() {
    UserSecureStorage.deleteIsRegistering();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MultiBlocListener(
          listeners: [
            BlocListener<ImagePickerBloc, ImagePickerState>(
              listener: (context, state) async {
                if (state is ImagePickerPickedImageState) {
                  image = state.image;
                } else if (state is ImagePickerFailureState) {
                  AppToast.danger("Failed to pick image");
                }
              },
            ),
            BlocListener<MediaUploadBloc, MediaUploadState>(
              bloc: mediaUploadBloc,
              listener: (context, state) {
                if (state is MediaUploadLoading) {
                  AppDialogs.loadingDialog(context);
                } else if (state is MediaUploadSuccess) {
                  AppDialogs.closeDialog(context);
                  // save the name of the image
                  // saveFilePath(state.response);
                  AppToast.success(state.response.message);
                  // completeProfile();
                } else if (state is MediaUploadFailure) {
                  AppDialogs.closeDialog(context);
                  AppToast.danger(state.error);
                } else {
                  AppDialogs.closeDialog(context);
                }
              },
            ),
            // Auth bloc listener
            BlocListener<AuthBloc, AuthState>(
              bloc: authBloc,
              listener: (context, state) {
                if (state is AuthLoadingState) {
                  AppDialogs.loadingDialog(context);
                } else if (state is AuthCompleteProfileState) {
                  AppDialogs.closeDialog(context);
                  AppNavigator.goToPageWithReplacement(
                    context: context,
                    screen: const MainTabScreen(index: 0),
                  );
                } else if (state is AuthStateFailure) {
                  AppDialogs.closeDialog(context);
                  AppToast.danger(state.message);
                } else {
                  AppDialogs.closeDialog(context);
                }
              },
            ),
          ],
          child: ListView(
            shrinkWrap: true,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      20.height,
                      Text('Let’s finish setting up your account',
                          style: AppTextStyle.headings),
                      20.height,
                      Text(
                        'What can we call you? Could be your name, a nickname or something funny',
                        style: AppTextStyle.subHeading,
                      ),
                      20.height,
                      // Text regarding image
                      40.height,
                      const ImagePickWidget(),
                      Center(
                        child: Text(
                          'Add a profile picture',
                          style: AppTextStyle.subHeading,
                        ),
                      ),
                      20.height,
                      TextFieldWidget(
                        labelText: 'NAME',
                        controller: nameController,
                        hintText: "Enter your full name",
                        validator: AppValidators.notEmpty,
                        focusNode: nameFocusNode,
                      ),
                      20.height,
                      SizedBox(
                        height: context.height() * 0.3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            PrimaryButtonWidget(
                                caption: "Continue",
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {}
                                }),
                          ],
                        ),
                      ),
                      30.height,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImagePickWidget extends StatefulWidget {
  const ImagePickWidget({Key? key}) : super(key: key);

  @override
  State<ImagePickWidget> createState() => _ImagePickWidgetState();
}

class _ImagePickWidgetState extends State<ImagePickWidget> {
  initBloc() {
    context.read<ImagePickerBloc>().add(ImagePickerPickImageEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            height: 140.h,
            width: 130.w,
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.circular(40),
            ),
            child: BlocBuilder<ImagePickerBloc, ImagePickerState>(
              builder: (context, state) {
                if (state is ImagePickerPickedImageState) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.file(
                      state.image!,
                      fit: BoxFit.cover,
                    ),
                  );
                } else {
                  return const Center(
                    child: Icon(
                      LineIcons.user,
                      size: 80,
                      color: AppColors.darkGrey,
                    ),
                  );
                }
              },
            ),
          ),
          Positioned(
            bottom: -5,
            right: 0,
            left: 0,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                border: Border.all(color: AppColors.white),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const CircleAvatar(
                  backgroundColor: AppColors.iconGrey,
                  child: Icon(
                    Ionicons.camera,
                    size: 20,
                    color: AppColors.white,
                  ),
                ),
                onPressed: () {
                  initBloc();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
