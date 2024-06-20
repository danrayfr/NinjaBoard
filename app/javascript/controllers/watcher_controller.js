import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="watcher"
export default class extends Controller {
  static values = { lessonId: Number, courseId: Number, requiredWatchDuration: Number }
  static targets = ["video"]

  connect() {
    // Check if there's stored watched time in localStorage
    const storedWatchedTime = localStorage.getItem(`lesson_${this.lessonIdValue}_watched_time`);
    if (storedWatchedTime) {
      this.videoTarget.currentTime = parseFloat(storedWatchedTime);
    }

    this.videoTarget.addEventListener('timeupdate', this.trackWatchTime.bind(this));
    this.videoTarget.addEventListener('ended', this.videoEnded.bind(this));
  }

  trackWatchTime() {
    const watchedTime = this.videoTarget.currentTime;
    const totalDuration = this.videoTarget.duration;

    if (totalDuration && (totalDuration - watchedTime) <= this.requiredWatchDurationValue) {
      this.updateWatchDuration(watchedTime);
    }

    // Store watched time in localStorage
    localStorage.setItem(`lesson_${this.lessonIdValue}_watched_time`, watchedTime.toString());
  }

  videoEnded() {
    // Clear watched time from localStorage when the video ends
    localStorage.removeItem(`lesson_${this.lessonIdValue}_watched_time`);
  }

  updateWatchDuration(watchedTime) {
    fetch(`/courses/${this.courseIdValue}/lessons/${this.lessonIdValue}/update_watch_duration`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content
      },
      body: JSON.stringify({ watch_duration: watchedTime })
    })
    .then(response => {
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      return response.json();
    })
    .then(data => {
      if (data.completed) {
        window.location.href = data.redirect_url;
      }
    })
    .catch(error => {
      console.error('Error:', error);
    });
  }
}
