import 'package:flutter/material.dart';
import '../../../../core/app_export.dart';
import '../models/list_group_item_model.dart';

class ListGroupItemWidget extends StatelessWidget {
  final ListGroupItemModel model;
  final VoidCallback? onDetailTap;

  const ListGroupItemWidget({
    super.key,
    required this.model,
    this.onDetailTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: model.image!.isNotEmpty
                    ? NetworkImage(model.image!)
                    : AssetImage(ImageConstant.imgNotFound),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.title ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  model.role ?? 'HOST',
                  style: TextStyle(
                    fontSize: 12,
                    color: appTheme.gray500,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: onDetailTap,
            child: const Text(
              'Detail',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
