import 'package:flutter/material.dart';
import 'package:naqra_web/models/card_type.dart';
import 'package:naqra_web/models/contact_info.dart';
import 'package:naqra_web/models/contact_info_item.dart';
import 'package:naqra_web/models/profile.dart';
import 'package:naqra_web/utils/utitlities.dart';

class SingleItemCard extends StatelessWidget {
  const SingleItemCard({required this.contactInfo ,super.key});
  
  // final CardType cardType;
  // final String value;
  final ContactInfo contactInfo;

  @override
  Widget build(BuildContext context) {
  final theme = Theme.of(context);
    return InkWell(
      onTap: ()
      {
        //Open the selected item (website, mobile , dial) ....
        Utitlities.handleContactItemTap(contactInfo.contactItems[0]);
      }
      ,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
              BoxShadow(
              color: theme.shadowColor.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ]
        ),
          child: Row(
          children: [
            Icon(contactInfo.cardType.icon, color: theme.iconTheme.color, size: 22,),
            const SizedBox(width: 12),
            Expanded(child: 
               Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contactInfo.cardType.label,
                    style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text( (contactInfo.contactItems[0].value.length <= 30)?contactInfo.contactItems[0].value : '${contactInfo.contactItems[0].value.substring(0,26)}...' ,   style: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor),),

                ],
              ),
            ),
                  Icon(Icons.arrow_forward_ios, size: 14, color: theme.hintColor),
          ]
          )
      )
    );
  }
}


  //    InkWell(
  //     onTap: () {
  //       setState(() {
  //       isExpanded = !isExpanded; //togle expanded state          
  //       });        
  //     },
  //     child: Container(
  //       margin: const EdgeInsets.symmetric(vertical: 6),
  //       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
  //       decoration: BoxDecoration(
  //         color: theme.cardColor,
  //         borderRadius: BorderRadius.circular(14),
  //         boxShadow: [
  //           BoxShadow(
  //             color: theme.shadowColor.withOpacity(0.1),
  //             blurRadius: 4,
  //             offset: const Offset(0, 2),
  //           ),
  //         ],
  //       ),
  //       child: Row(
  //         children: [
  //           Icon(widget.cardType.icon, color: theme.iconTheme.color, size: 20),
  //           const SizedBox(width: 12),
  //           Expanded(
  //             child: (widget.values.length > 1)?   
  //             //If there is multiple items    
  //             Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                   Text(
  //                   widget.cardType.label,
  //                   style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
  //                 ),
  //                 Text(
  //                       '${widget.values.length} ${widget.itemCountLabel?? 'items'}',
  //                       style: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor),
  //                     )
      
  //               ],
  //             )     
              
      
  //             //There is 
  //             : Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   widget.cardType.label,
  //                   style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
  //                 ),
  //                 ...widget.values.map((val) => Text(
  //                       val,
  //                       style: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor),
  //                     )),
  //               ],
  //             ),
  //           ),
  //           (widget.values.length > 1)
  //       ? Icon(Icons.expand_more, size: 20, color: theme.hintColor)
  //       : Icon(Icons.arrow_forward_ios, size: 14, color: theme.hintColor),
      
  //         ],
  //       ),
  //     ),
  //   );
  // }
  
