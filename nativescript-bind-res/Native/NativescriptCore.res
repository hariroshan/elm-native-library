type rootLayout

module Application = {
  type config = {create: unit => rootLayout}

  @module("@nativescript/core") @scope("Application")
  external run: config => unit = "run"
}
