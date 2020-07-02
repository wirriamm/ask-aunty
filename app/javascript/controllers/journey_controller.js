import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ 'mealId', 'joinmeal',
  'postalCode', 'createmeal' ];

  connect() {
    console.log("Stimulus connected :)");
  }

  joinmeal = (event) => {
    // debugger;
    this.mealIdTargets.forEach(e => e.classList.remove('hide'));
    this.joinmealTarget.classList.add("hide");
    this.joinmealTarget.classList.remove("secondarybtn");

    this.postalCodeTargets.forEach(e => e.classList.add('hide'));
    this.createmealTarget.classList.remove("hide");
    this.createmealTarget.classList.add("secondarybtn");
  }

  createmeal = (event) => {
    this.postalCodeTargets.forEach(e => e.classList.remove('hide'));
    this.createmealTarget.classList.add("hide");
    this.createmealTarget.classList.remove("secondarybtn");

    this.mealIdTargets.forEach(e => e.classList.add('hide'));
    this.joinmealTarget.classList.remove("hide");
    this.joinmealTarget.classList.add("secondarybtn");
  }
}
