import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["fileField", "submit"]
  
  connect() {
    console.log("Avatar!!")
  }
  submit(){
    console.log("submitted")
    this.submitTarget.click()
  }
}