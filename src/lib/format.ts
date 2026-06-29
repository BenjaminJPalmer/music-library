/**
 * Normalise a string to Title Case for display.
 *
 * Lower-cases everything first, then capitalises the first letter of each
 * word, so inconsistent source data like "CLARinet" and "clariNET" both
 * resolve to "Clarinet". Word boundaries include spaces and hyphens
 * (e.g. "cor-anglais" -> "Cor-Anglais").
 */
export function toTitleCase(value: string): string {
  // Capitalise any letter that isn't preceded by another letter, so the first
  // letter of every word is upper-cased regardless of the separator
  // (space, hyphen, slash, parenthesis, etc.).
  return value.toLowerCase().replace(/(?<!\p{L})\p{L}/gu, (c) => c.toUpperCase())
}
