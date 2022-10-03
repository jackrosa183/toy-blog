window.addEventListener("trix-file-accept", function(event) {
  const acceptedTypes = ['image/jpeg', 'image/png', 'image/svg', 'image/gif']
  const maxFileSize = 1200 * 1200
  
  if (!acceptedTypes.includes(event.file.type)) {
    event.preventDefault()
    alert("Only support attachment of image files")
  }
  if(event.file.size > maxFileSize) {
    event.preventDefault()
    alert("Image attachment is too large")
  }
})