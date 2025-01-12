import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.open();
  }

  open() {
    this.element.showModal();
  }

  close() {
    this.element.close();
    this.element.innerHTML = "";
  }

  submitEnd(event) {
    if (event.detail.success) {
      this.close();
    }
  }
}
