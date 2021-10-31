//
//  NetworkUtils.swift
//  Trivial
//
//  Created by BarisOdabasi on 12.12.2020.
//

import Alamofire
import SwiftyJSON

class NetworkUtils {
    
    func fetchQuestion(completionHandler: @escaping (_ result: QuestionData?, _ error: String?) -> Void) {
        AF.request("https://opentdb.com/api.php?amount=2&difficulty=easy&type=multiple").response { response in
            debugPrint(response)
            switch response.result {
            case .success(let jsonResult):
                print("fetchQuestion Response : \(jsonResult!)")
                do{
                    let questionResponse = try JSONDecoder().decode(QuestionResponse.self, from: try JSON(jsonResult!).rawData())
                    completionHandler(questionResponse.results.first, nil)
                } catch let error{
                    print("fetchQuestion Json Parse Error : \(error)")
                    completionHandler(nil, "Filed to fetch question")
                }
            case .failure(let error):
                print("fetchQuestion Request failed with error: \(error)")
                completionHandler(nil, "Filed to fetch question")
            }
        }
    }
    
}
