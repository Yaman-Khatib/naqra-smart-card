import 'package:flutter/material.dart';
import 'package:naqra_web/models/card_type.dart';
import 'package:naqra_web/widgets/cards/multi_items_card.dart';
import 'package:naqra_web/widgets/cards/single_item_card.dart';
import 'package:naqra_web/models/contact_info.dart';



class ContactCard extends StatelessWidget {
  const ContactCard({
    super.key,
    required this.contactInfo,
    // required this.cardType,
    // required this.values,
    // this.itemCountLabel
  });

  // final IconData icon;
  // final String label;
  // final CardType cardType;
  // final List<String> values;
  // final String? itemCountLabel; 
  final ContactInfo contactInfo;
  

  @override
  Widget build(BuildContext context) {
    
    bool isMultiValuedCard = contactInfo.contactItems.length > 1;

    final theme = Theme.of(context);
     bool isExpanded = false;
    IconData cardIcon;
    

    return isMultiValuedCard?
      MultiItemCard(contactInfo:contactInfo) :
      SingleItemCard(contactInfo: contactInfo);
  
}
}




  // Widget _contactCard(BuildContext context,
  //     {required IconData icon, required String label, required List<String> value}) {
  //   final theme = Theme.of(context);

  //   return Container(
  //     margin: const EdgeInsets.symmetric(vertical: 6),
  //     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
  //     decoration: BoxDecoration(
  //       color: theme.cardColor,
  //       borderRadius: BorderRadius.circular(14),
  //       boxShadow: [
  //         BoxShadow(
  //           color: theme.shadowColor.withOpacity(0.1),
  //           blurRadius: 4,
  //           offset: const Offset(0, 2),
  //         ),
  //       ],
  //     ),
  //     child: Row(
  //       children: [
  //         Icon(icon, color: theme.iconTheme.color, size: 20),
  //         const SizedBox(width: 12),
  //         Expanded(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(label, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
  //               Text(value, style: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor)),
  //             ],
  //           ),
  //         ),
  //         Icon(Icons.arrow_forward_ios, size: 14, color: theme.hintColor),
  //       ],
  //     ),
  //   );
  // }
