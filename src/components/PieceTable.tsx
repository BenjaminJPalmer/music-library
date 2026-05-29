interface Piece {
  id: string
  title: string
  composer: string | null
  publisher: string | null
  instruments: string[] | null
}

interface Props {
  pieces: Piece[]
}

export function PieceTable({ pieces }: Props) {
  if (!pieces.length) {
    return (
      <p className="text-gray-400 dark:text-gray-500 text-sm py-12 text-center">
        No pieces found. Try adjusting your filters.
      </p>
    )
  }

  return (
    <div className="overflow-x-auto">
      <table className="w-full text-sm text-left">
        <thead>
          <tr className="border-b border-gray-200 dark:border-gray-700 text-gray-500 dark:text-gray-400 text-xs uppercase tracking-wide">
            <th className="pb-3 pr-6 font-medium">Title</th>
            <th className="pb-3 pr-6 font-medium">Composer</th>
            <th className="pb-3 pr-6 font-medium">Instrumentation</th>
            <th className="pb-3 font-medium">Publisher</th>
          </tr>
        </thead>
        <tbody className="divide-y divide-gray-100 dark:divide-gray-800">
          {pieces.map((piece) => (
            <tr key={piece.id} className="hover:bg-gray-50 dark:hover:bg-gray-900 transition-colors">
              <td className="py-3 pr-6 font-medium text-gray-900 dark:text-gray-100 capitalize">{piece.title}</td>
              <td className="py-3 pr-6 text-gray-600 dark:text-gray-400 capitalize">{piece.composer ?? '—'}</td>
              <td className="py-3 pr-6 text-gray-600 dark:text-gray-400 capitalize">
                {piece.instruments?.length
                  ? piece.instruments.join(', ')
                  : '—'}
              </td>
              <td className="py-3 text-gray-600 dark:text-gray-400 capitalize">{piece.publisher ?? '—'}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  )
}
