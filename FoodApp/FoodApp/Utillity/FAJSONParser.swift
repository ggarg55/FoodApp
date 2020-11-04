//
//  FAJSONParser.swift
//  FoodApp
//
//  Created by Gourav Garg on 01/11/20.
//  Copyright © 2020 Gourav Garg. All rights reserved.
//

import Foundation
import RxSwift

enum JsonParsingError: Error {
    case badURL
    case unknownError(Error)
}

struct FAJSONParser<T: Codable> {
   let disposeBag = DisposeBag()
   var jsonFilePath: String?

    func getDataFromJsonFile(path: String) -> Single<T> {
        return Single<T>.create { (single) in
            let fileURL = Bundle.main.url(forResource: path, withExtension: kJsonExtString)
            guard let url = fileURL else {
                single(.error(JsonParsingError.badURL))
                return Disposables.create()
            }
            do {
                let data = try Data(contentsOf: url)
                let decodedData = self.decodeData(json: data)
                decodedData.subscribe(onSuccess: {
                    single(.success($0))
                }) {
                    single(.error($0))
                }.disposed(by: self.disposeBag)
            } catch {
                single(.error(error))
            }
            return Disposables.create()
        }
    }
    
    func decodeData(json: Data) -> Single<T> {
        let decoder = JSONDecoder()
        return Single<T>.create { single in
            do {
                let concreteObject = try decoder.decode(T.self, from: json)
                single(.success(concreteObject))
            } catch {
                single(.error(error))
            }
            return Disposables.create()
        }
    }
    
     func getData(path: String, completion:  @escaping (Result<T, JsonParsingError>) -> Void) {
         let fileURL = Bundle.main.url(forResource: path, withExtension: kJsonExtString)
         guard let url = fileURL else {
             completion(.failure(JsonParsingError.badURL))
             return
         }
         do {
             let data = try Data(contentsOf: url)
             decodeJsonObject(jsonObject: data, completion: completion)
         } catch {
             debugPrint(error.localizedDescription)
             completion(.failure(JsonParsingError.unknownError(error)))
         }
     }

    func decodeJsonObject(jsonObject: Data, completion:  @escaping (Result<T, JsonParsingError>) -> Void) {
        let decoder = JSONDecoder()
        do {
            let concreteObject = try decoder.decode(T.self, from: jsonObject)
            completion(.success(concreteObject))
        } catch {
            completion(.failure(JsonParsingError.unknownError(error)))
        }
    }
    
    func getFileData(path: String) -> Data? {
        let fileURL = Bundle.main.url(forResource: path, withExtension: kJsonExtString)
        guard let url = fileURL, let data = try? Data(contentsOf: url) else {
            return nil
        }
        return data
    }
}
