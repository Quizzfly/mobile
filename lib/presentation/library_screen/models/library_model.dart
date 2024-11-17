import 'package:equatable/equatable.dart';
import '../../library_screen/models/library_list_item_model.dart';

/// This class defines the variables used in the [library_screen],
/// and is typically used to hold data that is passed between different parts of the application.
// ignore_for_file: must_be_immutable
class LibraryModel extends Equatable {
  LibraryModel({this.libraryListItemList = const []});
  List<LibraryListItemModel> libraryListItemList;
  int get quizCount {
    return libraryListItemList
        .length;
  }
  LibraryModel copyWith({List<LibraryListItemModel>? libraryListItemList}) {
    return LibraryModel(
      libraryListItemList: libraryListItemList ?? this.libraryListItemList,
    );
  }

  @override
  List<Object?> get props => [libraryListItemList];
}
