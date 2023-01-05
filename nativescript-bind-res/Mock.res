@module("./mock/window") @new
external newWindow: unit => Dom.window = "Window"

@module("./mock/window") @val
external patchInsertBefore: Dom.window => unit = "patchInsertBefore"

@get
external document: Dom.window => Dom.document = "document"

@get
external hTMLElement: Dom.window => Obj.t = "HTMLElement"

type customElement = {define: (string, Obj.t) => unit}

@val
external customElements: Dom.window => customElement = "customElements"

@send
external writeString: (Dom.document, string) => unit = "write"

@module("vm-shim")
external runInContext: (string, 'object) => unit = "runInContext"
