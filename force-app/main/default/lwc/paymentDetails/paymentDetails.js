import { LightningElement, api, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const STRIPE_API_KEY = 'sk_test_YOUR_API_KEY';

export default class PaymentDetails extends LightningElement {
    cardNumber;
    expirationDate;
    cvv;
    amount;    

    updateCardNumber(event) {
      this.cardNumber = event.target.value;
    }

    updateExpirationDate(event) {
      this.expirationDate = event.target.value;
    }

    updateCVV(event) {
      this.cvv = event.target.value;
    }

    updateAmount(event) {
      this.amount = event.target.value;
    }

    handlePayment() {
    // create a payment object to pass to the Stripe API
      const payment = {
        cardNumber: this.cardNumber,
        expirationDate: this.expirationDate,
        cvv: this.cvv,
        amount: this.amount
      };

      // make a POST request to the Stripe API to process the payment
      fetch('https://api.stripe.com/v1/charges', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': `Bearer ${STRIPE_API_KEY}`
        },
        body: new URLSearchParams({
          amount: payment.amount,
          currency: 'USD',
          description: 'Test Payment',
          source: payment.cardNumber
        }).toString()
      })
        .then(response => {
          console.log(response); // log the response to the console
          
          if (response.ok) {
            // payment succeeded, show success toast
            const evt = new ShowToastEvent({
              title: 'Payment Successful',
              message: 'Your payment has been successfully processed.',
              variant: 'success'
            });
            this.dispatchEvent(evt);
          } else {
            // payment failed, show error toast
            const evt = new ShowToastEvent({
              title: 'Payment Failed',
              message: 'There was an error processing your payment. Please try again.',
              variant: 'error'
            });
            this.dispatchEvent(evt);
          }
        })
        .catch(error => {
          // an error occurred, show error toast
          const evt = new ShowToastEvent({
            title: 'Error',
            message: error.toString(),
            variant: 'error'
            });
            this.dispatchEvent(evt);
            });
          }
      }

/*
        const evt = new ShowToastEvent({
          title: 'Payment Submitted',
          message: 'Your payment has been successfully submitted.',
          variant: 'success'
        });
        this.dispatchEvent(evt);
*/

      // simulate processing payment
      // console.log('Processing payment...');