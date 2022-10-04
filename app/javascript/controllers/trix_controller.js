import { Controller } from "@hotwired/stimulus"

var canAttach = true
var publicInput = ""
export default class extends Controller {
  static targets = ["rtInput"]
  static values = { id: Number}
  connect() {
    console.log("Trix Controller")
    var input = document.getElementById("post_rich_content_trix_input_post_" + this.idValue.toString())
    publicInput = this.rtInputTarget
    if(this.rtInputTarget.getElementsByTagName('img').length > 0){
      // console.log("lots of images")
    }
  }
  
}
window.addEventListener("trix-file-accept", function(event) {
  const acceptedTypes = ['*/pdf', 'image/jpeg', 'image/png', 'image/svg', 'image/gif', 'image/HEIF']
  const maxFileSize = 1200 * 1200
  if(publicInput.getElementsByTagName('img').length > 0) {
    event.preventDefault()
    alert("Posts may only contain 1 attachment")
  }
  
  if (!acceptedTypes.includes(event.file.type)) {
    event.preventDefault()
    alert("Only support attachment of image files")
  }
  if(event.file.size > maxFileSize) {
    event.preventDefault()
    alert("Image attachment is too large")
  }
  
})