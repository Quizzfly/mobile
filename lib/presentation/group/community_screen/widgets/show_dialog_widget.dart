import 'package:flutter/material.dart';
import '../../../../theme/custom_button_style.dart';
import '../../../../widgets/custom_text_form_field.dart';
import '../bloc/community_bloc.dart';
import '../../../../../core/app_export.dart';
import '../../../../../widgets/custom_elevated_button.dart';

class ShowDialogWidget extends StatefulWidget {
  const ShowDialogWidget({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider.value(
      value: context.read<CommunityBloc>(),
      child: const ShowDialogWidget(),
    );
  }

  @override
  State<ShowDialogWidget> createState() => _ShowDialogState();
}

class _ShowDialogState extends State<ShowDialogWidget> {
  final TextEditingController _emailController = TextEditingController();
  final List<String> _emails = [];
  final _formKey = GlobalKey<FormState>();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _addEmail(String email) {
    if (email.trim().isNotEmpty && !_emails.contains(email.trim())) {
      setState(() {
        _emails.add(email.trim());
        _emailController.clear();
      });
    }
  }

  void _removeEmail(String email) {
    setState(() {
      _emails.remove(email);
    });
  }

  Widget _buildEmailChip(String email) {
    return Chip(
      label: Text(
        email,
        style: const TextStyle(color: Colors.black87),
      ),
      deleteIcon: const Icon(Icons.close, size: 18),
      onDeleted: () => _removeEmail(email),
      backgroundColor: appTheme.gray200,
      deleteIconColor: appTheme.gray500,
      labelPadding: const EdgeInsets.symmetric(horizontal: 4),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      side: const BorderSide(
        color: Colors.transparent,
        width: 1,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Invite member',
        style: CustomTextStyles.headlineSmallSFProRoundedGray90003,
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Email',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: appTheme.gray200),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_emails.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                        child: Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          children: _emails.map(_buildEmailChip).toList(),
                        ),
                      ),
                    CustomTextFormField(
                      controller: _emailController,
                      focusNode: _focusNode,
                      borderDecoration: InputBorder.none,
                      contentPadding: const EdgeInsets.all(8),
                      onChanged: (value) {
                        if (value.endsWith(' ')) {
                          _addEmail(value);
                        }
                      },
                      hintText:
                          _emails.isEmpty ? 'Enter email addresses...' : '',
                      maxLines: null,
                      textInputType: TextInputType.emailAddress,
                      fillcolor: Colors.transparent,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomElevatedButton(
              height: 40.h,
              width: 120.h,
              text: "Cancel",
              buttonStyle: CustomButtonStyles.fillBlackGray.copyWith(
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.h),
                  ),
                ),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            CustomElevatedButton(
              height: 40.h,
              width: 120.h,
              text: "Invite",
              buttonStyle: CustomButtonStyles.fillPrimaryRadius12.copyWith(
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.h),
                  ),
                ),
              ),
              onPressed: () {
                if (_emails.isNotEmpty) {
                  Navigator.of(context).pop(_emails);
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
