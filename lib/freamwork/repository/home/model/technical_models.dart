class SkillItem {
  final String name;
  final double level; // 0.0 → 1.0

  SkillItem(this.name, this.level);
}
class SkillCategory {
  final String title;
  final List<SkillItem> skills;

  SkillCategory({
    required this.title,
    required this.skills,
  });
}