import Elm from "./Main.elm";
import { start } from "../elm-native-js/App.bs"
import { Application } from "@nativescript/core";

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
