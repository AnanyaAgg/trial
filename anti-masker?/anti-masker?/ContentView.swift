//
//  ContentView.swift
//  anti-masker?
//
//  Created by Ananya Aggarwal on 3/27/22.
//

import SwiftUI
import Alamofire
import SwiftyJSON

struct ContentView: View {
    @State var animalName = " "
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage? = UIImage(named: "mask")
    @State private var buttonLabel = "What type of mask is this?"
    
    let messages = ["KN95": "KN96 - ...",
                    "surgical": "Surgical Mask - ...",
                    "cloth": "Cloth Mask - ...",
                    "N95": "N95 - ..."]
    
    var body: some View {
        ZStack{
            Color(red:2, green:40, blue:33)
            HStack {
            VStack (alignment: .center,
                    spacing: 20){
                Text("Mast Mask")
                    .font(.system(.largeTitle))
                    .fontWeight(.bold)
                        Text(animalName)
                        Image(uiImage: inputImage!).resizable()
                            .aspectRatio(contentMode: .fit)
                        //Text(animalName)
                        Button (buttonLabel){
                            self.buttonPressed()
                        }
                        .font(.system(size:20))
                        .padding(.all, 14.0)
                        .foregroundColor(.white)
                            .background(Color.black)
                        .cornerRadius(10)
            }
            .font(.title)
        }.sheet(isPresented: $showingImagePicker, onDismiss: processImage) {
            ImagePicker(image: self.$inputImage)
        }
            
        }
    }
    
    func buttonPressed() {
        print("Button pressed")
        self.showingImagePicker = true
    }
    
    func processImage() {
        self.showingImagePicker = false
        self.animalName="Checking..."
        guard let inputImage = inputImage else {return}
        print("Processing image due to Button press")
        let imageJPG=inputImage.jpegData(compressionQuality: 0.0034)!
        let imageB64 = Data(imageJPG).base64EncodedData()
        let uploadURL="https://askai.aiclub.world/60ee3104-ef5b-4305-a670-5711874d516d"
        
        AF.upload(imageB64, to: uploadURL).responseJSON { response in
            
            debugPrint(response)
            switch response.result {
               case .success(let responseJsonStr):
                   print("\n\n Success value and JSON: \(responseJsonStr)")
                   let myJson = JSON(responseJsonStr)
                let predictedValue = myJson["predicted_label"].string
                   print("Saw predicted value \(String(describing: predictedValue))")

                   let predictionMessage = messages[predictedValue!]
                   self.animalName = predictionMessage!
                self.buttonLabel = "upload another image"
               case .failure(let error):
                   print("\n\n Request failed with error: \(error)")
               }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
