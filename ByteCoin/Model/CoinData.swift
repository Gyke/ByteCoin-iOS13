//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Константин Стольников on 25.02.2023.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData: Decodable{
    let time           : String
    let asset_id_base  : String
    let asset_id_quote : String
    let rate           : Float
}
