import type { Metadata } from 'next'
import { Geist } from 'next/font/google'
import './globals.css'

const geist = Geist({ subsets: ['latin'] })

export const metadata: Metadata = {
  title: 'Music Library',
  description: 'Browse the music library',
}

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode
}>) {
  return (
    <html lang="en">
      <body className={`${geist.className} bg-white dark:bg-gray-950 text-gray-900 dark:text-gray-100 antialiased transition-colors`}>
        <div className="max-w-5xl mx-auto px-6 py-10">
          <header className="mb-10 border-b border-gray-100 dark:border-gray-800 pb-6">
            <a
              href="/"
              className="text-xl font-semibold tracking-tight hover:opacity-70 transition-opacity"
            >
              Music Library
            </a>
          </header>
          <main>{children}</main>
        </div>
      </body>
    </html>
  )
}
