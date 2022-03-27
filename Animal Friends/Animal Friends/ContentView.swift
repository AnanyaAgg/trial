//
//  ContentView.swift
//  Animal Friends
//
//  Created by Ananya Aggarwal on 3/13/22.
//

import SwiftUI
import SwiftyJSON
import Alamofire

struct ContentView: View {
    @State var animalName = ""
    @State var showingImagePicker = false
    @State var inputImage: UIImage? = UIImage(named: "image")
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
