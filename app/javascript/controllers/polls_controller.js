import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ['poll', 'count', 'mealId', 'cuisineId', 'userId', 'btn', 'viewResult'];

  connect() {
    console.log("Running stimulus")
  }

  thumbsUp(event) {
    this.draftMessage(event, 1);
  }

  thumbsDown() {
    this.draftMessage(event, 0);
  }

  dragstart(event) {
    event.currentTarget.dataset.xstart = event.screenX;
  }

  dropping(event) {
    const xStart =  Number.parseInt(event.currentTarget.dataset.xstart);
    const xEnd =  Number.parseInt(event.screenX);
    if (xStart !== xEnd) {
      const score = (xStart > xEnd) ? 0 : 1
      this.draftMessage(event, score);
    }
  }

  draftMessage = (event, scoring) => {
    const mealId = this.mealIdTarget.value;
    const userId = this.userIdTarget.value;
    let eventCount = Number.parseInt(this.countTarget.value);
    const cuisineId = this.cuisineIdTargets[eventCount].value;
    console.log(eventCount);

    this.pollTargets[eventCount].style.display = 'none';
    console.log(this.pollTargets[eventCount]);

    eventCount += 1;
    this.countTarget.value = eventCount;

    if (this.pollTargets[eventCount]) {
      this.pollTargets[eventCount].style.display = 'block';
    } else {
      this.btnTargets.forEach((btn) => {
        btn.style.display = 'none';
      })
      this.viewResultTarget.style.display = 'block';
    }

    const csrfTokenElement = document.head.querySelector(`meta[name="csrf-token"]`);

    fetch(`/meals/${mealId}/polls`, {
      method: "POST",
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "X-CSRF-Token": csrfTokenElement.getAttribute("content")
      },
      body: JSON.stringify({
        meal: mealId,
        user: userId,
        cuisine: cuisineId,
        score: scoring
      })
    });
  }
}

