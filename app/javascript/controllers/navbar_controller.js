import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  toggle() {
    const el = document.getElementById("mobile-links");
    const barEl = document.getElementById("bars");
    const closeEl = document.getElementById("close");
    
    el.classList.toggle("hidden");
    barEl.classList.toggle("hidden");
    closeEl.classList.toggle("hidden");
  }
}
