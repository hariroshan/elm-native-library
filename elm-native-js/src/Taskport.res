type namespace

%%private(
  let namespace = "hariroshan/elm-native"
  let version = "v1"

  @module("elm-taskport")
  external install: (. unit) => unit = "install"

  @module("elm-taskport")
  external createNamespace: (. string, string) => namespace = "createNamespace"

  @send
  external register: (namespace, string, 'a => 'b) => unit = "register"
)

install(.)

let register = () => {
  open NativescriptCore
  let ns = createNamespace(. namespace, version)
  ns->register("DialogsAlert", (options: Dialogs.alertOptions) => {
    Dialogs.alert(. options)
  })

  ns->register("DialogsAction", (options: Dialogs.actionOptions) => {
    Dialogs.action(. options)
  })

  ns->register("DialogsConfirm", (options: Dialogs.confirmOptions) => {
    Dialogs.confirm(. options)
  })

  ns->register("DialogsLogin", (options: Dialogs.loginOptions) => {
    Dialogs.login(. options)
  })

  ns->register("DialogsPrompt", (options: Dialogs.promptOptions) => {
    Dialogs.prompt(. options)
  })
}
