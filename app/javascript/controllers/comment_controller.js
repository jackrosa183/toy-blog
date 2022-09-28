import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]
  
  connect(){
    console.log("Comment controller is connected")
  }
  emptyInput() {
    console.log("emptying!")
    setTimeout(() => { this.inputTarget.value = ""}, 5)
  }
}