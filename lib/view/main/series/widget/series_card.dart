import 'package:dr_alshaal/config/env.dart';
import 'package:dr_alshaal/config/functions.dart';
import 'package:dr_alshaal/models/seriese/seriese.dart';
import 'package:dr_alshaal/resources/assets_manager.dart';
import 'package:dr_alshaal/resources/colors.dart';
import 'package:dr_alshaal/view/utils/widgets/divider.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

class SeriesCard extends StatelessWidget {
  final Seriese seriese;
  const SeriesCard({Key? key, required this.seriese}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: FancyShimmerImage(
                imageUrl: '${Env.baseMediaUrl}${seriese.mainImage}' ?? '',
                boxFit: BoxFit.fitHeight,
                errorWidget: Container(
                  color: Colors.grey[100],
                  child: Image.asset(
                    ImageAssets.logo,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: isTablet() ? 50 : null,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  seriese.title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: DesignColors.brown),
                  textAlign: TextAlign.center,
                  overflow: isTablet() ? TextOverflow.ellipsis : null,
                ),
              ),
            ),
            if (seriese.description != null || isTablet()) thickDivider(verticalPadding: 5),
            if (seriese.description != null || isTablet())
              SizedBox(
                height: isTablet() ? 50 : null,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    seriese.description,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: DesignColors.brown),
                    overflow: isTablet() ? TextOverflow.ellipsis : null,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
