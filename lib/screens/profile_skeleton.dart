import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProfileSkeleton extends StatelessWidget {
  const ProfileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return ListView(
      
      children: [

        // Title
        SizedBox(height: 60,),
        // Cover + Avatar
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            shimmerBox(
              width: double.infinity,
              height: 160,
              borderRadius: BorderRadius.circular(12),
            ),
            Positioned(
              bottom: -22,
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 40),

        // Name and Subtitle
        Center(
          child: Column(
            children: [
              shimmerBox(width: 150, height: 35),
              
            ],
          ),
        ),
      

        // Skill Chips
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 8,
          children: List.generate(3, (_) => shimmerBox(width: 80, height: 28, borderRadius: BorderRadius.circular(14))),
        ),
        const SizedBox(height: 16),

        // Quote Block
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
        
              Flexible(
                child: shimmerBox(
                  width: screenWidth * 0.8,
                  height: 80,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Save Contact Button
      
        // Contact Cards
        ...List.generate(5, (_) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: shimmerBox(
            width: double.infinity,
            height: 60,
            borderRadius: BorderRadius.circular(12),
          ),
        )),

        const SizedBox(height: 24),

        // Map Title Row
        shimmerBox(width: 150, height: 20),
        const SizedBox(height: 8),

        // Map
        shimmerBox(
          width: double.infinity,
          height: 200,
          borderRadius: BorderRadius.circular(12),
        ),
        const SizedBox(height: 8),

        // Google Maps Link
        Center(
          child: shimmerBox(width: 200, height: 14),
        ),
      ],
    );
  }

  /// Helper widget to simplify shimmer rectangles
  Widget shimmerBox({
    required double width,
    required double height,
    BorderRadius? borderRadius,
  }) {
   return Container(
  margin: const EdgeInsets.all(10),
  child: Shimmer.fromColors(
    baseColor: Colors.grey.shade200,
    highlightColor: Colors.grey.shade50,
    direction: ShimmerDirection.ltr, // left-to-right like LinkedIn
    period: const Duration(milliseconds: 1200),
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade300, // slightly tinted instead of pure white
        borderRadius: borderRadius ?? BorderRadius.circular(8),
      ),
    ),
  ),
);

  }
}
