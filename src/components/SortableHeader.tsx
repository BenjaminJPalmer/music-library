'use client'

import { usePathname, useRouter, useSearchParams } from 'next/navigation'
import { useTransition } from 'react'

interface Props {
  column: string
  label: string
}

export function SortableHeader({ column, label }: Props) {
  const router = useRouter()
  const pathname = usePathname()
  const params = useSearchParams()
  const [isPending, startTransition] = useTransition()

  // Default sort is title ascending (matches the server-side default).
  const activeSort = params.get('sort') ?? 'title'
  const activeDir = params.get('dir') === 'desc' ? 'desc' : 'asc'
  const isActive = activeSort === column
  const nextDir = isActive && activeDir === 'asc' ? 'desc' : 'asc'

  function onClick() {
    const next = new URLSearchParams(params.toString())
    next.set('sort', column)
    next.set('dir', nextDir)
    startTransition(() => router.push(`${pathname}?${next.toString()}`))
  }

  return (
    <button
      type="button"
      onClick={onClick}
      title={`Sort by ${label.toLowerCase()}`}
      className={`inline-flex items-center gap-1 font-medium uppercase tracking-wide hover:text-gray-700 dark:hover:text-gray-200 transition-colors ${isPending ? 'opacity-50' : ''}`}
    >
      {label}
      <span className="text-[0.6rem] leading-none" aria-hidden="true">
        {isActive ? (activeDir === 'asc' ? '▲' : '▼') : '↕'}
      </span>
      {isActive && (
        <span className="sr-only">
          (sorted {activeDir === 'asc' ? 'ascending' : 'descending'})
        </span>
      )}
    </button>
  )
}
