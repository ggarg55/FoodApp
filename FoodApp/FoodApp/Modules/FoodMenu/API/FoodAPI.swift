//
//  FoodAPI.swift
//  FoodApp
//
//  Created by Gourav Garg on 01/11/20.
//  Copyright © 2020 Gourav Garg. All rights reserved.
//

import Foundation
import Alamofire
import Moya

enum FoodAPI {
    case getFoodCategories(_ cat: String?)
    case getFoodList(subCat: String)
}

extension FoodAPI: TargetType  {
    var baseURL: URL {
        let url = kHostAddress
        return URL(string: url)!
    }
    
    var path: String {
        switch self {
        case .getFoodCategories(let cat):
            debugPrint(cat ?? "catgory is empty")
            return kCategories
        case .getFoodList(let subCat):
            return "\(kCategories)/\(subCat)"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        .get
    }
    
    var sampleData: Data {
        switch self {
        case .getFoodCategories:
            if let data = FAJSONParser<CategoryData>().getFileData(path: kCategories) {
                return data
            }
        case .getFoodList(let path):
            if let data = FAJSONParser<CategoryData>().getFileData(path: path) {
                return data
            }
        }
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        nil
    }
    
}
