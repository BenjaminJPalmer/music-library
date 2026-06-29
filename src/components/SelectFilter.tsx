'use client'

import { Dropdown } from '@/components/Dropdown'

interface Option {
  value: string
  label: string
}

interface Props {
  options: Option[]
  value: string
  onChange: (value: string) => void
  ariaLabel: string
}

// A single-select dropdown: same shell as MultiSelect, but picking an option
// sets the value and closes the panel.
export function SelectFilter({ options, value, onChange, ariaLabel }: Props) {
  const current = options.find((o) => o.value === value) ?? options[0]

  return (
    <Dropdown ariaLabel={ariaLabel} label={current?.label}>
      {(close) => (
        <div role="listbox">
          {options.map((o) => {
            const selected = o.value === value
            return (
              <button
                key={o.value || '__all__'}
                type="button"
                role="option"
                aria-selected={selected}
                onClick={() => {
                  onChange(o.value)
                  close()
                }}
                className={`flex w-full items-center justify-between gap-2 px-2 py-1 text-sm rounded text-left hover:bg-gray-50 dark:hover:bg-gray-800 ${
                  selected
                    ? 'text-gray-900 dark:text-gray-100 font-medium'
                    : 'text-gray-700 dark:text-gray-300'
                }`}
              >
                <span>{o.label}</span>
                {selected && <span aria-hidden="true" className="text-xs">✓</span>}
              </button>
            )
          })}
        </div>
      )}
    </Dropdown>
  )
}
