import { Controller } from "@hotwired/stimulus";
// import { Binding } from "@hotwired/stimulus/dist/types/core/binding";
// import { List } from "immutable";

export default class extends Controller {
  static targets = [ "query", "results", "tags", "addedTags"]
  static values = { url: String }

  connect() {
    console.log("search is totally connected")
  }

  fetchResults(e){
    if(e.keyCode == 32 ){
      var a = document.createElement("a")
      a.innerHTML = this.queryTarget.value.slice(0, -1)
      a.className = "btn-hover-delete"
      a.dataset.searchTarget = "addedTags"
      a.dataset.action = "click->search#removeTag"
      this.checkExistence(a)
  
    }
    const url = new URL(this.urlValue)

    if(e.target.value == ""){
      this.reset()
      return
    }
    url.searchParams.append('query', e.target.value)
    this.abortController = new AbortController()
    fetch(url, {signal: this.abortController.signal })
      .then(response => response.text())
      .then(html => {
        this.resultsTarget.innerHTML = html
      })
      .catch(() => {})
  }


  addTitle(e){
    
    var a = document.createElement("a")
    a.innerHTML = e.target.dataset.title
    a.className = "btn-hover-delete"
    a.dataset.searchTarget = "addedTags"
    a.dataset.action = "click->search#removeTag"

    console.log("clicked on " + e.target.dataset.title)

    this.checkExistence(a)

  }

  checkExistence(element){
    if(this.tagsTarget.innerHTML.toLowerCase().includes(element.innerHTML.toLowerCase())){
      this.reset()
      return
    }
    else{  
      console.log("not here yet")
      this.tagsTarget.append(element)
      const input = document.createElement("input")
      input.value = element.innerHTML
      input.name = "post[extracted_tags][]"
      input.type = "hidden"
      input.id = "hidden" + element.innerHTML
      this.tagsTarget.after(input)
      this.reset() 
      return 
    } 
  }
  removeTag(e){
    console.log("removed " + e.target.innerHTML)
    e.target.remove()

    const inputToRemove = document.getElementById("hidden" + e.target.innerHTML)
    inputToRemove.remove()

  }
  reset(){
    this.queryTarget.value = ""
    this.resultsTarget.innerHTML = "" 
  }
}