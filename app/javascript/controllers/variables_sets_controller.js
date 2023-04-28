// Reconnect ActionCable after switching accounts

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["item"]

  add(event) {
    event.preventDefault();

    const items = this.itemTargets;
    const last = items[items.length - 1]
    let newVariable = last.cloneNode(true)
    newVariable.querySelectorAll('input').forEach((i) => {i.value = '';})

    last.after(newVariable);
  }

  remove(event) {
    event.preventDefault();

    const items = this.itemTargets;

    if(items.length > 1) {
      items[items.length - 1].remove()
      items[0].querySelector('input').form.requestSubmit()
    }
  }
}
