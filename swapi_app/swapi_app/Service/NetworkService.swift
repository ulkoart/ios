//
//  NetworkService.swift
//  swapi_app
//
//  Created by Andrew on 21/04/2019.
//  Copyright © 2019 SPbSTU. All rights reserved.
//

import Alamofire
import Foundation

class NetworkService: ServiceProtocol {
    
    public var requestUrl: String? = "https://swapi.co/api/people"
    
    func getPage(_ completionHandler: @escaping (([Person]) -> Void)) {
        guard let currentUrl = self.requestUrl else { return }
        Alamofire.request(currentUrl).responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let parsedPage = try? jsonDecoder.decode(Page.self, from: data)
                guard let page = parsedPage else { return }
                self.requestUrl = page.next
                completionHandler(page.results)
            case .failure(let error):
                print("Something went wrong: \(error)")
                //TODO: present Alert?
            }
        }
    }
}
