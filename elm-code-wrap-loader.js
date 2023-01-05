function wrapElmCode(code) {
  return `
    function wrapper() {
      let output = {};
      (function () { ${code} }).call(output);
      return output.Elm;
    }
    export default wrapper;
  `;
}

module.exports = wrapElmCode;
