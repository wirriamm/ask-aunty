import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ 'mealId', 'joinmeal', 'postalCode', 'createmeal' ];

  connect() {
    console.log("Stimulus connected :)");
  }

}
