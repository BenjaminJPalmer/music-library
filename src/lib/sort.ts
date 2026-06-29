// Columns the list views allow sorting by (also the whitelist that guards
// the user-supplied `sort` param before it reaches the query).
export const SORTABLE_COLUMNS = ['title', 'composer', 'publisher'] as const

export type SortColumn = (typeof SORTABLE_COLUMNS)[number]

/** Resolve untrusted `sort`/`dir` search params into a safe order spec. */
export function resolveSort(sort?: string, dir?: string): {
  column: SortColumn
  ascending: boolean
} {
  const column = (SORTABLE_COLUMNS as readonly string[]).includes(sort ?? '')
    ? (sort as SortColumn)
    : 'title'
  return { column, ascending: dir !== 'desc' }
}
