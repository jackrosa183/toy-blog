import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [ "query", "results" ]
  static values = { url: String }
  connect() {
    console.log("search is totally connected")
  }
}