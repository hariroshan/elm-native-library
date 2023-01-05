let start = _ => {
  let mockWindow = MockWindow.newWindow()
  mockWindow->MockWindow.patchInsertBefore
  let document = mockWindow->MockWindow.document
  Js.log(document)
}
