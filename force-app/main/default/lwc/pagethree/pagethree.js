import { LightningElement, api } from 'lwc';

export default class PageThree extends LightningElement {
  @api inputValuePageOne = '';
  @api inputValuePageTwo = '';

  
  navigateToPageOne() {
    // navigate to Page One component
    this.dispatchEvent(new CustomEvent('navigate', { detail: 'pageone' }));
  }

  navigateToPageTwo() {
    // navigate to Page Two component
    this.dispatchEvent(new CustomEvent('navigate', { detail: 'pagetwo' }));
  }


  handleSubmit() {
    // handle form submission
  }

}