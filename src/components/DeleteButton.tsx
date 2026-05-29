'use client'

import { useTransition } from 'react'
import { deletePiece } from '@/actions/pieces'

interface Props {
  id: string
  title: string
}

export function DeleteButton({ id, title }: Props) {
  const [isPending, startTransition] = useTransition()

  function handleDelete() {
    if (!confirm(`Delete "${title}"? This cannot be undone.`)) return
    startTransition(() => deletePiece(id))
  }

  return (
    <button
      onClick={handleDelete}
      disabled={isPending}
      className="text-sm text-red-500 hover:text-red-700 disabled:opacity-40 transition-colors"
    >
      {isPending ? 'Deleting…' : 'Delete'}
    </button>
  )
}
