//
//  ApiManager.swift
//  MittalDhwani-Sem-7-037
//
//  Created by Manthan Mittal on 23/12/2024.
//

import Foundation
import Alamofire

class ApiManager{
    
   let urlstr="https://api.thecatapi.com/v1/images/search?limit=10"
    
    func fetchCats(completionHandler: @escaping(Result<[CatModel],Error>)-> Void) {
        
      
        
        AF.request(urlstr).responseDecodable(of: [CatModel].self){response in
            switch response.result{
                
            case.success(let data):
                completionHandler(.success(data))
                
            case.failure(let error):
                completionHandler(.failure(error))
                
        
        
    }
        
        }
    }
}
