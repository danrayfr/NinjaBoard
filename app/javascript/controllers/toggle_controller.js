import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  static targets = ['arrow', 'hiddenView']
  connect() {
    const sidebar = document.querySelector('#sidebar');
  }

  open() {
    sidebar.classList.toggle('-translate-x-full')
  }

  openProfile() {
    if (this.hiddenViewTarget.classList.contains('hidden')) {
      this.hiddenViewTarget.classList.replace('hidden', 'block');
      this.arrowTarget.classList.replace('rotate-0', 'rotate-180')
    } else {
      this.hiddenViewTarget.classList.replace('block', 'hidden');
      this.arrowTarget.classList.replace('rotate-180', 'rotate-0')
    }
  }
}
