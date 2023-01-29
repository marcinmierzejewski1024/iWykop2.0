//
//  ApiCreditentialsProvider.swift
//  iWykop2.0
//
//  Created by Marcin Mierzejewski on 29/01/2023.
//

import Foundation

protocol ApiV3CreditentialsProviderProtocol {
    var keyAndSecret: (String, String) { get }
}

final class ApiV3CreditentialsProvider: ApiV3CreditentialsProviderProtocol {
    
    var keyAndSecret: (String, String) {
        (getValueFromCreditentialPlist("appKey") ?? "", getValueFromCreditentialPlist("appSecret") ?? "")
    }
    
    func getValueFromCreditentialPlist(_ key: String) -> String? {
        let path = Bundle.main.path(forResource: "apiCreditentials", ofType: "plist")!
        let entries = NSDictionary(contentsOfFile: path)!
        return entries[key] as? String;
    }
}

