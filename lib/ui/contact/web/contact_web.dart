
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_portfolio/freamwork/controller/home/home_controller.dart';
import 'package:personal_portfolio/freamwork/utils/extension/align_extension.dart';
import 'package:personal_portfolio/freamwork/utils/extension/context_extension.dart';
import 'package:personal_portfolio/ui/utils/helper/base_widget.dart';
import 'package:personal_portfolio/ui/utils/widgets/background_animation.dart';

class ContactWeb extends ConsumerStatefulWidget {
  const ContactWeb({super.key});

  @override
  ConsumerState<ContactWeb> createState() => _ContactWebState();
}

class _ContactWebState extends ConsumerState<ContactWeb> with BaseConsumerStatefulWidget {
  @override
  Widget buildPage(BuildContext context) {

    final watch  = ref.watch(homeController);

    return Container(
      width: context.width,
      height: context.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0A1628), Color(0xFF0E2239), Color(0xFF132F4C)],
        ),
      ),
      child: Stack(
        children: [
          SizedBox(
            width: context.width,
            height: context.height,
            child: Opacity(opacity: 0.8, child: ParticleBackground()),
          ),


          Container(
            padding: EdgeInsets.symmetric(
              vertical: context.height*0.01,
              horizontal: context.width*0.01
            ),
            child: Column(
              children: [
                SizedBox(height: 70.h),

                /// about Me Text
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 100.sp,
                      color: Colors.white,
                      wordSpacing: 2,
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      TextSpan(text: 'Get In'),

                      TextSpan(
                        text: ' Touch',
                        style: TextStyle(color: Colors.yellow),
                      ),
                    ],
                  ),
                ).alignAtCenter(),
                SizedBox(height: 70.h),
                Expanded(
                  child: Row(
                    children: [
                      // LEFT CARDS
                      Expanded(
                        child: Column(
                          children: [
                            Wrap(
                              spacing:context.width*0.03,
                              runSpacing: 30,
                              children:  [
                                _InfoCard(
                                  icon: Icons.phone,
                                  title: "Phone",
                                  value: "+91-8530321810",
                                  index: 0,
                                  highlight: watch.clickContactContainerMouse==0,
                                ),
                                _InfoCard(
                                  index: 1,
                                  icon: Icons.email,
                                  title: "Email",
                                  value: "ghegaderushikesh065@gmail.com",
                                  highlight: watch.clickContactContainerMouse==1,
                                ),
                                _InfoCard(
                                  index: 2,
                                  icon: Icons.business_center,
                                  title: "LinkedIn",
                                  value: "Connect on LinkedIn",
                                  highlight: watch.clickContactContainerMouse==2,
                                ),
                                _InfoCard(
                                  index: 3,
                                  icon: Icons.code,
                                  title: "GitHub",
                                  value: "View My Code",
                                  highlight: watch.clickContactContainerMouse==3,
                                ),
                              ],
                            ),

                            SizedBox(
                              height: context.height*0.06,
                            ),

                            Text(
                              "📍 ${watch.myLocation}",
                              style: TextStyle(
                                fontSize: 36.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                              ),
                            ),

                          ],
                        ),
                      ),

                      SizedBox(width: 30.h),

                      // RIGHT FORM
                      Expanded(
                        child: Container(
                              padding: const EdgeInsets.all(30),
                              decoration: BoxDecoration(
                                color: const Color(0xFF0E2233),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  _input(watch.nameController, "Name"),
                                  _input(watch.emailController, "Email"),
                                  _input(watch.subjectController, "Subject"),
                                  _input(
                                    watch.messageController,
                                    "Message",
                                    maxLines: 4,
                                  ),
                                  SizedBox(height: 20.h),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 75.h,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                        const Color(0xFFD4AF37),
                                        foregroundColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(19.r),
                                        ),
                                      ),
                                      onPressed: watch.isSending
                                          ? null
                                          : () =>
                                          watch.sendMessage(context),
                                      child: watch.isSending
                                          ? const CircularProgressIndicator(
                                        color: Colors.black,
                                      )
                                          : Text(
                                        "SEND MESSAGE",
                                        style: TextStyle(
                                          fontSize: 29.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      ),
                    ],
                  ),
                ),


                SizedBox(
                  height: 50.h,
                ),

                Text(
                  '© 2026 Rushikesh Ghegade. All rights reserved.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 34.sp,
                    letterSpacing: 0.5,
                  ),
                ).alignAtCenter(),
                SizedBox(height: 20.h),
                Text(
                  'Designed & Built with Flutter',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 33.sp,
                  ),
                ).alignAtCenter(),
                SizedBox(height: 10.h),
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget _input(
      TextEditingController controller,
      String hint, {
        int maxLines = 1,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white24),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFD4AF37)),
          ),
        ),
      ),
    );
  }
}


class _InfoCard extends ConsumerWidget {
  final IconData icon;
  final String title;
  final String value;
  final bool highlight;
  final int index;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.index,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    final watch = ref.watch(homeController);

    return MouseRegion(
      onEnter: (e){
        watch.changeClickContactMouseContainer(index);
      },
      onExit: (e){
        watch.changeClickContactMouseContainer(-1);
      },
      child: GestureDetector(
        onTap: (){
          watch.changeClickContactContainer(index);
        },
        child: Container(
          // margin: EdgeInsets.only(left: context.width*0.02),
          padding: EdgeInsets.all(5.r),
          width: context.width*0.2,
          height: context.height*0.22,
          decoration: BoxDecoration(
            color: const Color(0xFF0E2233),
            borderRadius: BorderRadius.circular(20),
            border: (watch.clickContactContainer==index)|| highlight
                ? Border.all(color: Color(0xFFD4AF37))
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white),
              SizedBox(height: 10.h),
              Text(title, style: const TextStyle(color: Colors.white70)),
              SizedBox(height: 6.h),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
