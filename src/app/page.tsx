import { createClient } from '@/lib/supabase/server'
import { FilterSortBar } from '@/components/FilterSortBar'
import { PieceTable } from '@/components/PieceTable'
import { resolveSort } from '@/lib/sort'
import { Suspense } from 'react'

interface SearchParams {
  composer?: string
  publisher?: string
  instrument?: string | string[]
  category?: string
  sort?: string
  dir?: string
  q?: string
}

export default async function HomePage({
  searchParams,
}: {
  searchParams: Promise<SearchParams>
}) {
  const params = await searchParams
  const { composer, publisher, category, sort, dir, q } = params

  // `instrument` may appear multiple times in the URL — normalise to an array.
  const selectedInstruments = Array.isArray(params.instrument)
    ? params.instrument
    : params.instrument
      ? [params.instrument]
      : []

  const supabase = await createClient()

  // Fetch filter options and pieces in parallel
  const [
    piecesResult,
    composersResult,
    publishersResult,
    instrumentsResult,
    categoriesResult,
  ] = await Promise.all([
      (() => {
        let query = supabase.from('piece_details').select('*')
        if (composer) query = query.eq('composer', composer)
        if (publisher) query = query.eq('publisher', publisher)
        if (category) query = query.eq('category', category)
        // Match pieces scored for ALL of the selected instruments.
        if (selectedInstruments.length) {
          query = query.contains('instruments', selectedInstruments)
        }
        if (q?.trim()) {
          // Case-insensitive partial match on title OR composer. The value is
          // double-quoted so PostgREST treats reserved characters (, . ( )) as
          // literals; backslashes and quotes inside it are escaped. `*` remains
          // the wildcard. This avoids any filter-grammar injection.
          const term = q.trim().replace(/\\/g, '\\\\').replace(/"/g, '\\"')
          query = query.or(`title.ilike."*${term}*",composer.ilike."*${term}*"`)
        }
        const { column, ascending } = resolveSort(sort, dir)
        query = query.order(column, { ascending, nullsFirst: false })
        return query
      })(),
      supabase.from('composers').select('name').order('name'),
      supabase.from('publishers').select('name').order('name'),
      supabase.from('instruments').select('name').order('name'),
      // Categories live on the pieces themselves (no reference table); derive
      // the distinct list. Resilient if the column doesn't exist yet.
      supabase.from('pieces').select('category'),
    ])

  const pieces = piecesResult.data ?? []
  const composers = (composersResult.data ?? []).map((r) => r.name)
  const publishers = (publishersResult.data ?? []).map((r) => r.name)
  const instruments = (instrumentsResult.data ?? []).map((r) => r.name)
  const categories = Array.from(
    new Set((categoriesResult.data ?? []).map((r) => r.category).filter(Boolean))
  ).sort() as string[]

  const hasFilters =
    !!composer || !!publisher || !!category || selectedInstruments.length > 0 || !!q

  return (
    <>
      <Suspense>
        <FilterSortBar
          composers={composers}
          publishers={publishers}
          instruments={instruments}
          categories={categories}
          current={{ composer, publisher, category, instruments: selectedInstruments, q }}
        />
      </Suspense>

      <PieceTable pieces={pieces} sortable />

      <p className="mt-6 text-xs text-gray-400">
        {pieces.length} {pieces.length === 1 ? 'piece' : 'pieces'}
        {hasFilters ? ' matching filters' : ' in library'}
      </p>
    </>
  )
}
