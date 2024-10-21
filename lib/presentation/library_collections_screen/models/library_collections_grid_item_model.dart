import 'package:equatable/equatable.dart';

/// This class is used in the [library_collections_gridItem_widget] screen.
// ignore_for_file: must_be_immutable
class LibraryCollectionsGridItemModel extends Equatable {
  LibraryCollectionsGridItemModel({this.educationTwo, this.id}) {
    educationTwo = educationTwo ?? "Education";
    id = id ?? "";
  }
  String? educationTwo;
  String? id;
  LibraryCollectionsGridItemModel copyWith({
    String? educationTwo,
    String? id,
  }) {
    return LibraryCollectionsGridItemModel(
      educationTwo: educationTwo ?? this.educationTwo,
      id: id ?? this.id,
    );
  }

  @override
  List<Object?> get props => [educationTwo, id];
}
