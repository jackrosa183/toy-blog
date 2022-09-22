import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [ "query", "results" ]
  static values = { url: String }

  connect() {
    console.log("search is totally connected")
  }
  fetchResults(e){
    if(e.keycode = 32 ){
      console.log("WTF SPACE")
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
  addTag(e){

  }
}