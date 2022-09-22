import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [ "tag_titles", "results" ]
  static values = { url: String }

  connect() {
    console.log("search is totally connected")
  }
  fetchResults(){
    console.log("Fetching Results")
  }
  reset() {
    console.log("Resetting")
  }
}