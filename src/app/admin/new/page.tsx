import { createClient } from '@/lib/supabase/server'
import { PieceForm } from '@/components/PieceForm'

export default async function NewPiecePage() {
  const supabase = await createClient()

  const [composersResult, publishersResult, instrumentsResult] = await Promise.all([
    supabase.from('composers').select('name').order('name'),
    supabase.from('publishers').select('name').order('name'),
    supabase.from('instruments').select('name').order('name'),
  ])

  const composers = (composersResult.data ?? []).map((r) => r.name)
  const publishers = (publishersResult.data ?? []).map((r) => r.name)
  const instruments = (instrumentsResult.data ?? []).map((r) => r.name)

  return (
    <>
      <h1 className="text-lg font-semibold mb-6">Add piece</h1>
      <PieceForm composers={composers} publishers={publishers} instruments={instruments} />
    </>
  )
}
