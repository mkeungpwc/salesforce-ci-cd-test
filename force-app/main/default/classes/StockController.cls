public with sharing class StockController {
    @AuraEnabled(cacheable=true)
    public static String getStockData(String symbol) {
        symbol = symbol.toUpperCase();
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setEndpoint('https://query1.finance.yahoo.com/v8/finance/chart/' + symbol);
        req.setTimeout(60000);
        HttpResponse res = h.send(req);
        
        System.debug('response: ' + res);
        
        if(res.getStatusCode() != 200){
            System.debug('Error getting stock data for symbol: ' + symbol);
            return null;
        }
        
        Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
        System.debug('responseMap: ' + responseMap);
        
        Map<String, Object> chart = (Map<String, Object>) responseMap.get('chart');
        System.debug('chart: ' + chart);
        
        if(chart == null){
            System.debug('Error getting chart data for symbol: ' + symbol);
            return null;
        }
        
        List<Object> result = (List<Object>) chart.get('result');
        System.debug('result: ' + result);
        
        if (result == null || result.isEmpty()) {
            System.debug('Error getting result data for symbol: ' + symbol);
            return null;
        }
        
        Map<String, Object> firstResult = (Map<String, Object>) result.get(0);
        System.debug('firstResult: ' + firstResult);
        
        Map<String, Object> meta = (Map<String, Object>) firstResult.get('meta');
        System.debug('meta: ' + meta);
        
        if(meta == null){
            System.debug('Error getting meta data for symbol: ' + symbol);
            return null;
        }
        
        Double regularMarketPrice = (Double) meta.get('regularMarketPrice');
        System.debug('regularMarketPrice: ' + regularMarketPrice);
        
        Map<String, Object> stockData = new Map<String, Object>();
        stockData.put('symbol', symbol);
        stockData.put('regularMarketPrice', regularMarketPrice);
        stockData.put('exchangeName', (String) meta.get('exchangeName'));
        stockData.put('currency', (String) meta.get('currency'));
        
        System.debug('stockData: ' + stockData);
        
        return JSON.serialize(stockData);
    }
}