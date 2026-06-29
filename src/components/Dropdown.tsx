'use client'

import { useEffect, useRef, useState, type ReactNode } from 'react'

interface Props {
  /** Content shown inside the trigger button (e.g. the current selection). */
  label: ReactNode
  ariaLabel: string
  /** Panel content. Receives a `close` callback to dismiss the panel. */
  children: (close: () => void) => ReactNode
}

// Shared dropdown shell: a trigger button with a custom ▾ and a bordered panel
// rendered below it, with click-outside-to-close handling. Used by both
// SelectFilter and MultiSelect so they stay visually identical.
export function Dropdown({ label, ariaLabel, children }: Props) {
  const [open, setOpen] = useState(false)
  const ref = useRef<HTMLDivElement>(null)

  // Close the panel when clicking outside it.
  useEffect(() => {
    if (!open) return
    function onDocClick(e: MouseEvent) {
      if (ref.current && !ref.current.contains(e.target as Node)) setOpen(false)
    }
    document.addEventListener('mousedown', onDocClick)
    return () => document.removeEventListener('mousedown', onDocClick)
  }, [open])

  return (
    <div className="relative" ref={ref}>
      <button
        type="button"
        onClick={() => setOpen((o) => !o)}
        aria-haspopup="listbox"
        aria-expanded={open}
        aria-label={ariaLabel}
        className="flex items-center gap-2 rounded-md border border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-900 px-3 py-1.5 text-sm text-gray-700 dark:text-gray-300 shadow-sm focus:outline-none focus:ring-2 focus:ring-gray-400 dark:focus:ring-gray-600"
      >
        {label}
        <span className="text-[0.6rem] leading-none" aria-hidden="true">▾</span>
      </button>

      {open && (
        <div className="absolute z-10 mt-1 min-w-52 max-h-72 overflow-auto rounded-md border border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-900 p-1 shadow-lg">
          {children(() => setOpen(false))}
        </div>
      )}
    </div>
  )
}
