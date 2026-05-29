import { createClient } from '@/lib/supabase/server'

export default async function AdminLayout({
  children,
}: {
  children: React.ReactNode
}) {
  const supabase = await createClient()
  const {
    data: { user },
  } = await supabase.auth.getUser()

  return (
    <>
      {user && (
        <nav className="flex items-center justify-between mb-8 pb-4 border-b border-gray-100">
          <div className="flex items-center gap-4 text-sm">
            <a
              href="/admin"
              className="text-gray-600 hover:text-gray-900 transition-colors"
            >
              Library
            </a>
            <a
              href="/admin/new"
              className="text-gray-600 hover:text-gray-900 transition-colors"
            >
              + Add piece
            </a>
          </div>
          <div className="flex items-center gap-4 text-sm text-gray-500">
            <span>{user.email}</span>
            <form action="/auth/signout" method="post">
              <button
                type="submit"
                className="text-gray-500 hover:text-gray-800 underline underline-offset-2"
              >
                Sign out
              </button>
            </form>
          </div>
        </nav>
      )}
      {children}
    </>
  )
}
