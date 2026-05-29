import { createClient } from '@/lib/supabase/server'
import { PieceForm } from '@/components/PieceForm'
import { notFound } from 'next/navigation'

export default async function EditPiecePage({
  params,
}: {
  params: Promise<{ id: string }>
}) {
  const { id } = await params
  const supabase = await createClient()

  const [pieceResult, composersResult, publishersResult, instrumentsResult] =
    await Promise.all([
      supabase.from('piece_details').select('*').eq('id', id).single(),
      supabase.from('composers').select('name').order('name'),
      supabase.from('publishers').select('name').order('name'),
      supabase.from('instruments').select('name').order('name'),
    ])

  if (!pieceResult.data) notFound()

  const composers = (composersResult.data ?? []).map((r) => r.name)
  const publishers = (publishersResult.data ?? []).map((r) => r.name)
  const instruments = (instrumentsResult.data ?? []).map((r) => r.name)

  return (
    <>
      <h1 className="text-lg font-semibold mb-6">Edit piece</h1>
      <PieceForm
        piece={pieceResult.data}
        composers={composers}
        publishers={publishers}
        instruments={instruments}
      />
    </>
  )
}
