import { Controller } from "@hotwired/stimulus"
import { put } from "@rails/request.js";
import Sortable from 'sortablejs';

// Connects to data-controller="sortable"
export default class extends Controller {
  static values = {
    group: String
  }

  connect() {
    this.sortable = Sortable.create(this.element, {
      onEnd: this.onEnd.bind(this),
      group: this.groupValue
    });
  }

  onEnd(event) {
    var sortableUpdateUrl = event.item.dataset.sortableUpdateUrl;
    var newIndex = event.newIndex;
    var sortableProgressId = event.to.dataset.sortableProgressId;

    // Retrieve the progress status from the dataset attribute of the item
    var progressStatus = event.item.dataset.sortableProgressStatus;

    // Check if the progress status is 'completed'
    if (progressStatus === 'completed') {
      console.log('Item is completed. Dragging disabled.');
      event.item.classList.add('no-touch'); // Add the CSS class to disable pointer events
      return; // Exit the function, preventing further execution
    } else {
      event.item.classList.remove('no-touch'); // Remove the CSS class to enable pointer events
    }


    put(sortableUpdateUrl, {
      body: JSON.stringify({row_order_position: newIndex, progress_id: sortableProgressId}),
    })
  }
}
