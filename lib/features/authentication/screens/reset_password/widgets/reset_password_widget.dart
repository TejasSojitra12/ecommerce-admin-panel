import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../routes/routes.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class ResetPasswordWidget extends StatelessWidget {
  const ResetPasswordWidget({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final email = Get.arguments??'';
    return Column(
      children: [
        /// Header
        Row(
          children: [
            IconButton(onPressed: ()=>Get.offAllNamed(TRoutes.login), icon: const Icon(CupertinoIcons.clear)),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems,),

        /// Image
        const Image(image: AssetImage(TImages.deliveredEmailIllustration),width: 300,height: 300,),
        const SizedBox(height: TSizes.spaceBtwItems,),

        /// Title & SunTitle
        Text(TTexts.changeYourPasswordTitle,style: Theme.of(context).textTheme.headlineMedium,textAlign: TextAlign.center,),
        const SizedBox(height: TSizes.spaceBtwItems,),
        Text(email,style: Theme.of(context).textTheme.labelLarge,textAlign: TextAlign.center,),
        const SizedBox(height: TSizes.spaceBtwItems,),
        Text(TTexts.changeYourPasswordSubTitle,style: Theme.of(context).textTheme.labelMedium,textAlign: TextAlign.center,),
        const SizedBox(height: TSizes.spaceBtwSections,),

        /// Buttons
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(onPressed: ()=>Get.back(), child: const Text(TTexts.done)),
        ),
        const SizedBox(height: TSizes.spaceBtwItems,),
        SizedBox(
          width: double.infinity,
          child: TextButton(onPressed: (){}, child: const Text(TTexts.resendEmail)),
        ),
      ],
    );
  }
}
