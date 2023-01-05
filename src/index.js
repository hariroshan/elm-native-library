import Elm from "./Main.elm";
import App from "../nativescript-bind-res/App.bs"

App.start(
  {
    elmModule: Elm,
    elmModuleName: "Main",
    flags: null,
    initPorts: elmPorts => { }
  }
)
/*
Do not place any code after the application has been started as it will not
be executed on iOS.
*/
