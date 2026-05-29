import { createClient } from '@/lib/supabase/server'
import { DeleteButton } from '@/components/DeleteButton'
import Link from 'next/link'

export default async function AdminPage() {
  const supabase = await createClient()

  const { data: pieces } = await supabase
    .from('piece_details')
    .select('*')
    .order('title')

  return (
    <>
      <div className="flex items-center justify-between mb-6">
        <h1 className="text-lg font-semibold">All pieces</h1>
        <Link
          href="/admin/new"
          className="rounded-md bg-gray-900 dark:bg-gray-100 px-4 py-2 text-sm font-medium text-white dark:text-gray-900 hover:bg-gray-700 dark:hover:bg-gray-300 transition-colors"
        >
          + Add piece
        </Link>
      </div>

      {!pieces?.length ? (
        <p className="text-gray-400 dark:text-gray-500 text-sm py-12 text-center">
          No pieces yet.{' '}
          <Link href="/admin/new" className="underline underline-offset-2">
            Add the first one.
          </Link>
        </p>
      ) : (
        <div className="overflow-x-auto">
          <table className="w-full text-sm text-left">
            <thead>
              <tr className="border-b border-gray-200 dark:border-gray-700 text-gray-500 dark:text-gray-400 text-xs uppercase tracking-wide">
                <th className="pb-3 pr-6 font-medium">Title</th>
                <th className="pb-3 pr-6 font-medium">Composer</th>
                <th className="pb-3 pr-6 font-medium">Instrumentation</th>
                <th className="pb-3 pr-6 font-medium">Publisher</th>
                <th className="pb-3 font-medium"></th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-100 dark:divide-gray-800">
              {pieces.map((piece) => (
                <tr key={piece.id} className="hover:bg-gray-50 dark:hover:bg-gray-900 transition-colors group">
                  <td className="py-3 pr-6 font-medium text-gray-900 dark:text-gray-100 capitalize">{piece.title}</td>
                  <td className="py-3 pr-6 text-gray-600 dark:text-gray-400 capitalize">{piece.composer ?? '—'}</td>
                  <td className="py-3 pr-6 text-gray-600 dark:text-gray-400 capitalize">
                    {piece.instruments?.length ? piece.instruments.join(', ') : '—'}
                  </td>
                  <td className="py-3 pr-6 text-gray-600 dark:text-gray-400 capitalize">{piece.publisher ?? '—'}</td>
                  <td className="py-3 text-right">
                    <div className="flex items-center justify-end gap-3 opacity-0 group-hover:opacity-100 transition-opacity">
                      <Link
                        href={`/admin/${piece.id}/edit`}
                        className="text-sm text-gray-500 dark:text-gray-400 hover:text-gray-900 dark:hover:text-gray-100 transition-colors"
                      >
                        Edit
                      </Link>
                      <DeleteButton id={piece.id} title={piece.title} />
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}
    </>
  )
}
