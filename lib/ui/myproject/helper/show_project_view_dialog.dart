import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_portfolio/freamwork/controller/home/home_controller.dart';
import 'package:personal_portfolio/freamwork/repository/home/model/project_info_model.dart';
import 'package:personal_portfolio/freamwork/utils/extension/context_extension.dart';

void showProjectDialog(
  BuildContext context,
  ProjectInfoModel projectInfoModel,
) {
  showDialog(
    context: context,
    barrierColor: Colors.black54,
    builder: (_) => ProjectDialog(projectInfoModel: projectInfoModel),
  );
}

class ProjectDialog extends ConsumerWidget {
  final ProjectInfoModel projectInfoModel;

  const ProjectDialog({super.key, required this.projectInfoModel});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final watch = ref.watch(homeController);
    final isDark = watch.isDarkOn;
    final projectImages = projectInfoModel.mediaAssets
        .where(
          (m) => m.type.toLowerCase().startsWith('image'),
        )
        .take(3)
        .toList();
    final textColor = isDark ? Colors.white : const Color(0xFF102A43);
    final subTextColor = isDark ? Colors.white70 : const Color(0xFF52606D);
    final surface = isDark ? const Color(0xFF0B1A2E) : Colors.white;
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(24),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: ((context.width - 32) * 0.92).clamp(280.0, 980),
          maxHeight: (context.height * 0.85).clamp(280.0, 760),
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: surface,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.14),
                blurRadius: 26,
                offset: const Offset(0, 12),
              ),
            ],
            border: Border.all(
              color: const Color(0xFFF5C542).withValues(alpha: isDark ? 0.28 : 0.2),
            ),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 36),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        projectInfoModel.projectName,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFF5C542),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        'Project Overview',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: List.generate(
                          projectInfoModel.technoloty.length,
                          (index) => _TagChip(
                            projectInfoModel.technoloty[index],
                            isDark: isDark,
                          ),
                        ),
                      ),
                      if (projectImages.isNotEmpty) ...[
                        const SizedBox(height: 14),
                        SizedBox(
                          height: 130,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: projectImages.length,
                            separatorBuilder: (_, _) => const SizedBox(width: 10),
                            itemBuilder: (context, index) {
                              final imageUrl = projectImages[index].url.trim();

                              return ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  width: 180,
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? const Color(0xFF11233B)
                                        : const Color(0xFFE9EEF6),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: imageUrl.isEmpty
                                      ? const Center(
                                    child: Icon(Icons.image_not_supported_outlined),
                                  )
                                      : Image.network(
                                    imageUrl,
                                    fit: BoxFit.cover,
                                    filterQuality: FilterQuality.high,
                                    loadingBuilder: (
                                        context,
                                        child,
                                        loadingProgress,
                                        ) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }

                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                    frameBuilder: (
                                        context,
                                        child,
                                        frame,
                                        wasSynchronouslyLoaded,
                                        ) {
                                      if (wasSynchronouslyLoaded) {
                                        return child;
                                      }

                                      return AnimatedOpacity(
                                        opacity: frame == null ? 0 : 1,
                                        duration: const Duration(milliseconds: 300),
                                        child: child,
                                      );
                                    },
                                    errorBuilder: (
                                        context,
                                        error,
                                        stackTrace,
                                        ) {
                                      debugPrint(
                                        "Image Error => $error\nURL => $imageUrl",
                                      );

                                      return const Center(
                                        child: Icon(
                                          Icons.broken_image_outlined,
                                          size: 40,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                      const SizedBox(height: 14),
                      Text(
                        projectInfoModel.projectDis,
                        style: TextStyle(
                          color: subTextColor,
                          fontSize: 13,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 18),
                      InkWell(
                        onTap: () => watch.openLink(projectInfoModel.gitHubLink),
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5C542).withValues(alpha: isDark ? 0.16 : 0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'View GitHub Repo ↗',
                            style: TextStyle(
                              color: Color(0xFFF5C542),
                              fontWeight: FontWeight.w700,
                              fontSize: 12.5,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: -4,
                right: -6,
                child: IconButton(
                  icon: Icon(
                    Icons.close_rounded,
                    color: textColor.withValues(alpha: 0.75),
                    size: 20,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  final String title;
  final bool isDark;
  const _TagChip(this.title, {required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFF5C542)),
        color: const Color(0xFFF5C542).withValues(alpha: isDark ? 0.12 : 0.18),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xFFF5C542),
          fontSize: 11.5,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
