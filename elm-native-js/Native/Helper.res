let always = (x, _) => x

let rec assignDeep: (Obj.t, array<string>, int, 'a) => unit = (object, keys, i, value) => {
  let optionKey = keys->Belt.Array.get(i)
  optionKey
  ->Belt.Option.flatMap(key => Js.Dict.get(Obj.magic(object), key)->Belt.Option.map(x => (key, x)))
  ->Belt.Option.forEach(((key, v)) => {
    if keys->Array.length - 1 == i {
      Js.Dict.set(Obj.magic(object), key, value)
    } else {
      assignDeep(v, keys, i + 1, value)
    }
  })
}

let getExpression = value =>
  value->String.sub(2, value->String.length - 4)->Js.String2.replace("&#x27;", "'")

let setAttribute: (Obj.t, string, string) => unit = (object, key, value) => {
  switch key {
  | "key"
  | "itemTemplateSelector" => ()
  | _ if value->Js.String2.startsWith("{{") =>
    let expression = getExpression(value)
    object->Types.bindExpression({expression, targetProperty: key})
  | k if !(k->Js.String2.includes(".")) => Js.Dict.set(Obj.magic(object), key, value)
  | _ =>
    let keys = key->Js.String2.split(".")
    assignDeep(Obj.magic(object), keys, 0, value)
  }
}

let update = setAttribute

external typeOf: 'a => string = "typeof"

let addView: (. Types.htmlElement, Types.htmlElement) => unit = %raw(`
    function(parentElement, thisElement) {
        if (parentElement.data == null) return
        // requestAnimationFrame(() => {
            const children = Array.from(parentElement.children)
            const hasActionBar = children.some(x => x.tagName.toLowerCase() === "ns-action-bar")
            const index = children.indexOf(thisElement)
            const currentIdx = hasActionBar ? index - 1 : index

            if(parentElement.data.insertChild)
              return parentElement.data.insertChild(thisElement.data, currentIdx)

            if (parentElement.data.constructor.name == "TabViewItem")
              return (parentElement.data.view = thisElement.data)

            if (parentElement.data.constructor.name == "ActionBar")
              return (parentElement.data.titleView = thisElement.data)

            if (parentElement.data.constructor.name == "ListView") {
              if(children.length == 1) {
                parentElement.data.itemTemplate =
                  function() {
                    const div = document.createElement("div")
                    const cloned = thisElement.cloneAll()
                    div.appendChild(cloned)
                    cloned.manualRender()
                    return cloned.data;
                  }
                return
              }

              if(parentElement.data.itemTemplates != null) return

              const keyedTemplates =
                  children.map(
                    child =>
                        ({
                          key: child.getAttribute("key"),
                          createView:
                            function () {
                              const div = document.createElement("div")
                              const cloned = child.cloneAll()
                              div.appendChild(cloned)
                              cloned.manualRender()
                              return cloned.data;
                            }
                        })
                  )

              const expression =
                getExpression(parentElement.getAttribute("item-template-selector"))

              parentElement.data.itemTemplateSelector = ($value, $index, _) => {
                return eval(expression)
              }
              parentElement.data.itemTemplates = keyedTemplates
              return
            }

            return (parentElement.data.content = thisElement.data)
        // })
    }
    `)

let addFormattedText: (. Types.htmlElement, Types.htmlElement) => unit = %raw(`
    function(parentElement, thisElement) {
        if (parentElement.data == null) return
        // requestAnimationFrame(() => {
            const children = Array.from(parentElement.children)
            const index = children.indexOf(thisElement)
            parentElement.data.formattedText = thisElement.data
        // })
    }
    `)

let addSpan: (. Types.htmlElement, Types.htmlElement) => unit = %raw(`
    function(parentElement, thisElement) {
        if (parentElement.data == null) return
        // requestAnimationFrame(() => {
            const children = Array.from(parentElement.children)
            const index = children.indexOf(thisElement)
            parentElement.data.spans.push(thisElement.data)
        // })
    }
    `)

let addActionBar: (. Types.htmlElement, Types.htmlElement) => unit = %raw(`
    function(parentElement, thisElement) {
        if (parentElement.data == null) return
        // requestAnimationFrame(() => {
          parentElement.data.actionBar = thisElement.data
        // })
    }
    `)

let addActionItem: (. Types.htmlElement, Types.htmlElement) => unit = %raw(`
    function(parentElement, thisElement) {
        if (parentElement.data == null) return
        // requestAnimationFrame(() => {
          parentElement.data.actionItems.addItem(thisElement.data)
        // })
    }
    `)

let addNavigationButton: (. Types.htmlElement, Types.htmlElement) => unit = %raw(`
    function(parentElement, thisElement) {
        if (parentElement.data == null) return
        // requestAnimationFrame(() => {
            parentElement.data.navigationButton = thisElement.data
        // })
    }
    `)

let addItems: (. Types.htmlElement, Types.htmlElement) => unit = %raw(`
    function(parentElement, thisElement) {
        if (parentElement.data == null) return
        // requestAnimationFrame(() => {
            if (parentElement.data.items == null)
              return (parentElement.data.items = [thisElement.data])
            parentElement.data.items.push(thisElement.data)
        // })
    }
    `)

let optionMap2 = (a, b, fx) => {
  switch (a, b) {
  | (Some(x), Some(y)) => Some(fx(x, y))
  | _ => None
  }
}

let dbg = x => {
  Js.log(x)
  x
}
let dbg2 = (x, lbl) => {
  Js.log2(lbl, x)
  x
}

let tap = (fx, x) => {
  fx(x)->ignore
  x
}
let flip: (('a, 'b) => 'c, 'b, 'a) => 'c = (fx, x, y) => fx(y, x)
