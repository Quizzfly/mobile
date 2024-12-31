part of 'quizzfly_setting_bloc.dart';

/// Represents the state of QuizzflySetting in the application.
// ignore_for_file: must_be_immutable
class QuizzflySettingState extends Equatable {
  final QuizzflySettingModel? quizzflySettingModelObj;
  final TextEditingController? titleController;
  final TextEditingController? descriptionController;
  final String? visibility; // Changed from checkbox to single visibility value
  bool? isPublic;
  String? title;
  String? description;
  dynamic coverImage;
  String? id;
  QuizzflySettingState(
      {this.quizzflySettingModelObj,
      this.titleController,
      this.descriptionController,
      this.visibility = "public",
      this.isPublic,
      this.title,
      this.description,
      this.coverImage,
      this.id});

  @override
  List<Object?> get props => [
        quizzflySettingModelObj,
        titleController,
        descriptionController,
        visibility,
        isPublic,
        title,
        description,
        coverImage,
        id,
      ];
  QuizzflySettingState copyWith(
      {QuizzflySettingModel? quizzflySettingModelObj,
      TextEditingController? titleController,
      TextEditingController? descriptionController,
      String? visibility,
      bool? isPublic,
      String? title,
      String? description,
      dynamic coverImage,
      String? id}) {
    return QuizzflySettingState(
      quizzflySettingModelObj:
          quizzflySettingModelObj ?? this.quizzflySettingModelObj,
      titleController: titleController ?? this.titleController,
      descriptionController:
          descriptionController ?? this.descriptionController,
      visibility: visibility ?? this.visibility,
      isPublic: isPublic ?? this.isPublic,
      title: title ?? this.title,
      description: description ?? this.description,
      coverImage: coverImage ?? this.coverImage,
      id: id ?? this.id,
    );
  }
}
