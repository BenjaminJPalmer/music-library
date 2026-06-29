'use client'

import { Dropdown } from '@/components/Dropdown'
import { toTitleCase } from '@/lib/format'

interface Props {
  options: string[]
  selected: string[]
  onChange: (next: string[]) => void
  /** Accessible label for the trigger, e.g. "Filter by instrument". */
  ariaLabel: string
  /** Plural noun used to build the trigger/empty labels, e.g. "instruments". */
  noun: string
  /** How to display each option (defaults to Title Case). */
  formatOption?: (value: string) => string
}

// A generic multi-select dropdown: same shell as SelectFilter, but the panel
// stays open while toggling options on and off.
export function MultiSelect({
  options,
  selected,
  onChange,
  ariaLabel,
  noun,
  formatOption = toTitleCase,
}: Props) {
  function toggle(name: string) {
    onChange(
      selected.includes(name)
        ? selected.filter((n) => n !== name)
        : [...selected, name]
    )
  }

  const label =
    selected.length === 0
      ? `All ${noun}`
      : selected.length === 1
        ? formatOption(selected[0])
        : `${selected.length} ${noun}`

  return (
    <Dropdown ariaLabel={ariaLabel} label={label}>
      {() => (
        <>
          {options.length === 0 && (
            <p className="px-2 py-1 text-sm text-gray-400">No {noun}</p>
          )}
          {options.map((name) => (
            <label
              key={name}
              className="flex items-center gap-2 px-2 py-1 text-sm rounded hover:bg-gray-50 dark:hover:bg-gray-800 cursor-pointer"
            >
              <input
                type="checkbox"
                checked={selected.includes(name)}
                onChange={() => toggle(name)}
                className="cursor-pointer"
              />
              <span className="text-gray-700 dark:text-gray-300">{formatOption(name)}</span>
            </label>
          ))}
          {selected.length > 0 && (
            <button
              type="button"
              onClick={() => onChange([])}
              className="mt-1 w-full text-left px-2 py-1 text-sm text-gray-500 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-200 border-t border-gray-100 dark:border-gray-800"
            >
              Clear selection
            </button>
          )}
        </>
      )}
    </Dropdown>
  )
}
