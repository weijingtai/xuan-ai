/// Port for accessing the expertise catalog (divination types, skills, etc.)
///
/// Abstracts away the direct database dependency so AiPersonaEditor
/// can work without requiring a concrete AppDatabase at runtime.
abstract class ExpertiseCatalogPort {
  Future<List<ExpertiseDivinationType>> getDivinationTypes();
  Future<List<ExpertiseSubDivinationType>> getSubDivinationTypes();
  Future<List<ExpertiseSkill>> getSkills();
  Future<List<ExpertiseSkillClass>> getSkillClasses();
}

class ExpertiseDivinationType {
  final String uuid;
  final String name;
  const ExpertiseDivinationType({required this.uuid, required this.name});
}

class ExpertiseSubDivinationType {
  final String uuid;
  final String name;
  const ExpertiseSubDivinationType({required this.uuid, required this.name});
}

class ExpertiseSkill {
  final int id;
  final String name;
  const ExpertiseSkill({required this.id, required this.name});
}

class ExpertiseSkillClass {
  final String uuid;
  final String name;
  final int skillId;
  const ExpertiseSkillClass({
    required this.uuid,
    required this.name,
    required this.skillId,
  });
}
