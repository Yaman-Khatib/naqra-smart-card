import 'package:flutter/material.dart';
import 'package:naqra_web/utils/utitlities.dart';
class MapWidget extends StatelessWidget {
  const MapWidget(this.locationUrl,{super.key});
  final String locationUrl;
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
                onTap: ()async
                {
                Utitlities.openExternalLink(locationUrl);
                } ,
                child: Container(
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/map.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
  }
}