import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../presentation/group/community_screen/bloc/community_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../../core/app_export.dart';
import '../../../../theme/custom_button_style.dart';
import '../../../../widgets/custom_elevated_button.dart';
import '../../../../widgets/custom_text_form_field.dart';
import '../../../personalization/library_screen/models/library_list_item_model.dart';
import '../../../personalization/library_screen/widgets/library_list_item_widget.dart';
import 'library_selection_popup.dart';

class CreatePostBottomSheet extends StatefulWidget {
  const CreatePostBottomSheet({super.key});

  @override
  State<CreatePostBottomSheet> createState() => _CreatePostBottomSheetState();
}

class _CreatePostBottomSheetState extends State<CreatePostBottomSheet> {
  final List<XFile> _selectedImages = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImages(BuildContext context) async {
    try {
      final List<XFile> images = await _picker.pickMultiImage();
      if (images.isNotEmpty) {
        setState(() {
          _selectedImages.addAll(images);
        });
        final List<File> files =
            _selectedImages.map((xFile) => File(xFile.path)).toList();
        context.read<CommunityBloc>().add(ImagePickedEvent(files));
      }
    } catch (e) {
      debugPrint('Error picking images: $e');
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
    final List<File> files =
        _selectedImages.map((xFile) => File(xFile.path)).toList();
    context.read<CommunityBloc>().add(ImagePickedEvent(files));
  }

  void _showLibrarySelection(BuildContext context) {
    final communityBloc = context.read<CommunityBloc>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BlocProvider.value(
        value: communityBloc,
        child: const LibrarySelectionPopup(),
      ),
    );
  }

  Widget _buildSelectedQuizzfly(BuildContext context) {
    return BlocSelector<CommunityBloc, CommunityState, LibraryListItemModel?>(
      selector: (state) => state.selectedQuizzfly,
      builder: (context, selectedQuizzfly) {
        if (selectedQuizzfly == null) {
          return const SizedBox.shrink();
        }
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Stack(
            children: [
              LibraryListItemWidget(
                selectedQuizzfly,
                onDelete: null,
                check: false,
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: appTheme.red900,
                    size: 24,
                  ),
                  onPressed: () {
                    context.read<CommunityBloc>().add(
                          SelectQuizzflyEvent(
                            quizzfly: null,
                            forceUpdateSelectedQuizzfly: true,
                          ),
                        );
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) => Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
                const Text(
                  'Create Post',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CustomElevatedButton(
                  width: 100,
                  height: 36,
                  text: "Post",
                  buttonStyle: CustomButtonStyles.fillPrimaryRadius20,
                  rightIcon: Icon(
                    Icons.send,
                    color: appTheme.whiteA700,
                  ),
                  onPressed: () {
                    context.read<CommunityBloc>().add(
                          CreatePostNewPostEvent(
                            groupId:
                                context.read<CommunityBloc>().state.id ?? '',
                            onPostNewPostSuccess: () {
                              NavigatorService.goBack();
                              showTopSnackBar(
                                Overlay.of(context),
                                const CustomSnackBar.success(
                                  message: 'Create new post successfully',
                                ),
                              );
                            },
                            onPostNewPostError: () {
                              showTopSnackBar(
                                Overlay.of(context),
                                const CustomSnackBar.error(
                                  message: 'Failed to create new post',
                                ),
                              );
                            },
                          ),
                        );
                  },
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: SingleChildScrollView(
              controller: scrollController,
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              NetworkImage(PrefUtils().getAvatar()),
                          backgroundColor: Colors.transparent,
                          // ignore: unnecessary_null_comparison
                          child: PrefUtils().getAvatar() == null
                              ? const Icon(Icons.person, size: 20)
                              : null,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          PrefUtils().getName(),
                          style: CustomTextStyles.titleMediumRobotoBlack900,
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    BlocSelector<CommunityBloc, CommunityState,
                        TextEditingController?>(
                      selector: (state) => state.postInputFieldController,
                      builder: (context, postInputFieldController) {
                        return CustomTextFormField(
                          controller: postInputFieldController,
                          maxLines: 5,
                          hintText: "Enter your post",
                        );
                      },
                    ),
                    if (_selectedImages.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: _selectedImages.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  File(_selectedImages[index].path),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                              Positioned(
                                top: 4,
                                right: 4,
                                child: GestureDetector(
                                  onTap: () => _removeImage(index),
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.5),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.close,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                    _buildSelectedQuizzfly(context),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.image),
                          onPressed: () => _pickImages(context),
                        ),
                        IconButton(
                          icon: const Icon(Icons.grid_view),
                          onPressed: () => _showLibrarySelection(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
