import Elm from "./src/Flick.elm";
import { start } from "../elm-native-js"
import { AnimatedCircle } from "@nativescript/animated-circle";
import { kebabCased, view } from "../elm-native-js/src/Native/Constants.bs"
import { buildHandler, addViewRender } from "../elm-native-js/src/Native/Elements.bs"

// import { knownFolders, path, ImageSource } from '@nativescript/core'
// import * as imagePicker from '@nativescript/imagepicker'

// function getImageTempFolder() {
//   return knownFolders.temp().getFolder("nsimagepicker")
// }

// function clearImageTempFolder() {
//   getImageTempFolder().clear()
// }

const animatedCircleAttributes =
  ["backgroundColor",
  "width",
  "height",
  "animated",
  "animateFrom",
  "rimColor",
  "barColor",
  "fillColor",
  "clockwise",
  "rimWidth",
  "progress",
  "text",
  "textSize",
  "textColor"].map(kebabCased)


start(
  {
    elmModule: Elm,
    elmModuleName: "Flick",
    customElements: [
      {
        tagName: 'ns-animated-circle',
        handler: buildHandler(
          () => new AnimatedCircle(),
          view.concat(animatedCircleAttributes),
          addViewRender
        )
      }
    ]
    /* initPorts: elmPorts => {
      elmPorts.pickImage.subscribe(_ => {
        // Clear the temp foler
        clearImageTempFolder()

        const context = imagePicker.create({
          mode: 'single',
        })

        context
          .authorize()
          .then(() => context.present())
          .then((selection) =>
            selection.forEach((selectedAsset) => {
              selectedAsset.options.height = 768
              ImageSource.fromAsset(selectedAsset)
                .then((imageSource) => {
                  const tempImagePath =
                    path.join(
                      getImageTempFolder().path, `${Date.now()}.jpg`
                    )
                  imageSource.saveToFile(tempImagePath, 'jpeg')
                  elmPorts.pickImageUrl.send(tempImagePath)
                  console.log("tempImagePath", tempImagePath)
                }
                )
            })
          )
          .catch((errorMessage) => console.log(errorMessage))

      })
    } */
  }
)
/*
Do not place any code after the application has been started as it will not
be executed on iOS.
*/
