import { LightningElement, api } from 'lwc';

export default class PageTwo extends LightningElement {
  @api inputValuePageTwo = '';

  handleInputChangePageTwo(event) {
    this.inputValuePageTwo = event.target.value;
    this.dispatchEvent(new CustomEvent('inputchangepagetwo', { detail: this.inputValuePageTwo }));
  }

  handleSave() {
    // save the inputValuePageTwo
  }

  navigateToPageOne() {
    // navigate to Page One component
    this.dispatchEvent(new CustomEvent('navigate', { detail: 'pageone' }));
  }

  navigateToPageThree() {
    // navigate to Page Three component
    this.dispatchEvent(new CustomEvent('navigate', { detail: 'pagethree' }));
  }
}