import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [ "query", "results", "title" ]
  static values = { url: String }

  connect() {
    console.log("search is totally connected")
  }
  updateInput() {
    console.log("update")
  }
  
  fetchResults(e){
    if(e.keyCode == 32 ){
      console.log("space")
    }
    const url = new URL(this.urlValue)

    if(e.target.value == ""){
      this.resultsTarget.innerHTML = ""
      e.target.value = ""
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
    // debugger
    console.log("clicked on " + e.target.dataset.title)
    // this.updateInput()
    this.queryTarget.value = e.target.dataset.title + " "

  }
}