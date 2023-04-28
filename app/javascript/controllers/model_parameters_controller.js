// Reconnect ActionCable after switching accounts

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["item", "llmParams"]

  connect() {
    const dropDown = document.querySelector('sl-menu');
    dropDown.addEventListener('sl-select', event => {
      const item = event.detail.item
    });
  }

  load(event) {
    event.preventDefault();
    let template = '';
    event.target.dataset.parameters.split(',').forEach((parameter) => {
      const [variable, defaultValue] = parameter.split(':')
      template += `<div class="var-item">
                      <div class="var-label">${variable}</div>
                      <div class="var-value">
                        <sl-input size="small" type="text" value="${defaultValue}"></sl-input>
                      </div>
                   </div>`
    })
    this.itemTarget.innerHTML = template
  }

}
