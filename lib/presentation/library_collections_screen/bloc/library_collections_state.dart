part of 'library_collections_bloc.dart';

/// Represents the state of LibraryCollections in the application.
// ignore_for_file: must_be_immutable
class LibraryCollectionsState extends Equatable {
  LibraryCollectionsState({this.libraryCollectionsModelObj});
  LibraryCollectionsModel? libraryCollectionsModelObj;
  @override
  List<Object?> get props => [libraryCollectionsModelObj];
  LibraryCollectionsState copyWith(
      {LibraryCollectionsModel? libraryCollectionsModelObj}) {
    return LibraryCollectionsState(
      libraryCollectionsModelObj:
          libraryCollectionsModelObj ?? this.libraryCollectionsModelObj,
    );
  }
}
