'use client'

import { useRef, useState, useTransition } from 'react'
import { createPiece, updatePiece } from '@/actions/pieces'

interface Piece {
  id: string
  title: string
  composer: string | null
  publisher: string | null
  instruments: string[] | null
}

interface Props {
  piece?: Piece
  composers: string[]
  publishers: string[]
  instruments: string[]
}

export function PieceForm({ piece, composers, publishers, instruments }: Props) {
  const isEdit = !!piece
  const [isPending, startTransition] = useTransition()
  const [error, setError] = useState<string | null>(null)

  // Instrument rows — start with existing or one empty row
  const [instrumentRows, setInstrumentRows] = useState<string[]>(
    piece?.instruments?.length ? piece.instruments : ['']
  )

  const formRef = useRef<HTMLFormElement>(null)

  function addInstrumentRow() {
    setInstrumentRows((prev) => [...prev, ''])
  }

  function removeInstrumentRow(index: number) {
    setInstrumentRows((prev) => prev.filter((_, i) => i !== index))
  }

  function updateInstrumentRow(index: number, value: string) {
    setInstrumentRows((prev) => prev.map((v, i) => (i === index ? value : v)))
  }

  function handleSubmit(e: React.FormEvent<HTMLFormElement>) {
    e.preventDefault()
    setError(null)
    const formData = new FormData(e.currentTarget)

    startTransition(async () => {
      try {
        if (isEdit) {
          await updatePiece(piece.id, formData)
        } else {
          await createPiece(formData)
        }
      } catch (err) {
        // redirect() throws — let it propagate; only catch real errors
        if (err instanceof Error && err.message !== 'NEXT_REDIRECT') {
          setError(err.message)
        } else {
          throw err
        }
      }
    })
  }

  const inputClass =
    'w-full rounded-md border border-gray-200 px-3 py-2 text-sm text-gray-900 shadow-sm focus:outline-none focus:ring-2 focus:ring-gray-400 placeholder:text-gray-400'
  const labelClass = 'block text-sm font-medium text-gray-700 mb-1'

  return (
    <form ref={formRef} onSubmit={handleSubmit} className="space-y-5 max-w-lg">
      {error && (
        <div className="rounded-md bg-red-50 border border-red-200 px-4 py-3 text-sm text-red-700">
          {error}
        </div>
      )}

      {/* Title */}
      <div>
        <label htmlFor="title" className={labelClass}>
          Title <span className="text-red-500">*</span>
        </label>
        <input
          id="title"
          name="title"
          type="text"
          required
          defaultValue={piece?.title}
          placeholder="e.g. Symphony No. 5"
          className={inputClass}
        />
      </div>

      {/* Composer */}
      <div>
        <label htmlFor="composer" className={labelClass}>
          Composer
        </label>
        <input
          id="composer"
          name="composer"
          type="text"
          list="composers-list"
          defaultValue={piece?.composer ?? ''}
          placeholder="e.g. Beethoven"
          className={inputClass}
        />
        <datalist id="composers-list">
          {composers.map((c) => (
            <option key={c} value={c} />
          ))}
        </datalist>
      </div>

      {/* Publisher */}
      <div>
        <label htmlFor="publisher" className={labelClass}>
          Publisher
        </label>
        <input
          id="publisher"
          name="publisher"
          type="text"
          list="publishers-list"
          defaultValue={piece?.publisher ?? ''}
          placeholder="e.g. Breitkopf & Härtel"
          className={inputClass}
        />
        <datalist id="publishers-list">
          {publishers.map((p) => (
            <option key={p} value={p} />
          ))}
        </datalist>
      </div>

      {/* Instrumentation */}
      <div>
        <label className={labelClass}>Instrumentation</label>
        <div className="space-y-2">
          {instrumentRows.map((value, index) => (
            <div key={index} className="flex gap-2">
              <input
                name="instrument"
                type="text"
                list="instruments-list"
                value={value}
                onChange={(e) => updateInstrumentRow(index, e.target.value)}
                placeholder="e.g. Violin"
                className={inputClass}
              />
              {instrumentRows.length > 1 && (
                <button
                  type="button"
                  onClick={() => removeInstrumentRow(index)}
                  className="text-gray-400 hover:text-red-500 transition-colors px-1"
                  aria-label="Remove instrument"
                >
                  ✕
                </button>
              )}
            </div>
          ))}
          <datalist id="instruments-list">
            {instruments.map((i) => (
              <option key={i} value={i} />
            ))}
          </datalist>
          <button
            type="button"
            onClick={addInstrumentRow}
            className="text-sm text-gray-500 hover:text-gray-800 underline underline-offset-2"
          >
            + Add instrument
          </button>
        </div>
      </div>

      {/* Actions */}
      <div className="flex gap-3 pt-2">
        <button
          type="submit"
          disabled={isPending}
          className="rounded-md bg-gray-900 px-5 py-2 text-sm font-medium text-white hover:bg-gray-700 disabled:opacity-50 transition-colors"
        >
          {isPending ? 'Saving…' : isEdit ? 'Save changes' : 'Add piece'}
        </button>
        <a
          href="/admin"
          className="rounded-md border border-gray-200 px-5 py-2 text-sm font-medium text-gray-600 hover:bg-gray-50 transition-colors"
        >
          Cancel
        </a>
      </div>
    </form>
  )
}
