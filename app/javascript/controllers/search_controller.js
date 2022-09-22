import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [ "query", "results" ]
  static values = { url: String }

  connect() {
    console.log("search is totally connected")
  }
  fetchResults(e){
    const url = new URL(this.urlValue)
    console.log(e.target.value)
    //console.log(this.queryTarget + "!!!!!!!!!!!")
    url.searchParams.append('query', e.target.value)
    console.log("Fetching Results")
    console.log(url)
    //response includes heading
    this.abortController = new AbortController()
    fetch(url, {signal: this.abortController.signal })
      .then(response => response.text())
      .then(html => {
        this.resultsTarget.innerHTML = html
      })
      .catch(() => {})
  }
  reset() {
    console.log("Resetting")
  }
}