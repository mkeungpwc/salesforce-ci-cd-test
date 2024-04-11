import { LightningElement, track } from 'lwc';
import getStockData from '@salesforce/apex/StockController.getStockData';

export default class StockPrice extends LightningElement {
    @track stockSymbol;
    @track latestprice;
    @track error;

    handleSymbolChange(event) {
        this.stockSymbol = event.target.value;
    }

    handleClick() {
        getStockData({ symbol: this.stockSymbol })
            .then(result => {
                this.error = undefined;
                this.latestprice = JSON.parse(result);
            })
            .catch(error => {
                this.error = error.body.message;
                this.latestprice = undefined;
            });
    }
}