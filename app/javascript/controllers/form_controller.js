// import debounce from "https://cdn.skypack.dev/lodash.debounce"
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static get targets() { return [ "submit" ] }

  initialize() {
    // this.submit = debounce(this.submit.bind(this), 200)
    console.log("ayo")
  }

  connect() {
    console.log("connecting !!!!")
    this.submitTarget.hidden = true
  }

  submit() {
    console.log("!!!!! submit!!!")
    this.submitTarget.click()
  }

  hideValidationMessage(event) {
    event.stopPropagation()
    event.preventDefault()
  }
}