//
//  ApiCall.swift
//  iTunes_Search
//
//  Created by Rohit Agrawal on 02/05/21.
//  Copyright © 2021 Rohit Agrawal. All rights reserved.
//

import Foundation

class ApiCall {
    
    func getUserData(searchTerm: String, completion:@escaping ([Result]) -> ()) {
        
    //  guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else { return }
   
   //   https://itunes.apple.com/search?term=frozen    -   trackId is not coming in all 50 records - see
        
        
        guard let url = buildUrl(forTerm: searchTerm) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let data = try! JSONDecoder().decode( Response.self, from: data!)
            print(data)
            print(data.results.count)
            
            DispatchQueue.main.async {
                completion(data.results)
            }
        }
        .resume()
    }
    
    
    private func buildUrl(forTerm searchTerm: String) -> URL? {
        
      guard !searchTerm.isEmpty else { return nil }

      let queryItems = [
        URLQueryItem(name: "term", value: searchTerm),
         URLQueryItem(name: "entity", value: "song"),
      ]
        
      var components = URLComponents(string: "https://itunes.apple.com/search")
      components?.queryItems = queryItems

      return components?.url
    }

    
    
}
