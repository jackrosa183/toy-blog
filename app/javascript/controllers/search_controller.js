import { Controller } from "@hotwired/stimulus";
// import { Binding } from "@hotwired/stimulus/dist/types/core/binding";
// import { List } from "immutable";

export default class extends Controller {
  static targets = [ "query", "results", "tags", "addedTags"]
  static values = { url: String }

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
    
    const a = document.createElement("a")
    a.innerHTML = e.target.dataset.title
    a.classList.add("btn-hover-delete")
    a.dataset.searchTarget = "addedTags"
    a.dataset.action = "click->search#removeTag"

    console.log("clicked on " + e.target.dataset.title)

    this.checkExistence(a)

  }
  
  hasTag(element, tag) {
    for (const child of element.children) {
      if(child.textContent.toLowerCase() == tag.textContent.toLowerCase()){
        return true
      }
    }
  }

  checkExistence(element){
    if(this.hasTag(this.tagsTarget, element)){
      this.reset()
      return
    }
    if(document.getElementsByClassName("tag px-0.5").length >= 5){  
      this.reset()
      alert("Posts may only have 5 tags!")
      return 
    } 
    else {
      const span = document.createElement("span")
      this.tagsTarget.append(span)
      span.append(element)
      span.className = "tag px-0.5"
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
    e.target.parentElement.remove()
    e.target.remove()

    const inputToRemove = document.getElementById("hidden" + e.target.innerHTML)
    inputToRemove.remove()

  }
  reset(){
    this.queryTarget.value = ""
    this.resultsTarget.innerHTML = "" 
  }
}