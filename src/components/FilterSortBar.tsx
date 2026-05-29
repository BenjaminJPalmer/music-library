'use client'

import { useRouter, useSearchParams } from 'next/navigation'
import { useTransition } from 'react'

interface Props {
  composers: string[]
  publishers: string[]
  instruments: string[]
  current: {
    composer?: string
    publisher?: string
    instrument?: string
    sort?: string
  }
}

export function FilterSortBar({ composers, publishers, instruments, current }: Props) {
  const router = useRouter()
  const params = useSearchParams()
  const [isPending, startTransition] = useTransition()

  function update(key: string, value: string) {
    const next = new URLSearchParams(params.toString())
    if (value) {
      next.set(key, value)
    } else {
      next.delete(key)
    }
    // Reset to page 1 on filter change (future-proofing)
    next.delete('page')
    startTransition(() => {
      router.push(`/?${next.toString()}`)
    })
  }

  function clearAll() {
    startTransition(() => {
      router.push('/')
    })
  }

  const hasFilters = current.composer || current.publisher || current.instrument

  return (
    <div className={`flex flex-wrap gap-3 items-center mb-6 transition-opacity ${isPending ? 'opacity-50' : ''}`}>
      <select
        value={current.composer ?? ''}
        onChange={(e) => update('composer', e.target.value)}
        className="rounded-md border border-gray-200 bg-white px-3 py-1.5 text-sm text-gray-700 shadow-sm focus:outline-none focus:ring-2 focus:ring-gray-400"
      >
        <option value="">All composers</option>
        {composers.map((c) => (
          <option key={c} value={c}>
            {c}
          </option>
        ))}
      </select>

      <select
        value={current.publisher ?? ''}
        onChange={(e) => update('publisher', e.target.value)}
        className="rounded-md border border-gray-200 bg-white px-3 py-1.5 text-sm text-gray-700 shadow-sm focus:outline-none focus:ring-2 focus:ring-gray-400"
      >
        <option value="">All publishers</option>
        {publishers.map((p) => (
          <option key={p} value={p}>
            {p}
          </option>
        ))}
      </select>

      <select
        value={current.instrument ?? ''}
        onChange={(e) => update('instrument', e.target.value)}
        className="rounded-md border border-gray-200 bg-white px-3 py-1.5 text-sm text-gray-700 shadow-sm focus:outline-none focus:ring-2 focus:ring-gray-400"
      >
        <option value="">All instruments</option>
        {instruments.map((i) => (
          <option key={i} value={i}>
            {i}
          </option>
        ))}
      </select>

      <div className="ml-auto flex items-center gap-3">
        {hasFilters && (
          <button
            onClick={clearAll}
            className="text-sm text-gray-500 hover:text-gray-700 underline underline-offset-2"
          >
            Clear filters
          </button>
        )}
        <select
          value={current.sort ?? 'title'}
          onChange={(e) => update('sort', e.target.value)}
          className="rounded-md border border-gray-200 bg-white px-3 py-1.5 text-sm text-gray-700 shadow-sm focus:outline-none focus:ring-2 focus:ring-gray-400"
        >
          <option value="title">Sort: Title</option>
          <option value="composer">Sort: Composer</option>
        </select>
      </div>
    </div>
  )
}
