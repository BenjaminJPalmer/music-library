import type { ReactNode } from 'react'
import { SortableHeader } from '@/components/SortableHeader'

interface Piece {
  id: string
  title: string
  composer: string | null
  publisher: string | null
  instruments: string[] | null
}

interface Props {
  pieces: Piece[]
  /** Shown when there are no pieces. Defaults to a public-facing message. */
  emptyMessage?: ReactNode
  /** When provided, an actions column is rendered with these controls per row. */
  renderActions?: (piece: Piece) => ReactNode
  /** When true, Title/Composer/Publisher headers become clickable sort toggles. */
  sortable?: boolean
}

export function PieceTable({ pieces, emptyMessage, renderActions, sortable }: Props) {
  if (!pieces.length) {
    return (
      <p className="text-gray-400 dark:text-gray-500 text-sm py-12 text-center">
        {emptyMessage ?? 'No pieces found. Try adjusting your filters.'}
      </p>
    )
  }

  const hasActions = !!renderActions

  return (
    <div className="overflow-x-auto">
      <table className="w-full text-sm text-left">
        <thead>
          <tr className="border-b border-gray-200 dark:border-gray-700 text-gray-500 dark:text-gray-400 text-xs uppercase tracking-wide">
            <th className="pb-3 pr-6 font-medium">
              {sortable ? <SortableHeader column="title" label="Title" /> : 'Title'}
            </th>
            <th className="pb-3 pr-6 font-medium">
              {sortable ? <SortableHeader column="composer" label="Composer" /> : 'Composer'}
            </th>
            <th className="pb-3 pr-6 font-medium">Instrumentation</th>
            <th className={`pb-3 font-medium${hasActions ? ' pr-6' : ''}`}>
              {sortable ? <SortableHeader column="publisher" label="Publisher" /> : 'Publisher'}
            </th>
            {hasActions && <th className="pb-3 font-medium" />}
          </tr>
        </thead>
        <tbody className="divide-y divide-gray-100 dark:divide-gray-800">
          {pieces.map((piece) => (
            <tr
              key={piece.id}
              className={`hover:bg-gray-50 dark:hover:bg-gray-900 transition-colors${hasActions ? ' group' : ''}`}
            >
              <td className="py-3 pr-6 font-medium text-gray-900 dark:text-gray-100 capitalize">{piece.title}</td>
              <td className="py-3 pr-6 text-gray-600 dark:text-gray-400 capitalize">{piece.composer ?? '—'}</td>
              <td className="py-3 pr-6 text-gray-600 dark:text-gray-400 capitalize">
                {piece.instruments?.length ? piece.instruments.join(', ') : '—'}
              </td>
              <td className={`py-3 text-gray-600 dark:text-gray-400 capitalize${hasActions ? ' pr-6' : ''}`}>
                {piece.publisher ?? '—'}
              </td>
              {hasActions && (
                <td className="py-3 text-right">
                  <div className="flex items-center justify-end gap-3 opacity-0 group-hover:opacity-100 transition-opacity">
                    {renderActions(piece)}
                  </div>
                </td>
              )}
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  )
}
