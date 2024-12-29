import 'package:flutter/material.dart';
import '../../../../core/app_export.dart';
import '../../../personalization/library_screen/widgets/library_list_item_widget.dart';
import '../bloc/community_bloc.dart';

class LibrarySelectionPopup extends StatelessWidget {
  const LibrarySelectionPopup({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        context.read<CommunityBloc>().add(
          CreateGetLibraryEvent(
            onGetLibraryError: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Failed to load library items'),
                ),
              );
            },
          ),
        );
      },
    );

    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text(
                    'Select Quizzfly',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
            const Divider(),
            Expanded(
              child: BlocBuilder<CommunityBloc, CommunityState>(
                builder: (context, state) {
                  final libraryItems =
                      state.communityActivityTabModelObj?.libraryListItemList;

                  if (libraryItems == null) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (libraryItems.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.only(top: 100.h, bottom: 100.h),
                      child: Column(
                        children: [
                          Image.asset(
                            ImageConstant.imgEmpty,
                            width: 250,
                            height: 250,
                          ),
                          const Text('No quizzfly found. Create one now!'),
                        ],
                      ),
                    );
                  }

                  return ListView.separated(
                    controller: scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: libraryItems.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 15),
                    itemBuilder: (context, index) {
                      return LibraryListItemWidget(
                        libraryItems[index],
                        check: false,
                        callDetail: () {
                          context.read<CommunityBloc>().add(
                                SelectQuizzflyEvent(
                                  quizzfly: libraryItems[index],
                                ),
                              );
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
