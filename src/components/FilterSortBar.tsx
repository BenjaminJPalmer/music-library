'use client'

import { useRouter, useSearchParams } from 'next/navigation'
import { useEffect, useState, useTransition } from 'react'
import { toTitleCase } from '@/lib/format'
import { MultiSelect } from '@/components/MultiSelect'
import { SelectFilter } from '@/components/SelectFilter'

interface Props {
  composers: string[]
  publishers: string[]
  instruments: string[]
  categories: string[]
  current: {
    composer?: string
    publisher?: string
    category?: string
    instruments: string[]
    q?: string
  }
}

export function FilterSortBar({ composers, publishers, instruments, categories, current }: Props) {
  const router = useRouter()
  const params = useSearchParams()
  const [isPending, startTransition] = useTransition()
  const urlQ = current.q ?? ''
  const [q, setQ] = useState(urlQ)
  const [prevUrlQ, setPrevUrlQ] = useState(urlQ)

  // Sync the input when the URL changes externally (e.g. "Clear filters").
  // Adjusting state during render is the recommended alternative to an effect.
  if (urlQ !== prevUrlQ) {
    setPrevUrlQ(urlQ)
    setQ(urlQ)
  }

  // Debounce search input -> URL so we don't navigate on every keystroke.
  useEffect(() => {
    if (q.trim() === urlQ) return
    const timer = setTimeout(() => update('q', q.trim()), 300)
    return () => clearTimeout(timer)
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [q, urlQ])

  function pushParams(next: URLSearchParams) {
    startTransition(() => {
      const qs = next.toString()
      router.push(qs ? `/?${qs}` : '/')
    })
  }

  function update(key: string, value: string) {
    const next = new URLSearchParams(params.toString())
    if (value) {
      next.set(key, value)
    } else {
      next.delete(key)
    }
    pushParams(next)
  }

  function updateInstruments(values: string[]) {
    const next = new URLSearchParams(params.toString())
    next.delete('instrument')
    values.forEach((v) => next.append('instrument', v))
    pushParams(next)
  }

  function clearAll() {
    startTransition(() => {
      router.push('/')
    })
  }

  const hasFilters =
    current.composer ||
    current.publisher ||
    current.category ||
    current.instruments.length ||
    current.q

  return (
    <div className={`flex flex-wrap gap-3 items-center mb-6 transition-opacity ${isPending ? 'opacity-50' : ''}`}>
      <input
        type="search"
        value={q}
        onChange={(e) => setQ(e.target.value)}
        placeholder="Search title or composer…"
        aria-label="Search by title or composer"
        className="rounded-md border border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-900 px-3 py-1.5 text-sm text-gray-700 dark:text-gray-300 shadow-sm focus:outline-none focus:ring-2 focus:ring-gray-400 dark:focus:ring-gray-600 w-full sm:w-64"
      />

      {categories.length > 0 && (
        <SelectFilter
          ariaLabel="Filter by category"
          value={current.category ?? ''}
          onChange={(v) => update('category', v)}
          options={[
            { value: '', label: 'All categories' },
            ...categories.map((c) => ({ value: c, label: c })),
          ]}
        />
      )}

      <SelectFilter
        ariaLabel="Filter by composer"
        value={current.composer ?? ''}
        onChange={(v) => update('composer', v)}
        options={[
          { value: '', label: 'All composers' },
          ...composers.map((c) => ({ value: c, label: toTitleCase(c) })),
        ]}
      />

      <SelectFilter
        ariaLabel="Filter by publisher"
        value={current.publisher ?? ''}
        onChange={(v) => update('publisher', v)}
        options={[
          { value: '', label: 'All publishers' },
          ...publishers.map((p) => ({ value: p, label: toTitleCase(p) })),
        ]}
      />

      <MultiSelect
        ariaLabel="Filter by instrument"
        noun="instruments"
        options={instruments}
        selected={current.instruments}
        onChange={updateInstruments}
      />

      {hasFilters && (
        <button
          onClick={clearAll}
          className="ml-auto text-sm text-gray-500 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-200 underline underline-offset-2"
        >
          Clear filters
        </button>
      )}
    </div>
  )
}
