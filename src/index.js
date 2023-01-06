import Elm from "./Main.elm";
import { start } from "../nativescript-bind-res/App.bs"

start(
  {
    elmModule: Elm,
    elmModuleName: "Main",
    initPorts: _elmPorts => { }
  }
)
/*
Do not place any code after the application has been started as it will not
be executed on iOS.
*/
