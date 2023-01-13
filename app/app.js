import Elm from "./src/Main.elm";
import { start } from "elm-native-js"

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
