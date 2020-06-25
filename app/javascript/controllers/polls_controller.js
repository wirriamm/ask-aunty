import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ['poll', 'count', 'mealId', 'cuisineId', 'userId'];

  connect() {
    console.log("Running stimulus")
  }

  thumbsUp(event) {
    const mealId = this.mealIdTarget.value;
    const cuisineId = this.cuisineIdTarget.value;
    const userId = this.userIdTarget.value;
    let count = Number.parseInt(this.countTarget.value);
    console.log(count);
    this.pollTargets[count].style.display = 'none';
    console.log(this.pollTargets[count]);
    this.countTarget.value = Number.parseInt(count) + 1;
    count += 1;
    this.pollTargets[count].style.display = 'block';
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
        score: false
      })
    }).then(response => console.log(response));
  }

  thumbsDown() {
    console.log("Down");
  }

  getMetaValue(name) {

    return element.getAttribute("content");
  }
}
