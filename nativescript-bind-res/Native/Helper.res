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

let setAttribute: (Obj.t, string, 'a) => unit = (object, key, value) => {
  if !(key->Js.String2.includes(".")) {
    Js.Dict.set(Obj.magic(object), key, value)
  } else {
    let keys = key->Js.String2.split(".")
    assignDeep(Obj.magic(object), keys, 0, value)
  }
}

let init = (object, props) => {
  Js.Dict.keys(Obj.magic(props))->Belt.Array.forEach(key =>
    setAttribute(object, key, Js.Dict.unsafeGet(props, key))
  )
}

let update = setAttribute

external typeOf: 'a => string = "typeof"

let getPropsForObject: Obj.t => array<string> = %raw(`
  function(object){
    let arr = []
    for (var prop in object) {
      if (prop.startsWith("_")) continue
      if (typeof object[prop] === "function") continue
      arr.push(prop)
    }
    return arr
  }
  `)

let addView: (. 'a, 'b) => unit = %raw(`
    function(parentElement, thisElement) {
        requestAnimationFrame(() => {
            const children = Array.from(parentElement.children)
            const hasActionBar = children.some(x =>
            x.tagName.toLowerCase() === "ns-action-bar"
            )
            const index = (Array.from(parentElement.children).indexOf(thisElement))
            parentElement.data.insertChild(thisElement.data, hasActionBar ? index - 1 : index);
        })
    }
    `)

let dbg = x => {
  Js.log(x)
  x
}
let dbg2 = (x, lbl) => {
  Js.log2(lbl, x)
  x
}

let flip: (('a, 'b) => 'c, 'b, 'a) => 'c = (fx, x, y) => fx(y, x)

/*

 */
