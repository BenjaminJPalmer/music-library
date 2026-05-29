import { createClient } from '@/lib/supabase/server'
import { FilterSortBar } from '@/components/FilterSortBar'
import { PieceTable } from '@/components/PieceTable'
import { Suspense } from 'react'

interface SearchParams {
  composer?: string
  publisher?: string
  instrument?: string
  sort?: string
}

export default async function HomePage({
  searchParams,
}: {
  searchParams: Promise<SearchParams>
}) {
  const params = await searchParams
  const { composer, publisher, instrument, sort } = params

  const supabase = await createClient()

  // Fetch filter options and pieces in parallel
  const [piecesResult, composersResult, publishersResult, instrumentsResult] =
    await Promise.all([
      (() => {
        let query = supabase.from('piece_details').select('*')
        if (composer) query = query.eq('composer', composer)
        if (publisher) query = query.eq('publisher', publisher)
        if (instrument) query = query.contains('instruments', [instrument])
        const sortCol = sort === 'composer' ? 'composer' : 'title'
        query = query.order(sortCol, { nullsFirst: false })
        return query
      })(),
      supabase.from('composers').select('name').order('name'),
      supabase.from('publishers').select('name').order('name'),
      supabase.from('instruments').select('name').order('name'),
    ])

  const pieces = piecesResult.data ?? []
  const composers = (composersResult.data ?? []).map((r) => r.name)
  const publishers = (publishersResult.data ?? []).map((r) => r.name)
  const instruments = (instrumentsResult.data ?? []).map((r) => r.name)

  return (
    <>
      <Suspense>
        <FilterSortBar
          composers={composers}
          publishers={publishers}
          instruments={instruments}
          current={{ composer, publisher, instrument, sort }}
        />
      </Suspense>

      <PieceTable pieces={pieces} />

      <p className="mt-6 text-xs text-gray-400">
        {pieces.length} {pieces.length === 1 ? 'piece' : 'pieces'}
        {(composer || publisher || instrument) ? ' matching filters' : ' in library'}
      </p>
    </>
  )
}
