import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ 'vanityid' ];

  connect() {
    console.log('Hello!');
    console.log(this.vanityidTarget);
  }

  refresh = () => {
    fetch('/meals/new', { headers: { accept: "application/json" } })
      .then(response => response.json())
      .then((data) => {
        debugger;
        this.vanityidTarget.innerText = data.meal.vanity_id;
      });
  }
}
