import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ 'startPoll', 'viewResult', 'pollCount' ];

  connect() {
    console.log('Hello!');
    const startBtn = this.startPollTarget;
    const resultBtn = this.viewResultTarget;
    const pollCount = this.pollCountTarget.value;
    if (pollCount >= 10) {
      startBtn.style.display = 'none';
    } else {
      resultBtn.style.display = 'none';
      if (pollCount > 0)
        startBtn.innerText = "Continue the poll";
    }
  }
}
