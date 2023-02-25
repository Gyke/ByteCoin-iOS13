//
//  CoinManagerDelegate.swift
//  ByteCoin
//
//  Created by Константин Стольников on 25.02.2023.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation


protocol CoinManagerDelegate {
    func didUpdateCoin(_ coinManager: CoinManager, coin: CoinModel)
    func didFailWithError(error: Error)
}
