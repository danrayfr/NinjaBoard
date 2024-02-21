import { Controller } from "@hotwired/stimulus"
import Dropdown from 'stimulus-dropdown'

export default class extends Dropdown {
  static targets = ["menu", "avatar"];

  connect() {
    super.connect()
  }

  toggle(event) {
    super.toggle()
  }

  hide(event) {
    super.hide(event)
  }

  toggleAvatarDropdown() {
    if (this.avatarTarget.classList.contains('hidden')) {
      this.avatarTarget.classList.remove('hidden');
      this.avatarTarget.classList.add('block');
    } else {
      this.avatarTarget.classList.remove('block');
      this.avatarTarget.classList.add('hidden');
    }
  }
}