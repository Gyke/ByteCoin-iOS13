//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "73F48A9C-84F7-4724-A4E4-9F699A976645"
    
    var delegate: CoinManagerDelegate?
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    
    func getFetchUrl(for quote: String) -> URL? {
        return URL(string: "\(baseURL)/\(quote)?apikey=\(apiKey)")
    }
    
    func createSession(with url: URL) -> URLSession {
        return URLSession(configuration: .default)
    }
    
    func startTask(for session: URLSession, with url: URL) {
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                delegate?.didFailWithError(error: error)
                return
            }
            if let data = data {
                if let coin = parseJSON(data) {
                    delegate?.didUpdateCoin(self, coin: coin)
                }
            }
        }
        task.resume()
    }
    
    func getCoinPrice(for currency: String) {
        if let fetchURL = getFetchUrl(for: currency) {
            let session = createSession(with: fetchURL)
            startTask(for: session, with: fetchURL)
        }
    }
    
    func parseJSON(_ coinData: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            let coin = CoinModel(time: decodedData.time, asset_id_base: decodedData.asset_id_base, asset_id_quote: decodedData.asset_id_quote, rate: decodedData.rate)
            return coin
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
