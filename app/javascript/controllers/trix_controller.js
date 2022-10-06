import { Controller } from "@hotwired/stimulus"

var publicInput = ""
export default class extends Controller {
  static targets = ["rtInput"]
  static values = { id: Number}
  connect() {
    console.log("Trix Controller")
    publicInput = this.rtInputTarget
  }
}
window.addEventListener("trix-file-accept", function(event) {
  const acceptedTypes = ['*/pdf', 'image/jpeg', 'image/png', 'image/svg', 'image/gif', 'image/HEIF']
  const maxFileSize = 1200 * 1200
  if(publicInput.getElementsByTagName('img').length > 0) {
    event.preventDefault()
    alert("Posts may only contain 1 attachment")
    return
  }
  if (!acceptedTypes.includes(event.file.type)) {
    event.preventDefault()
    alert("Only support attachment of image files")
    return
  }
  if(event.file.size > maxFileSize) {
    event.preventDefault()
    alert("Image attachment is too large")
    return
  }
})