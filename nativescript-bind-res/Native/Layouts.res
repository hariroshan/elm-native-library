module RootLayout = {
  let tagName = "ns-root-layout"
  let make = class => class
}
let all: array<Types.customElement> = [
  {
    tagName: RootLayout.tagName,
    make: RootLayout.make,
  },
]
