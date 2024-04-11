import { LightningElement } from 'lwc';

export default class MultiPageComponent extends LightningElement {
  inputValuePageOne = '';
  inputValuePageTwo = '';
  showPageOne = true;
  showPageTwo = false;
  showPageThree = false;

  handleInputChangePageOne(event) {
    this.inputValuePageOne = event.detail;
  }
  
  handleInputChangePageTwo(event) {
    this.inputValuePageTwo = event.detail;
  }

  handleSave() {
    //save the inputValuePageOne and inputValuePageTwo
  }

  handleSubmit() {
    //handle form submission
  }

  handleNavigate(event) {
    const page = event.detail;
    if (page === 'pageone') {
      this.showPageOne = true;
      this.showPageTwo = false;
      this.showPageThree = false;
    } else if (page === 'pagetwo') {
      this.showPageOne = false;
      this.showPageTwo = true;
      this.showPageThree = false;
    }
    else if (page === 'pagethree') {
      this.showPageOne = false;
      this.showPageTwo = false;
      this.showPageThree = true;
    }
  }
}