import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ 'startPoll', 'viewResult', 'pollCount', 'time', 'edit', 'source', 'editBtn' ];

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
          startBtn.innerText = "Resume Poll";
      }
    } else {
        startBtn.style.display = 'none';
        console.log(this.editBtnTarget);
        this.editBtnTarget.classList.add('btn-disabled');
    }
  }

  update = (e) => {
    this.editTarget.classList.toggle('hide');
    const lastEl = document.getElementById('bottom');
    lastEl.scrollIntoView();
  }

  copy = (e) => {
    e.preventDefault();
    const vanity_id = this.sourceTarget.value;
    this.sourceTarget.value = "ask-aunty.herokuapp.com/join_meal/" + vanity_id;
    console.log(this.sourceTarget.value);
    this.sourceTarget.select();
    document.execCommand("copy");
    this.sourceTarget.value = vanity_id;
  }
}
