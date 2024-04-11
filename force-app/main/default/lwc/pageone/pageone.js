import { LightningElement, api } from 'lwc';

export default class PageOne extends LightningElement {
  @api inputValuePageOne = '';

  handleInputChangePageOne(event) {
    this.inputValuePageOne = event.target.value;
    this.dispatchEvent(new CustomEvent('inputchangepageone', { detail: this.inputValuePageOne }));
  }

  handleSave() {
    // save the inputValuePageOne
  }

  navigateToPageTwo() {
    // navigate to Page Two component
    this.dispatchEvent(new CustomEvent('navigate', { detail: 'pagetwo' }));
  }
}