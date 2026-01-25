
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_portfolio/freamwork/controller/home/home_controller.dart';
import 'package:personal_portfolio/freamwork/utils/extension/align_extension.dart';
import 'package:personal_portfolio/freamwork/utils/extension/context_extension.dart';
import 'package:personal_portfolio/ui/utils/helper/base_widget.dart';
import 'package:personal_portfolio/ui/utils/widgets/background_animation.dart';

class TestimonialWeb extends ConsumerStatefulWidget {
  const TestimonialWeb({super.key});

  @override
  ConsumerState<TestimonialWeb> createState() => _TestimonialWebState();
}

class _TestimonialWebState extends ConsumerState<TestimonialWeb> with BaseConsumerStatefulWidget {
  @override
  Widget buildPage(BuildContext context) {

    final watch = ref.watch(homeController);

    return Container(
      height: context.height,
      width: context.width,

      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0A1628), Color(0xFF0E2239), Color(0xFF132F4C)],
        ),
      ),
      child: Stack(
        children: [
          /// background dots
          SizedBox(
            width: context.width,
            height: context.height,
            child: Opacity(opacity: 0.8, child: ParticleBackground()),
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: context.width*0.02,vertical: context.height*0.1),
            child: Column(
              children: [
                SizedBox(height: 50.h),
                /// my skills Me Text

                // Icon(Icons.format_quote, color: Color(0xFFC3A854),size: context.height*0.08,).alignAtCenter(),

                const Text(
                  '“',
                  style: TextStyle(
                    fontSize: 64,
                    color: Color(0xFFF5C542),
                    height: 0.8,
                  ),
                ),
                SizedBox(height: 100.h),

                Flexible(
                  child: PageView.builder(
                    itemCount: watch.testimonials.length,
                    onPageChanged: (i) => setState(() => watch.currentTestimonialIndex = i),
                    itemBuilder: (context, index) {
                      final t = watch.testimonials[index];
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 120),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              const SizedBox(height: 40),
                              Text(
                                t.text,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.white70,
                                  fontStyle: FontStyle.italic,
                                  height: 1.6,
                                ),
                              ),
                              const SizedBox(height: 32),
                              Text(
                                t.role,
                                style: const TextStyle(
                                  color: Color(0xFFF5C542),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                t.company,
                                style: const TextStyle(
                                  color: Colors.white60,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),


                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    watch.testimonials.length,
                        (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index == watch.currentTestimonialIndex
                            ? const Color(0xFFF5C542)
                            : Colors.white24,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),

              ],
            ),
          ),
        ],
      ),
    );
  }
}






