import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ 'mealIdInput', 'mealIdLabel', 'mealIdSubmit','joinmeal',
  'postalCodeInput', 'postalCodeLabel', 'postalCodeSubmit', 'createmeal' ];

  connect() {
    console.log("Stimulus connected :)");
  }

  joinmeal = (event) => {
    debugger;
    this.mealIdLabelTarget.classList.remove("hide");
    this.mealIdInputTarget.classList.remove("hide");
    this.mealIdSubmitTarget.classList.remove("hide");
    this.joinmealTarget.classList.add("hide");
    this.joinmealTarget.classList.remove("secondarybtn");

    this.postalCodeLabelTarget.classList.add("hide");
    this.postalCodeInputTarget.classList.add("hide");
    this.postalCodeSubmitTarget.classList.add("hide");
    this.createmealTarget.classList.remove("hide");
    this.createmealTarget.classList.add("secondarybtn");
  }

  createmeal = (event) => {
    this.postalCodeLabelTarget.classList.remove("hide");
    this.postalCodeInputTarget.classList.remove("hide");
    this.postalCodeSubmitTarget.classList.remove("hide");
    this.createmealTarget.classList.add("hide");
    this.createmealTarget.classList.remove("secondarybtn");

    this.mealIdLabelTarget.classList.add("hide");
    this.mealIdInputTarget.classList.add("hide");
    this.mealIdSubmitTarget.classList.add("hide");
    this.joinmealTarget.classList.remove("hide");
    this.joinmealTarget.classList.add("secondarybtn");
  }
}
