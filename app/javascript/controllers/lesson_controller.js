import Sortable from '@stimulus-components/sortable';

// Connects to data-controller="lesson"
export default class extends Sortable {
  static values = { course: String }

  onUpdate(event) {
    super.onUpdate(event)
    const newIndex = event.newIndex
    const id = event.item.id
    const courseSlug = this.courseValue
    console.log("csrf token: ", document.querySelector('[name="csrf-token"]').content)
    fetch(`/super-admin/courses/${courseSlug}/lessons/${id}/move`, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content
      },
      body: JSON.stringify({ position: newIndex, id: id })
    })
  }
}
