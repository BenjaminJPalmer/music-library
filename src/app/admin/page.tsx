import { createClient } from '@/lib/supabase/server'
import { DeleteButton } from '@/components/DeleteButton'
import { PieceTable } from '@/components/PieceTable'
import { resolveSort } from '@/lib/sort'
import Link from 'next/link'

export default async function AdminPage({
  searchParams,
}: {
  searchParams: Promise<{ sort?: string; dir?: string }>
}) {
  const { sort, dir } = await searchParams
  const supabase = await createClient()

  const { column, ascending } = resolveSort(sort, dir)
  const { data: pieces } = await supabase
    .from('piece_details')
    .select('*')
    .order(column, { ascending, nullsFirst: false })

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

      <PieceTable
        pieces={pieces ?? []}
        sortable
        emptyMessage={
          <>
            No pieces yet.{' '}
            <Link href="/admin/new" className="underline underline-offset-2">
              Add the first one.
            </Link>
          </>
        }
        renderActions={(piece) => (
          <>
            <Link
              href={`/admin/${piece.id}/edit`}
              className="text-sm text-gray-500 dark:text-gray-400 hover:text-gray-900 dark:hover:text-gray-100 transition-colors"
            >
              Edit
            </Link>
            <DeleteButton id={piece.id} title={piece.title} />
          </>
        )}
      />
    </>
  )
}
