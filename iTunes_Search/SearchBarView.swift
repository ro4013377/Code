//
//  SearchBarView.swift
//  iTunes_Search
//
//  Created by Rohit Agrawal on 02/05/21.
//  Copyright © 2021 Rohit Agrawal. All rights reserved.
//

import SwiftUI


//  In SwiftUI,  search bar is not available  , so we have to  build a bridge between  UIKIT and  SwiftUI  using UIViewRepresentable Protocol.


struct SearchBarView: UIViewRepresentable {

    @Binding var searchBarText : String

    class Coordinator : NSObject, UISearchBarDelegate
    {
        @Binding var searchBarValue: String

        init(text:Binding<String>)
        {
            _searchBarValue = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            searchBarValue = searchText
            // update list view , when searchText updates
        }
        
//        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//            <#code#>
//        }

    }

    func makeCoordinator() -> Coordinator {
          return Coordinator(text: $searchBarText)
      }

    func makeUIView(context: Context) -> UISearchBar {

        let searchBar = UISearchBar(frame: .zero)
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = context.coordinator
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = searchBarText
    }

    typealias UIViewType = UISearchBar

}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchBarText: .constant("test"))
    }
}
