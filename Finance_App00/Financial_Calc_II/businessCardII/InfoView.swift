//
//  InfoViw.swift
//  businessCardII
//
//  Created by a-robota on 4/19/22.
//

import SwiftUI



struct InfoView: View {
    let text: String
    let imageName: String
    let URL = "https://github.com/elithaxxor"
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(height:50)
            .foregroundColor(.white)
            .overlay(HStack { Text(text).foregroundColor(.blue);
                Image(systemName: imageName).onOpenURL { url in
                URL
                    print(url, URL, text)

            } // from FSfonts
                    .accentColor(.blue)
                    .border(Color.white, width: 3)
                    .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
            }).padding(.all)
    }

}
struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(text: "Elit_Scammer", imageName: "wsb")
    }
}

