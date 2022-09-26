import { Controller } from "@hotwired/stimulus";
import { List } from "immutable";

export default class extends Controller {
  static targets = [ "query", "results", "tags"]
  static values = { url: String }

  connect() {
    console.log("search is totally connected")
  }

  fetchResults(e){
    if(e.keyCode == 32 ){
      var li = document.createElement("a")
      li.innerHTML = this.queryTarget.value
      li.className = "btn-secondary-smaller"
      this.tagsTarget.append(li)
      this.reset()
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
    
    var li = document.createElement("a")
    li.innerHTML = e.target.dataset.title + " "
    li.className = "btn-secondary-smaller"
    console.log("clicked on " + e.target.dataset.title)

    
    if(this.tagsTarget.innerHTML.includes(li.innerHTML)){
      console.log("already there")
      console.log(this.tagsTarget.innerHTML)
      this.reset()
      return
    }
    else{
      
      console.log("not here yet")
      this.tagsTarget.append(li)
      this.reset() 
      return 
    }
    
    // e.target.dataset.title + " "
    
  }
  reset(){
    this.queryTarget.value = ""
    this.resultsTarget.innerHTML = "" 
  }
}