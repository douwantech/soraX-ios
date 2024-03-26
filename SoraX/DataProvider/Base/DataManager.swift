//
//  DataManager.swift
//  FaceSwap
//
//  Created by apple on 8/10/23.
//

import Foundation

struct DataManager {
    
    static private var currentDataProvider: DataProvider = NetworkDataProvider()

    
    static func setDataProvider(dataProvider: DataProvider){
        currentDataProvider = dataProvider
    }
    
    static var dataProvider: DataProvider {
        get {
            return currentDataProvider
        }
    }
    
}
