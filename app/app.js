import Elm from "./src/Details.elm";
import { start } from "../elm-native-js"

start(
  {
    elmModule: Elm,
    elmModuleName: "Details",
    initPorts: _elmPorts => { }
  }
)
/*
Do not place any code after the application has been started as it will not
be executed on iOS.
*/
