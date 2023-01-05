module TextView = {
  let tagName = "ns-text-view"
  let make = class => class
}

let all: array<Types.customElement> = [
  {
    tagName: TextView.tagName,
    make: TextView.make,
  },
]
