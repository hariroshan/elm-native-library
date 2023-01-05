@module("./dom-mock/window") @new
external newWindow: unit => Dom.window = "Window"

@get
external document: Dom.window => Dom.document = "document"

@module("./dom-mock/window") @val
external patchInsertBefore: Dom.window => unit = "patchInsertBefore"
