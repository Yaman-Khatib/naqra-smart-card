import 'package:naqra_web/models/card_type.dart';
import 'package:naqra_web/models/contact_info.dart';
import 'package:naqra_web/models/contact_info_item.dart';
import 'package:naqra_web/models/profile.dart';

final profile =  Profile(name: 'Yaman Alkhatib',
     bio: 'Building rust applications that are scalable\nCompleted over 15 desktop projects.'
    , keywords: ['ASP.NET', 'EF Core', 'Flutter'], title: 'Full-Stack developer',
     contacts: [
      ContactInfo(cardType: CardType.phone,
      contactItems: [
        ContactInfoItem(value: '+96953786593', type: ContactItemType.mobile),
        ContactInfoItem(value: '+963912786590', type: ContactItemType.mobile),
        ContactInfoItem(value: '+963311453', type: ContactItemType.home),
        ContactInfoItem(value: '+963321753', type: ContactItemType.work)
     ]
     ),
     ContactInfo(cardType: CardType.email,
      contactItems: [ContactInfoItem(value: 'yaman.khateeb.hasni@gmail.com', type: ContactItemType.email),
      ContactInfoItem(value: 'yaman.khateeb@outlook.com', type: ContactItemType.email)
      ]
       ),
     ContactInfo(cardType: CardType.instagram, contactItems: [ContactInfoItem(value: '@yaman_khateeb.it', type: ContactItemType.other)]),
     ContactInfo(cardType: CardType.facebook, contactItems: [ContactInfoItem(value: 'Yaman Alkhateeb', type: ContactItemType.other)]),
     ContactInfo(cardType: CardType.resume, contactItems: [ContactInfoItem(value: 'Yaman_resume', type: ContactItemType.other)])
     ],
     locationUrl: 'https://maps.app.goo.gl/vYEr7MDoDYTcN8CCA' );
 