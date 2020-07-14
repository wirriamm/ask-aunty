import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ 'mealId', 'joinmeal', 'postalCode', 'createmeal' ];

  connect() {
    console.log("Stimulus connected :)");
  }

  joinmeal = (event) => {
    this.mealIdTargets.forEach(e => e.classList.remove('hide'));
    // this.joinmealTarget.classList.add("hide");
    this.joinmealTarget.classList.add("secondarybtn");
    this.joinmealTarget.classList.add("highlight-tab");

    this.postalCodeTargets.forEach(e => e.classList.add('hide'));
    // this.createmealTarget.classList.remove("hide");
    this.createmealTarget.classList.remove("secondarybtn");
    this.createmealTarget.classList.remove("highlight-tab");
    const lastEl = document.getElementById('bottom');
    lastEl.scrollIntoView();
  }

  createmeal = (event) => {
    this.postalCodeTargets.forEach(e => e.classList.remove('hide'));
    // this.createmealTarget.classList.add("hide");
    this.createmealTarget.classList.add("secondarybtn");
    this.createmealTarget.classList.add("highlight-tab");

    this.mealIdTargets.forEach(e => e.classList.add('hide'));
    // this.joinmealTarget.classList.remove("hide");
    this.joinmealTarget.classList.remove("secondarybtn");
    this.joinmealTarget.classList.remove("highlight-tab");
    const lastEl = document.getElementById('bottom');
    lastEl.scrollIntoView();
  }
}
