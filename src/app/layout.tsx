import type { Metadata } from 'next'
import { Geist } from 'next/font/google'
import Link from 'next/link'
import './globals.css'
import { ThemeToggle } from '@/components/ThemeToggle'

const geist = Geist({ subsets: ['latin'] })

export const metadata: Metadata = {
  title: 'Palmer Music Library',
  description: 'Browse the Palmer Music Library',
}

// Applies the saved theme (falling back to the OS preference) before paint,
// so there's no flash of the wrong theme on load.
const themeInitScript = `
(function () {
  try {
    var stored = localStorage.getItem('theme');
    var dark = stored ? stored === 'dark'
      : window.matchMedia('(prefers-color-scheme: dark)').matches;
    if (dark) document.documentElement.classList.add('dark');
  } catch (e) {}
})();
`

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode
}>) {
  return (
    <html lang="en" suppressHydrationWarning>
      <head>
        <script dangerouslySetInnerHTML={{ __html: themeInitScript }} />
      </head>
      <body className={`${geist.className} bg-white dark:bg-gray-950 text-gray-900 dark:text-gray-100 antialiased transition-colors`}>
        <div className="max-w-5xl mx-auto px-6 py-10">
          <header className="mb-10 border-b border-gray-100 dark:border-gray-800 pb-6 flex items-center justify-between gap-4">
            <Link
              href="/"
              className="text-xl font-semibold tracking-tight hover:opacity-70 transition-opacity"
            >
              Palmer Music Library
            </Link>
            <ThemeToggle />
          </header>
          <main>{children}</main>
        </div>
      </body>
    </html>
  )
}
