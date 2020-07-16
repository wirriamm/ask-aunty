import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ 'source' ];

  connect() {
    console.log('Connected to results controller 📊');
  };

  copy = (e) => {
    e.preventDefault();
    const vanity_id = this.sourceTarget.value;
    this.sourceTarget.value = "ask-aunty.herokuapp.com/meals/" + vanity_id + "/result";
    console.log(this.sourceTarget.value);
    this.sourceTarget.select();
    document.execCommand("copy");
    this.sourceTarget.value = vanity_id;
  };
};
