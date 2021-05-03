//
//  ContentView.swift
//  iTunes_Search
//
//  Created by Rohit Agrawal on 02/05/21.
//  Copyright © 2021 Rohit Agrawal. All rights reserved.


// TableView in SwiftUI =  List
 

import SwiftUI

extension String {
    
    func load() -> UIImage {
        
        do {
            guard let url = URL(string: self) else {
                return UIImage()
            }
            let data: Data = try Data(contentsOf: url)
            return UIImage(data:data) ?? UIImage()
        } catch  {
            
        }
        return UIImage()
    }
}


struct ContentView: View {
    
    @State var results = [Result]()
    @State  var seachBarText: String =  "frozen"
    
    var body: some View {
        NavigationView {
            
            VStack {
                
                SearchBarView(searchBarText: $seachBarText)
                
                List {
                    
                    ForEach(results,id:  \.trackId) {   gr in
                        
                        Section(header:
                            Text("Section A  - \(gr.name)")
                                
                                .foregroundColor(.purple)
                                .fontWeight(.bold)
                                .font(.headline)
                        ) {
                            
                            ForEach(self.results.filter({ self.seachBarText.isEmpty ? true : $0.trackName.localizedCaseInsensitiveContains(self.seachBarText)
                                
                            }), id: \.trackId) {
                                item in
                                
                                HStack {
                                    Image(uiImage: item.artwork.load())
                                    VStack(alignment: .leading) {
                                        Text(" Track Name  - \(item.trackName)")
                                            .font(.headline)
                                            .fontWeight(.bold)
                                        
                                        Text(" Genre : - \(item.genre)")
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.red)
                                        
                                    }.padding()
                                    Button(action: {
                                        print("this item is Favourited - Implement ")
                                    }) {
                                        HStack(spacing: 20) {
                                            Image(systemName: "heart.fill")
                                            
                                        }
                                    }
                                    
                                }
                            }
                        }
                    }
                    
                }.onAppear() {
                    
                    ApiCall().getUserData(searchTerm: self.seachBarText) { (results) in
                        
                    // Initially , seachBarText will be empty , so nothing displays, we need to update list , whenever  we enter searchText. -  use ObservableObject  - Explore on that.
                        
                        self.results = results
                    }
                    
                }.navigationBarTitle("iTunes Search")
                 .listStyle(GroupedListStyle())
                
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
