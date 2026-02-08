/// Variable substitutor for prompt templates
class VariableSubstitutor {
  /// Standard variable pattern: {{variable}}
  static final RegExp standardPattern = RegExp(r'\{\{(\w+)\}\}');

  /// Conditional pattern: {{#if variable}}content{{/if}}
  static final RegExp conditionalPattern =
      RegExp(r'\{\{#if\s+(\w+)\}\}(.*?)\{\{/if\}\}', dotAll: true);

  /// Loop pattern: {{#each variable}}content{{/each}}
  static final RegExp loopPattern =
      RegExp(r'\{\{#each\s+(\w+)\}\}(.*?)\{\{/each\}\}', dotAll: true);

  /// Substitute all variables in the template
  static String substitute(String template, Map<String, dynamic> variables) {
    var result = template;

    // Process conditionals first
    result = _processConditionals(result, variables);

    // Process loops
    result = _processLoops(result, variables);

    // Process standard variables
    result = _processStandardVariables(result, variables);

    return result;
  }

  /// Process {{#if variable}}content{{/if}} patterns
  static String _processConditionals(
      String template, Map<String, dynamic> variables) {
    return template.replaceAllMapped(conditionalPattern, (match) {
      final varName = match.group(1)!;
      final content = match.group(2)!;

      final value = variables[varName];
      final isTruthy = value != null &&
          value != false &&
          value != '' &&
          (value is! List || value.isNotEmpty);

      return isTruthy ? substitute(content, variables) : '';
    });
  }

  /// Process {{#each variable}}content{{/each}} patterns
  static String _processLoops(
      String template, Map<String, dynamic> variables) {
    return template.replaceAllMapped(loopPattern, (match) {
      final varName = match.group(1)!;
      final content = match.group(2)!;

      final value = variables[varName];
      if (value is! List) return '';

      final buffer = StringBuffer();
      for (var i = 0; i < value.length; i++) {
        final itemVariables = Map<String, dynamic>.from(variables);
        itemVariables['this'] = value[i];
        itemVariables['@index'] = i;
        itemVariables['@first'] = i == 0;
        itemVariables['@last'] = i == value.length - 1;

        if (value[i] is Map) {
          itemVariables.addAll(Map<String, dynamic>.from(value[i]));
        }

        buffer.write(substitute(content, itemVariables));
      }

      return buffer.toString();
    });
  }

  /// Process {{variable}} patterns
  static String _processStandardVariables(
      String template, Map<String, dynamic> variables) {
    return template.replaceAllMapped(standardPattern, (match) {
      final varName = match.group(1)!;
      if (variables.containsKey(varName)) {
        final value = variables[varName];
        if (value is Map || value is List) {
          return _formatComplexValue(value);
        }
        return value?.toString() ?? '';
      }
      return match.group(0)!; // Keep original if no substitution
    });
  }

  /// Format complex values (maps/lists) for display
  static String _formatComplexValue(dynamic value) {
    if (value is Map) {
      return value.entries
          .map((e) => '${e.key}: ${e.value}')
          .join(', ');
    } else if (value is List) {
      return value.map((e) => e.toString()).join(', ');
    }
    return value.toString();
  }

  /// Extract variable names from a template
  static Set<String> extractVariables(String template) {
    final variables = <String>{};

    // Standard variables
    for (final match in standardPattern.allMatches(template)) {
      variables.add(match.group(1)!);
    }

    // Conditional variables
    for (final match in conditionalPattern.allMatches(template)) {
      variables.add(match.group(1)!);
    }

    // Loop variables
    for (final match in loopPattern.allMatches(template)) {
      variables.add(match.group(1)!);
    }

    return variables;
  }

  /// Validate that all required variables are provided
  static List<String> validateVariables(
    String template,
    Map<String, dynamic> variables,
  ) {
    final required = extractVariables(template);
    final provided = variables.keys.toSet();
    final missing = required.difference(provided);
    return missing.toList();
  }
}
