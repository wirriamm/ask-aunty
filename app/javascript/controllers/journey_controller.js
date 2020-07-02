import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ 'mealIdInput', 'mealIdSubmit','joinmeal', 'joinmealForm',
  'postalCodeInput', 'postalCodeSubmit', 'createmeal' ];

  connect() {
    console.log("Stimulus connected :)");
  }

  joinmeal = (event) => {
    this.mealIdInputTarget.classList.remove("hide");
    this.mealIdSubmitTarget.classList.remove("hide");
    this.joinmealTarget.classList.add("hide");

    this.postalCodeSubmitTarget.classList.add("hide");
    this.postalCodeInputTarget.classList.add("hide");
    this.createmealTarget.classList.remove("hide");
  }

  createmeal = (event) => {
    this.postalCodeSubmitTarget.classList.remove("hide");
    this.postalCodeInputTarget.classList.remove("hide");
    this.createmealTarget.classList.add("hide");

    this.mealIdInputTarget.classList.add("hide");
    this.mealIdSubmitTarget.classList.add("hide");
    this.joinmealTarget.classList.remove("hide");
  }
}
