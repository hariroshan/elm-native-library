import Elm from "./src/Details.elm";
import { start } from "../elm-native-js"
import { knownFolders, path, ImageSource } from '@nativescript/core'
import * as imagePicker from '@nativescript/imagepicker'

function getImageTempFolder() {
  return knownFolders.temp().getFolder("nsimagepicker")
}

function clearImageTempFolder() {
  getImageTempFolder().clear()
}


start(
  {
    elmModule: Elm,
    elmModuleName: "Details",
    initPorts: elmPorts => {
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
    }
  }
)
/*
Do not place any code after the application has been started as it will not
be executed on iOS.
*/
