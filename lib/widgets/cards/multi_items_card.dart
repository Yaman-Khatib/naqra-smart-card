import 'package:flutter/material.dart';
import 'package:naqra_web/models/card_type.dart';
import 'package:naqra_web/models/contact_info.dart';
import 'package:naqra_web/models/contact_info_item.dart';
import 'package:naqra_web/utils/utitlities.dart';

class MultiItemCard extends StatefulWidget {
  const MultiItemCard({
    super.key,
    required this.contactInfo,
    // required this.cardType,
    // required this.values,
  });

  // final CardType cardType;
  // final List<String> values;
  final ContactInfo contactInfo;
  @override
  State<MultiItemCard> createState() => _MultiItemCardState();
}

class _MultiItemCardState extends State<MultiItemCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withValues(alpha:0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header Row
            InkWell(
      onTap: () {
        print('Contact title was pressed');
        setState(() {
          isExpanded = !isExpanded;
        });
      },
        child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Icon
                Icon(
                  widget.contactInfo.cardType.icon,
                  color: theme.iconTheme.color,
                  size: 22,
                ),
                const SizedBox(width: 12),

                /// Label & count
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.contactInfo.cardType.label,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (!isExpanded)
                        Text(
                          '${widget.contactInfo.contactItems.length} ${widget.contactInfo.cardType.countLabel}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.hintColor,
                          ),
                        ),
                    ],
                  ),
                ),

                /// Chevron
                AnimatedRotation(
                  turns: isExpanded ? 0.25 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    Icons.chevron_right,
                    size: 22,
                    color: theme.hintColor,
                  ),
                ),
              ],
            ),
            ),
            if (isExpanded) ...[
              const SizedBox(height: 12),
              ...widget.contactInfo.contactItems.map(
                (item) => _buildContactItem(item, theme),
              ),
            ],
          ],
        ),
     );
    
  }
}

Widget _buildContactItem(ContactInfoItem contactItem, ThemeData theme) {
  return Material(
    color: theme.cardColor,
    borderRadius: BorderRadius.circular(8),
    child: InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        Utitlities.handleContactItemTap(contactItem);
        // print('Contact item $value was pressed');
      },
      splashColor: theme.primaryColor.withValues(alpha: 0.2),
      highlightColor: theme.primaryColor.withValues(alpha: 0.1),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          children:[ 
            Text(
            Utitlities.truncate(contactItem.value, 26),
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.hintColor,
            ),
          ),
          ]
        ),
      ),
    ),
  );
}
