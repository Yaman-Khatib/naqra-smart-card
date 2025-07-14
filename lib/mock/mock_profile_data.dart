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
     ContactInfo(cardType: CardType.instagram, contactItems: [ContactInfoItem(value: 'http://instagram.com/alshami_cafe', type: ContactItemType.other)]),
     ContactInfo(cardType: CardType.facebook, contactItems: [ContactInfoItem(value: 'https://www.facebook.com/Alshami.sy.sy/', type: ContactItemType.other)]),
     ContactInfo(cardType: CardType.website, contactItems: [ContactInfoItem(value: 'https://naqra-landing-git-main-yamans-projects-ce41fbc4.vercel.app?_vercel_share=QkIU7QfwL3ykfQbnOWE7dz0PuPnkx3Xr', type: ContactItemType.website),
     ContactInfoItem(value: 'https://alshami-sy.sy/', type: ContactItemType.website)]),
     ContactInfo(cardType: CardType.resume, contactItems: [ContactInfoItem(value: 'https://s2.q4cdn.com/175719177/files/doc_presentations/Placeholder-PDF.pdf', type: ContactItemType.other)])
     ],
     locationUrl: 'https://maps.app.goo.gl/vYEr7MDoDYTcN8CCA' );
 