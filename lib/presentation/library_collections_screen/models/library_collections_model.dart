import 'package:equatable/equatable.dart';
import 'library_collections_grid_item_model.dart';

/// This class defines the variables used in the [library_collections_screen],
/// and is typically used to hold data that is passed between different parts of the application.
// ignore_for_file: must_be_immutable
class LibraryCollectionsModel extends Equatable {
  LibraryCollectionsModel({this.libraryCollectionsGridItemList = const []});
  List<LibraryCollectionsGridItemModel> libraryCollectionsGridItemList;
  LibraryCollectionsModel copyWith(
      {List<LibraryCollectionsGridItemModel>? libraryCollectionsGridItemList}) {
    return LibraryCollectionsModel(
      libraryCollectionsGridItemList:
          libraryCollectionsGridItemList ?? this.libraryCollectionsGridItemList,
    );
  }

  @override
  List<Object?> get props => [libraryCollectionsGridItemList];
}
