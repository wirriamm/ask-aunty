import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ 'startPoll', 'viewResult', 'pollCount', 'time', 'edit', 'source' ];

  connect() {
    console.log('Connected to show-button controller 🚀');
    const startBtn = this.startPollTarget;
    const resultBtn = this.viewResultTarget;
    const pollCount = this.pollCountTarget.value;
    const time = this.timeTarget.value === 'true';

    if (time) {
      if (pollCount >= 10) {
        startBtn.style.display = 'none';
      } else {
        resultBtn.style.display = 'none';
        if (pollCount > 0)
          startBtn.innerText = "Continue the poll";
      }
    } else {
        startBtn.style.display = 'none';
    }
  }

  update = (e) => {
    this.editTarget.classList.toggle('hide');
  }

  copy = (e) => {
    e.preventDefault();
    console.log(this.sourceTarget.value);
    this.sourceTarget.select();
    document.execCommand("copy");
  }
}
