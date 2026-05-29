'use server'

import { createClient } from '@/lib/supabase/server'
import { revalidatePath } from 'next/cache'
import { redirect } from 'next/navigation'

// ── Helpers ──────────────────────────────────────────────────────────────────

async function upsertComposer(
  supabase: Awaited<ReturnType<typeof createClient>>,
  name: string | null
): Promise<string | null> {
  if (!name?.trim()) return null
  const { data, error } = await supabase
    .from('composers')
    .upsert({ name: name.trim() }, { onConflict: 'name' })
    .select('id')
    .single()
  if (error) throw error
  return data.id
}

async function upsertPublisher(
  supabase: Awaited<ReturnType<typeof createClient>>,
  name: string | null
): Promise<string | null> {
  if (!name?.trim()) return null
  const { data, error } = await supabase
    .from('publishers')
    .upsert({ name: name.trim() }, { onConflict: 'name' })
    .select('id')
    .single()
  if (error) throw error
  return data.id
}

async function upsertInstruments(
  supabase: Awaited<ReturnType<typeof createClient>>,
  names: string[]
): Promise<string[]> {
  const trimmed = names.map((n) => n.trim()).filter(Boolean)
  if (!trimmed.length) return []

  const { data, error } = await supabase
    .from('instruments')
    .upsert(
      trimmed.map((name) => ({ name })),
      { onConflict: 'name' }
    )
    .select('id')
  if (error) throw error
  return data.map((r) => r.id)
}

async function setPieceInstruments(
  supabase: Awaited<ReturnType<typeof createClient>>,
  pieceId: string,
  instrumentIds: string[]
) {
  // Delete existing links first
  await supabase.from('piece_instruments').delete().eq('piece_id', pieceId)

  if (!instrumentIds.length) return

  const { error } = await supabase.from('piece_instruments').insert(
    instrumentIds.map((instrument_id) => ({ piece_id: pieceId, instrument_id }))
  )
  if (error) throw error
}

// ── Actions ───────────────────────────────────────────────────────────────────

export async function createPiece(formData: FormData) {
  const supabase = await createClient()

  const title = formData.get('title') as string
  const composerName = formData.get('composer') as string
  const publisherName = formData.get('publisher') as string
  const instrumentNames = formData.getAll('instrument') as string[]

  const [composerId, publisherId] = await Promise.all([
    upsertComposer(supabase, composerName),
    upsertPublisher(supabase, publisherName),
  ])

  const { data: piece, error } = await supabase
    .from('pieces')
    .insert({ title: title.trim(), composer_id: composerId, publisher_id: publisherId })
    .select('id')
    .single()

  if (error) throw error

  const instrumentIds = await upsertInstruments(supabase, instrumentNames)
  await setPieceInstruments(supabase, piece.id, instrumentIds)

  revalidatePath('/')
  revalidatePath('/admin')
  redirect('/admin')
}

export async function updatePiece(id: string, formData: FormData) {
  const supabase = await createClient()

  const title = formData.get('title') as string
  const composerName = formData.get('composer') as string
  const publisherName = formData.get('publisher') as string
  const instrumentNames = formData.getAll('instrument') as string[]

  const [composerId, publisherId] = await Promise.all([
    upsertComposer(supabase, composerName),
    upsertPublisher(supabase, publisherName),
  ])

  const { error } = await supabase
    .from('pieces')
    .update({ title: title.trim(), composer_id: composerId, publisher_id: publisherId })
    .eq('id', id)

  if (error) throw error

  const instrumentIds = await upsertInstruments(supabase, instrumentNames)
  await setPieceInstruments(supabase, id, instrumentIds)

  revalidatePath('/')
  revalidatePath('/admin')
  redirect('/admin')
}

export async function deletePiece(id: string) {
  const supabase = await createClient()
  const { error } = await supabase.from('pieces').delete().eq('id', id)
  if (error) throw error
  revalidatePath('/')
  revalidatePath('/admin')
}
