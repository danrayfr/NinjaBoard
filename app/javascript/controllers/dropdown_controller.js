import { Controller } from "@hotwired/stimulus"
import Dropdown from 'stimulus-dropdown'

export default class extends Dropdown {
  static targets = ["menu", "avatarMenu", "chevron"];

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
    if (this.avatarMenuTarget.style.display === 'none') {
      this.avatarMenuTarget.style.display = 'block';
      this.chevronTarget.classList.remove('rotate-0');
      this.chevronTarget.classList.add('rotate-180');
    } else {
      this.avatarMenuTarget.style.display = 'none';
      this.chevronTarget.classList.remove('rotate-180');
      this.chevronTarget.classList.add('rotate-0');
    }
  }
}